
from ._base import *

# ======= Base Version Models ========

class RepoVersion(LobbyModel):
    "Represents a specific version of a git repository."
    class Meta:
        db_table = 'version_repo'

    type = CharField()
    name = CharField(128)

    repo = CharField(128)
    ref  = CharField(32)
    url  = CharField(null=True)
    hash = CharField(64, null=True)

    time_added = TimeStampField()

class DefaultVersion(LobbyModel):
    """
    Represents a 'default' choice of mod version to play a _mod_
    i.e. Newest 'faf'
    """
    class Meta:
        db_table = 'version_default'

    mod = CharField(45,index=True)
    name = CharField(45)

    ver_engine = ForeignKeyField(RepoVersion, 'defaultver_eng')
    ver_main_mod = ForeignKeyField(RepoVersion, 'defaultver_mod')

    time_added = TimeStampField()

__all__ = [
    'RepoVersion', 'DefaultVersion'
]