# coding: utf-8
from sqlalchemy import MetaData, BigInteger, Column, DateTime, Enum, Float, Integer, Numeric, SmallInteger, String, \
    Table, Text, Time, text, PrimaryKeyConstraint
from sqlalchemy.dialects.mysql.base import LONGBLOB
from sqlalchemy.ext.declarative import declarative_base

metadata = MetaData()


class MappingBase:
    """
    Base class for declarative mapping objects that
    allows use of them as if they are dictionaries.

    Only properties which are not None and for which the class attribute
    defines is_attribute to be True are used when considering the object
    as a mapping.
    """
    def items(self):
        for k in dir(self):
            if getattr(self, k) is not None \
                    and k in type(self).__dict__ \
                    and getattr(type(self).__dict__[k], 'is_attribute', False):
                yield k, getattr(self, k)

    def __iter__(self):
        for k, _ in self.items():
            yield k


Base = declarative_base(metadata=metadata, cls=MappingBase)

class AchievementDefinition(Base):
    __tablename__ = 'achievement_definitions'

    id = Column(String(36), primary_key=True)
    order = Column(Integer, nullable=False)
    name_key = Column(String(255), nullable=False)
    description_key = Column(String(255), nullable=False)
    type = Column(Enum('STANDARD', 'INCREMENTAL'), nullable=False)
    total_steps = Column(Integer)
    revealed_icon_url = Column(String(2000))
    unlocked_icon_url = Column(String(2000))
    initial_state = Column(Enum('HIDDEN', 'REVEALED'), nullable=False)
    experience_points = Column(Integer, nullable=False)


class AvatarUsers(Base):
    __tablename__ = 'avatars'

    id = Column(Integer, primary_key=True)
    idUser = Column(Integer, nullable=False)
    idAvatar = Column(Integer, nullable=False)
    selected = Column(Integer, nullable=False)


class Avatars(Base):
    __tablename__ = 'avatars_list'

    id = Column(Integer, primary_key=True)
    url = Column(String(255), nullable=False)
    tooltip = Column(String(50))


class BugreportStatus(Base):
    __tablename__ = 'bugreport_status'

    id = Column(Integer, primary_key=True)
    bugreport = Column(Integer, nullable=False)
    status_code = Column(Enum('unfiled', 'filed', 'dismissed'), nullable=False)
    url = Column(String(255))
    create_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))


class BugreportTarget(Base):
    __tablename__ = 'bugreport_targets'

    id = Column(String(255), primary_key=True)
    name = Column(String(255), nullable=False)
    ref = Column(String(255), nullable=False)
    url = Column(String(255), nullable=False)
    create_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    update_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class Bugreport(Base):
    __tablename__ = 'bugreports'

    id = Column(Integer, primary_key=True)
    title = Column(String(255), nullable=False)
    target = Column(String(255), nullable=False)
    automatic = Column(Integer, nullable=False)
    description = Column(Text)
    log = Column(Text)
    traceback = Column(Text)
    create_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    update_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))


class CoopLeaderboard(Base):
    __tablename__ = 'coop_leaderboard'

    id = Column(Integer, primary_key=True)
    mission = Column(SmallInteger, nullable=False)
    gameuid = Column(BigInteger, nullable=False)
    secondary = Column(Integer, nullable=False)
    time = Column(Time, nullable=False)


class CoopMap(Base):
    __tablename__ = 'coop_map'

    type = Column(Integer, nullable=False)
    id = Column(Integer, primary_key=True)
    name = Column(String(40))
    description = Column(String)
    version = Column(Numeric(4, 0))
    filename = Column(String(200))


t_email_domain_blacklist = Table(
    'email_domain_blacklist', metadata,
    Column('domain', String(255), nullable=False)
)


class EventDefinition(Base):
    __tablename__ = 'event_definitions'

    id = Column(String(36), primary_key=True)
    name_key = Column(String(255), nullable=False)
    image_url = Column(String(45))
    type = Column(Enum('NUMERIC', 'TIME'), nullable=False)


class FeaturedModsOwner(Base):
    __tablename__ = 'featured_mods_owners'

    id = Column(Integer, primary_key=True)
    uid = Column(Integer, nullable=False)
    moduid = Column(Integer, nullable=False)


class FriendsAndFoes(Base):
    __tablename__ = 'friends_and_foes'

    user_id = Column(Integer, primary_key=True, nullable=False)
    subject_id = Column(Integer, primary_key=True, nullable=False)
    status = Column(Enum('FRIEND', 'FOE'))


class GameFeaturedMod(Base):
    __tablename__ = 'game_featuredMods'

    id = Column(Integer, primary_key=True)
    gamemod = Column(String(50))
    description = Column(Text, nullable=False)
    name = Column(String(255), nullable=False)
    publish = Column(Integer, nullable=False, server_default=text("'0'"))
    order = Column(SmallInteger, nullable=False, server_default=text("'0'"))


