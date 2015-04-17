from peewee import *
from peewee import EnclosedClause
from datetime import datetime

# Exported names
__all__ = [
    'db','faf_orm_init_db',
    'User',
    'OAuthClient', 'OAuthGrant', 'OAuthToken',
    'Avatar','UserAvatar',
    'Ladder1v1Rating','GlobalRating',
    'RepoVersion','DefaultVersion',
    'Map','MapNoRushOffset','MapVersion','MapNote',
    'MapProp', 'MapEditorIcon', 'MapMarker',
    'DoesNotExist'
]

# DB is uninitialized. Initialize it at runtime
db = Proxy()

def faf_orm_init_db(database):
    db.initialize(database)
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
    "User model."
    class Meta:
        db_table = 'login'

    # This thing is full of crap

    login = CharField()
    password = CharField()

    email = CharField()

    ip = CharField(15)
    uniqueId = CharField()

    session = IntegerField()
    validated = BooleanField()

    steamid = IntegerField(null=True)
    steamchecked = BooleanField()
    ladderCancelled = IntegerField()

# ========== OAuth2 Models ==========

class OAuthClient(LobbyModel):
    "Represents a Client in OAuth2"
    class Meta:
        db_table = 'oauth_client'

    author = ForeignKeyField(User, null=True, on_delete='CASCADE')

    name = CharField(32)
    description = CharField()

    client_id = CharField(primary_key=True)
    client_secret = CharField()
    client_type = CharField()

    _allowed_grant_types = TextField()

    _redirect_uris = TextField()
    _default_scopes = CharField()

    @property
    def allowed_grant_types(self):
        if self._allowed_grant_types:
            return self._allowed_grant_types.split()
        return []

    @property
    def redirect_uris(self):
        if self._redirect_uris:
            return self._redirect_uris.split()
        return []

    @property
    def default_redirect_uri(self):
        return self.redirect_uris[0]

    @property
    def default_scopes(self):
        if self._default_scopes:
            return self._default_scopes.split()
        return []

class OAuthGrant(LobbyModel):
    "Represents a Grant in OAuth2"
    class Meta:
        db_table = 'oauth_grant'

    user = ForeignKeyField(User, related_name='oauth_grants', on_delete='CASCADE')

    client = ForeignKeyField(OAuthClient, related_name='grants', on_delete='CASCADE')

    code = CharField()

    _scopes = TextField()

    expires = TimeStampField()

    redirect_uri = CharField()

    @property
    def scopes(self):
        if self._scopes:
            return self._scopes.split()
        return []

class OAuthToken(LobbyModel):
    "Represents a Token in OAuth2"
    class Meta:
        db_table = 'oauth_token'

    user = ForeignKeyField(User, related_name='oauth_tokens', on_delete='CASCADE')

    client = ForeignKeyField(OAuthClient, related_name='tokens', on_delete='CASCADE')

    # Token is always Bearer

    access_token = CharField(index=True)
    refresh_token = CharField(index=True)

    _scopes = TextField()

    expires = TimeStampField()

    @property
    def scopes(self):
        if self._scopes:
            return self._scopes.split()
        return []

# ========== Avatars ==========

class Avatar(LobbyModel):
    class Meta:
        db_table = 'avatars_list'

    url = CharField()
    tooltip = CharField(null=True)

class UserAvatar(LobbyModel):
    class Meta:
        db_table = 'avatars'

    # CRAAAAAAP

    user = ForeignKeyField(User, related_name='avatars', db_column='idUser')
    avatar = ForeignKeyField(Avatar, db_column='idAvatar')
    selected = BooleanField()

# ======= Rating Models =======

class Ladder1v1Rating(LobbyModel):
    class Meta:
        db_table = 'ladder1v1_rating'

    id = ForeignKeyField(User, related_name='ladder1v1', primary_key=True,
                         db_column='id', on_delete='CASCADE')

    mean = FloatField()
    deviation = FloatField()
    numGames = IntegerField()
    winGames = IntegerField()
    is_active = BooleanField()

class GlobalRating(LobbyModel):
    class Meta:
        db_table = 'global_rating'

    id = ForeignKeyField(User, related_name='global', primary_key=True,
                         db_column='id', on_delete='CASCADE')

    mean = FloatField()
    deviation = FloatField()
    numGames = IntegerField()
    is_active = BooleanField()

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

    ver_engine = ForeignKeyField(RepoVersion,related_name='defaultver_eng')
    ver_main_mod = ForeignKeyField(RepoVersion,related_name='defaultver_mod')

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

# ======= Clan Models ========

class Clan(LobbyModel):
    class Meta:
        schema = 'fafclans'
        db_table = 'clans_list'

    name = CharField(db_column='clan_name')
    tag = CharField(3, null=True, db_column='clan_tag')

    description = TextField(db_column='clan_desc')

    founder = ForeignKeyField(User, null=True, db_column='clan_founder_id')

    create_date = TimeStampField()
    status = BooleanField() # ?!?!

class ClanMember(LobbyModel):
    class Meta:
        schema = 'fafclans'
        db_table = 'clan_members'

    clan = ForeignKeyField(Clan)

    player = ForeignKeyField(User, primary_key=True)

    join_date = TimeStampField(db_column='join_clan_date')

    rank = CharField(20, db_column='clan_rank')

__all__ += ['Clan','ClanMember']

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
