from peewee import *
from datetime import datetime

# Exported names
__all__ = [
    'db',
    'User',
    'RepoVersion','DefaultVersion',
    'Map','MapNoRushOffset','MapVersion','MapNote',
    'MapProp', 'MapEditorIcon', 'MapMarker',
    'DoesNotExist'
]

# DB is uninitialized. Initialize it at runtime with config, before db.connect()
db = MySQLDatabase(None)

db.field_overrides['primary_key'] = 'INTEGER UNSIGNED AUTO_INCREMENT'
db.field_overrides['uint'] = 'INTEGER UNSIGNED'

# Unbreak foreign key type
def _ForeignKeyField_get_db_field(self):
    if not isinstance(self.to_field, PrimaryKeyField):
        return self.to_field.get_db_field()
    return "uint"

ForeignKeyField.get_db_field = _ForeignKeyField_get_db_field

class TimeStampField(DateTimeField):
    db_field = 'time'


class LobbyModel(Model):
    "Base Model"
    class Meta:
        database = db

    # Peewee identifiers clash
    save_ = Model.save

    def dict(self):
        "Jsonize the model instance to dict"

        def to_json(value):
            if isinstance(value,datetime):
                return value.isoformat()
            else:
                return value

        return { k:to_json(v) for k,v in self._data.items()}

# ============ Models follow ==================

class User(LobbyModel):
    "User model. Currently dummy."
    class Meta:
        db_table = 'login'

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

    ver_engine = ForeignKeyField(RepoVersion)
    ver_main_mod = ForeignKeyField(RepoVersion)

    time_added = TimeStampField()

# ======= Game Map Models ======
# These classes are inferred from SCMP_001_scenario.lua from vanilla supcom

class Map(LobbyModel):
    class Meta:
        db_table = 'map'

    name = CharField()
    description = TextField()

    type = CharField()
    starts = BooleanField()
    preview = CharField()

    size_x = IntegerField()
    size_y = IntegerField()

    norushradius = DoubleField()

    max_players = IntegerField(default=0)

    # Not strictly necessary
    map = CharField() # .scmap
    save = CharField() #_save.lua
    script = CharField() #_script.lua

    # Non-_scenario.lua attributes
    ident = CharField(64, index=True, unique=True)

    author = IntegerField(null=True)#ForeignKeyField(User)#, null=True, on_delete='SET NULL')

    time_added = TimeStampField()
    time_updated = TimeStampField()

class MapNoRushOffset(LobbyModel):
    class Meta:
        db_table = 'map_norushoffset'

    map = ForeignKeyField(Map, on_delete='CASCADE')

    army = CharField(8) #ARMY_1

    offset_x = DoubleField()
    offset_y = DoubleField()

class MapVersion(LobbyModel):
    class Meta:
        db_table = 'map_version'

    map = ForeignKeyField(Map, on_delete='CASCADE')

    ver = ForeignKeyField(RepoVersion)

class MapNote(LobbyModel):
    class Meta:
        db_table = 'map_note'

    map = ForeignKeyField(Map, on_delete='CASCADE')

    tag = CharField()

    text = CharField()

# Gpg Map Resources
class MapProp(LobbyModel):
    class Meta:
        db_table = 'map_prop'

    # filename to .bp
    # i.e. '/env/common/props/markers/M_Expansion_prop.bp'
    prop = CharField()

class MapEditorIcon(LobbyModel):
    class Meta:
        db_table = 'map_editor_icon'

    editorIcon = CharField()

class MapMarker(LobbyModel):
    class Meta:
        db_table = 'map_marker'

    map = ForeignKeyField(Map, related_name='markers', on_delete='CASCADE')

    type = CharField(32)

    hint = BooleanField(default=False)
    resource = BooleanField(default=False)

    size = FloatField(default=0.0)

    amount = FloatField(default=0.0)

    color = CharField(8)

    graph = CharField(32)

    orientation_x = FloatField(default=0.0)
    orientation_y = FloatField(default=0.0)
    orientation_z = FloatField(default=0.0)

    position_x = FloatField(default=0.0)
    position_y = FloatField(default=0.0)
    position_z = FloatField(default=0.0)

    prop = ForeignKeyField(MapProp, null=True)
    editorIcon = ForeignKeyField(MapEditorIcon, null=True)

# Compatibility Map filename remap table
class MapFileRemap(LobbyModel):
    class Meta:
        db_table = 'map_compat_file_remap'

    zip_from = CharField(unique=True)
    map_ident = CharField()
    map_ver = IntegerField()

__all__ += ['MapFileRemap']

# ====== Engine Patching Models =======

class EngineHash(LobbyModel):
    class Meta:
        db_table = 'engine_hash'

    exe_hash = CharField(32)
    repo_version = ForeignKeyField(
        RepoVersion, related_name='eng_hash', on_delete='CASCADE')

class EnginePatch(LobbyModel):
    class Meta:
        db_table = 'engine_patch'

    from_hash = ForeignKeyField(EngineHash,related_name='patch',on_delete='CASCADE')
    to_hash = ForeignKeyField(EngineHash, on_delete='CASCADE')

    patch = BlobField()

__all__ += ['EngineHash','EnginePatch']

# ====== Game Mod Models ======

class Mod(LobbyModel):
    class Meta:
        db_table = 'mod'

    maintainer = IntegerField(null=True)#ForeignKeyField(User, null=True)

    # From mod_info.lua
    uid = CharField(64, null=True) # Latest uid

    name = CharField(128, index=True, unique=True)
    description = TextField()

    author = CharField(null=True)
    url = CharField(256, null=True)
    copyright = CharField(256, null=True)

    exclusive = BooleanField(default=False)
    ui_only = BooleanField(default=False)

    time_added = TimeStampField()
    time_updated = TimeStampField()

class ModVersion(LobbyModel):
    class Meta:
        db_table = 'mod_version'

    mod = ForeignKeyField(Mod, related_name='versions', on_delete='CASCADE')

    ver = ForeignKeyField(RepoVersion)

    uid = CharField(64, index=True)

class ModDepend(LobbyModel):
    class Meta:
        db_table = 'mod_depend'

    mod_ver = ForeignKeyField(ModVersion, related_name='depends', on_delete='CASCADE')
    depend = ForeignKeyField(ModVersion)

__all__ += ['Mod','ModDepend','ModVersion']

# ======= Utility table creation functions ========

def create_map_tables():
    for table in [Map,MapNoRushOffset,MapVersion,MapNote,
                  MapProp, MapEditorIcon, MapMarker]:
        table.create_table(fail_silently=True)

    # Required because peewee refuses to be useful.
    db.execute_sql(
        'alter table map '
        'modify column time_added TIMESTAMP default NOW()')

    db.execute_sql(
        'alter table map '
        'modify column time_updated TIMESTAMP on update NOW()')

def create_mod_tables():
    for table in [Mod,ModVersion,ModDepend]:
        table.create_table(fail_silently=True)

    # Required because peewee refuses to be useful.
    db.execute_sql(
        'alter table `mod` '
        'modify column time_added TIMESTAMP default NOW()')

    db.execute_sql(
        'alter table `mod` '
        'modify column time_updated TIMESTAMP on update NOW()')
