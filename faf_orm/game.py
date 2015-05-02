"""
Game Model classes.
"""
from ._base import *
from .user import User

class GameFeaturedMod(LobbyModel):
    class Meta:
        db_table = 'game_featuredMods'

    mod = CharField(50)
    description = TextField()
    name = CharField()

    published = BooleanField(db_column='publish')

class Game(LobbyModel):
    class Meta:
        db_table = 'game_stats'

    time_start = TimeStampField(db_column='startTime')
    time_end   = TimeStampField(db_column='EndTime')

    type = IntegerField(db_column='gameType')
    mod  = ForeignKeyField(GameFeaturedMod, db_column='gameMod')

    host = ForeignKeyField(User, null=True, on_delete='SET NULL')
    map = IntegerField()

    name = CharField(db_column='gameName')

class GamePlayer(LobbyModel):
    class Meta:
        db_table = 'game_player_stats'

    game = ForeignKeyField(Game, related_name='players', db_column='gameId', on_delete='CASCADE')
    player = ForeignKeyField(User, null=True, db_column='playerId', on_delete='SET NULL')

    ai = BooleanField()
    faction = IntegerField()
    color = IntegerField()
    team = IntegerField()
    place = IntegerField()

    mean = FloatField()
    deviation = FloatField()

    after_mean = FloatField()
    after_deviation = FloatField()

    score = IntegerField()
    time_score = TimeStampField()

class GameReplay(LobbyModel):
    class Meta:
        db_table = 'game_replays'

    UID = PrimaryKeyField()
    file = BlobField()

__all__ = [
    'GameFeaturedMod', 'Game', 'GamePlayer', 'GameReplay'
]

