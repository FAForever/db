
from ._base import *
from .user import User
from .version import RepoVersion

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

    author = ForeignKeyField(User, null=True, on_delete='SET NULL')

    time_added = TimeStampField()
    time_updated = TimeStampField()

class MapNoRushOffset(LobbyModel):
    class Meta:
        db_table = 'map_norushoffset'

    map = ForeignKeyField(Map, related_name='norushoffset', on_delete='CASCADE')

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

__all__ = [
    'Map', 'MapNoRushOffset', 'MapVersion',
    'MapNote', 'MapProp', 'MapEditorIcon', 'MapMarker', 'MapFileRemap'
]

def create_map_tables():
    for table in [Map, MapNoRushOffset, MapVersion, MapNote,
                  MapProp, MapEditorIcon, MapMarker]:
        table.create_table(fail_silently=True)

    # Required because peewee refuses to be useful.
    db.execute_sql(
        'alter table map '
        'modify column time_added TIMESTAMP default NOW()')

    db.execute_sql(
        'alter table map '
        'modify column time_updated TIMESTAMP on update NOW()')