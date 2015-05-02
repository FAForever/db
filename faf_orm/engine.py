
from ._base import *
from .version import RepoVersion

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

__all__ = ['EngineHash','EnginePatch']