class GamePlayerStats(Base):
    __tablename__ = 'game_player_stats'

    id = Column(BigInteger, primary_key=True)
    gameId = Column(BigInteger, nullable=False)
    playerId = Column(Integer, nullable=False)
    AI = Column(Integer, nullable=False)
    faction = Column(Integer, nullable=False)
    color = Column(Integer, nullable=False)
    team = Column(Integer, nullable=False)
    place = Column(Integer, nullable=False)
    mean = Column(Float, nullable=False)
    deviation = Column(Float, nullable=False)
    after_mean = Column(Float)
    after_deviation = Column(Float)
    score = Column(Integer, nullable=False)
    scoreTime = Column(DateTime)


class GameStats(Base):
    __tablename__ = 'game_stats'

    id = Column(Integer, primary_key=True)
    startTime = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    gameType = Column(Enum('0', '1', '2', '3'), nullable=False)
    gameMod = Column(Integer, nullable=False)
    host = Column(Integer, nullable=False)
    mapId = Column(Integer, nullable=False)
    gameName = Column(String(128), nullable=False)
    validity = Column(Integer, nullable=False)


class GlobalRating(Base):
    __tablename__ = 'global_rating'

    id = Column(Integer, primary_key=True)
    mean = Column(Float)
    deviation = Column(Float)
    numGames = Column(SmallInteger, nullable=False, server_default=text("'0'"))
    is_active = Column(Integer, nullable=False, server_default=text("'0'"))


class InvalidGameReason(Base):
    __tablename__ = 'invalid_game_reasons'

    id = Column(Integer, primary_key=True)
    message = Column(String(100), nullable=False)


class JwtUser(Base):
    __tablename__ = 'jwt_users'

    id = Column(Integer, primary_key=True)
    username = Column(String(20), nullable=False)
    public_key = Column(String(1000), nullable=False)


class Ladder1v1Rating(Base):
    __tablename__ = 'ladder1v1_rating'

    id = Column(Integer, primary_key=True)
    mean = Column(Float)
    deviation = Column(Float)
    numGames = Column(SmallInteger, nullable=False, server_default=text("'0'"))
    winGames = Column(SmallInteger, nullable=False, server_default=text("'0'"))
    is_active = Column(Integer, nullable=False, server_default=text("'0'"))


class LadderDivision(Base):
    __tablename__ = 'ladder_division'

    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
    league = Column(Integer, nullable=False)
    threshold = Column(Integer, nullable=False)


class LadderMap(Base):
    __tablename__ = 'ladder_map'

    id = Column(SmallInteger, primary_key=True)
    idmap = Column(Integer, nullable=False)


class LobbyAdmin(Base):
    __tablename__ = 'lobby_admin'

    user_id = Column(Integer, primary_key=True)
    group = Column(Integer, nullable=False)


t_lobby_ban = Table(
    'lobby_ban', metadata,
    Column('idUser', Integer),
    Column('reason', String(255), nullable=False),
    Column('expires_at', DateTime)
)


class Login(Base):
    __tablename__ = 'login'

    id = Column(Integer, primary_key=True)
    login = Column(String(20, 'latin1_bin'), nullable=False)
    password = Column(String(77), nullable=False)
    salt = Column(String(16))
    email = Column(String(254, 'latin1_bin'), nullable=False)
    ip = Column(String(15, 'latin1_bin'))
    steamid = Column(BigInteger)
    create_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    update_time = Column(DateTime, nullable=False, server_default=text("'0000-00-00 00:00:00'"))


class MatchmakerBan(Base):
    __tablename__ = 'matchmaker_ban'

    id = Column(Integer, primary_key=True)
    userid = Column(Integer, nullable=False)


class Message(Base):
    __tablename__ = 'messages'

    id = Column(Integer, primary_key=True)
    key = Column(String(255), nullable=False)
    language = Column(String(2), nullable=False)
    region = Column(String(2))
    value = Column(Text)


class NameHistory(Base):
    __tablename__ = 'name_history'

    change_time = Column(DateTime, primary_key=True, server_default=text("CURRENT_TIMESTAMP"))
    user_id = Column(Integer, nullable=False)
    previous_name = Column(String(20), nullable=False)


t_oauth_clients = Table(
    'oauth_clients', metadata,
    Column('id', String(36), nullable=False),
    Column('name', String(100), nullable=False),
    Column('client_secret', String(55), nullable=False),
    Column('client_type', Enum('confidential', 'public'), nullable=False, server_default=text("'public'")),
    Column('redirect_uris', Text, nullable=False),
    Column('default_redirect_uri', String(2000), nullable=False),
    Column('default_scope', Text, nullable=False),
    Column('icon_url', String(2000))
)


class OauthToken(Base):
    __tablename__ = 'oauth_tokens'

    id = Column(Integer, primary_key=True)
    token_type = Column(String(45), nullable=False)
    access_token = Column(String(36), nullable=False)
    refresh_token = Column(String(36), nullable=False)
    client_id = Column(String(36), nullable=False)
    scope = Column(Text, nullable=False)
    expires = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    user_id = Column(Integer, nullable=False)


