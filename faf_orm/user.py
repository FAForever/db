"""
User Models and misc user information.
"""

from ._base import *

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

# ======= Clan Models ========

class Clan(LobbyModel):
    class Meta:
        schema = 'fafclans'
        db_table = 'clans_list'

    id = IntegerField(primary_key=True, db_column='clan_id')
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


__all__ = [
    'User', 'Avatar', 'UserAvatar',
    'Ladder1v1Rating', 'GlobalRating',
    'Clan','ClanMember'
]