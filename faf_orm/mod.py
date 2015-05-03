
from ._base import *
from .user import User
from .version import RepoVersion
from .file import DBFile

# ====== Game Mod Models ======

class Mod(LobbyModel):
    class Meta:
        db_table = 'mod'

    maintainer = ForeignKeyField(User, null=True, on_delete='SET NULL')

    # From mod_info.lua
    uid = CharField(64, null=True) # Latest uid

    name = CharField(128, index=True, unique=True)
    description = TextField()

    author = CharField(null=True)
    url = CharField(256, null=True)
    copyright = CharField(256, null=True)

    exclusive = BooleanField(default=False)
    ui_only = BooleanField(default=False)

    icon = ForeignKeyField(DBFile,  null=True)

    time_added = TimeStampField()
    time_updated = TimeStampField()

class ModVersion(LobbyModel):
    class Meta:
        db_table = 'mod_version'

    mod = CascadeFKey(Mod, 'versions')

    ver = ForeignKeyField(RepoVersion)

    uid = CharField(64, index=True)

class ModDepend(LobbyModel):
    class Meta:
        db_table = 'mod_depend'

    mod_ver = CascadeFKey(ModVersion, 'depends')
    depend = ForeignKeyField(ModVersion)

__all__ = [
    'Mod', 'ModVersion', 'ModDepend'
]

def create_tables():
    for table in [Mod, ModVersion, ModDepend]:
        table.create_table(fail_silently=True)

    # Required because peewee refuses to be useful.
    db.execute_sql(
        'alter table `mod` '
        'modify column time_added TIMESTAMP default NOW()')

    db.execute_sql(
        'alter table `mod` '
        'modify column time_updated TIMESTAMP on update NOW()')