class PlayerAchievement(Base):
    __tablename__ = 'player_achievements'

    id = Column(Integer, primary_key=True)
    player_id = Column(Integer, nullable=False)
    achievement_id = Column(String(36), nullable=False)
    current_steps = Column(Integer)
    state = Column(Enum('HIDDEN', 'REVEALED', 'UNLOCKED'), nullable=False)
    create_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    update_time = Column(DateTime, nullable=False, server_default=text("'0000-00-00 00:00:00'"))


class PlayerEvent(Base):
    __tablename__ = 'player_events'

    id = Column(Integer, primary_key=True)
    player_id = Column(Integer, nullable=False)
    event_id = Column(String(36), nullable=False)
    count = Column(Integer, nullable=False)
    create_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))
    update_time = Column(DateTime, nullable=False, server_default=text("'0000-00-00 00:00:00'"))


class Map(Base):
    __tablename__ = 'table_map'

    id = Column(Integer, primary_key=True)
    name = Column(String(40))
    description = Column(String)
    max_players = Column(Numeric(2, 0))
    map_type = Column(String(15))
    battle_type = Column(String(15))
    map_sizeX = Column(Numeric(4, 0))
    map_sizeY = Column(Numeric(4, 0))
    version = Column(Numeric(4, 0))
    filename = Column(String(200))
    hidden = Column(Integer, nullable=False, server_default=text("'0'"))
    mapuid = Column(Integer, nullable=False)


# TODO make these computed columns of table_map
class TableMapFeature(Base):
    __tablename__ = 'table_map_features'

    map_id = Column(Integer, primary_key=True)
    rating = Column(Float, nullable=False, server_default=text("'0'"))
    voters = Column(Text, nullable=False)
    downloads = Column(Integer, nullable=False, server_default=text("'0'"))
    times_played = Column(Integer, nullable=False, server_default=text("'0'"))
    num_draws = Column(Integer, nullable=False, server_default=text("'0'"))


# TODO: Either inline this or make it a history-type thing with a comment as to why the map is unranked
class TableMapUnranked(Base):
    __tablename__ = 'table_map_unranked'

    id = Column(Integer, primary_key=True)


# TODO: Ditto
class TableMapUploader(Base):
    __tablename__ = 'table_map_uploaders'

    id = Column(Integer, primary_key=True)
    mapid = Column(Integer, nullable=False)
    userid = Column(Integer, nullable=False)


class TableMod(Base):
    __tablename__ = 'table_mod'

    id = Column(Integer, primary_key=True)
    uid = Column(String(40), nullable=False)
    name = Column(String(255), nullable=False)
    version = Column(SmallInteger, nullable=False)
    author = Column(String(100), nullable=False)
    ui = Column(Integer, nullable=False)
    date = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))
    downloads = Column(Integer, nullable=False, server_default=text("'0'"))
    likes = Column(Integer, nullable=False, server_default=text("'0'"))
    played = Column(Integer, nullable=False, server_default=text("'0'"))
    description = Column(String(255), nullable=False)
    filename = Column(String(255), nullable=False)
    icon = Column(String(255), nullable=False)
    likers = Column(LONGBLOB, nullable=False)
    ranked = Column(Integer, nullable=False, server_default=text("'0'"))


class Teamkill(Base):
    __tablename__ = 'teamkills'    

    teamkiller = Column(Integer, nullable=False)   
    victim = Column(Integer, nullable=False)
    game_id = Column(Integer, nullable=False)
    gametime = Column(Integer, nullable=False)
    reported_at = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP"))

    __table_args__ = (PrimaryKeyConstraint(teamkiller, game_id),)


class TutorialSection(Base):
    __tablename__ = 'tutorial_sections'

    id = Column(Integer, primary_key=True)
    section = Column(String(45), nullable=False)
    description = Column(String(100), nullable=False)


class Tutorial(Base):
    __tablename__ = 'tutorials'

    id = Column(Integer, primary_key=True)
    section = Column(Integer, nullable=False)
    name = Column(String(45), nullable=False)
    description = Column(String(255), nullable=False)
    url = Column(String(45), nullable=False)
    map = Column(String(100), nullable=False)


class UniqueIdUser(Base):
    __tablename__ = 'unique_id_users'

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, nullable=False)
    uniqueid_hash = Column(String(32), nullable=False)


class Uniqueid(Base):
    __tablename__ = 'uniqueid'

    id = Column(Integer, primary_key=True)
    hash = Column(String(32))
    uuid = Column(String(255), nullable=False)
    mem_SerialNumber = Column(String(255), nullable=False)
    deviceID = Column(String(255), nullable=False)
    manufacturer = Column(String(255), nullable=False)
    name = Column(String(255), nullable=False)
    processorId = Column(String(255), nullable=False)
    SMBIOSBIOSVersion = Column(String(255), nullable=False)
    serialNumber = Column(String(255), nullable=False)
    volumeSerialNumber = Column(String(255), nullable=False)


t_uniqueid_exempt = Table(
    'uniqueid_exempt', metadata,
    Column('user_id', Integer),
    Column('reason', String(255), nullable=False)
)


class VersionLobby(Base):
    __tablename__ = 'version_lobby'

    id = Column(Integer, primary_key=True)
    file = Column(String(100))
    version = Column(String(100), nullable=False)
