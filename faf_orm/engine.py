
from ._base import *
from .version import RepoVersion

# ====== Engine Patching Models =======

class EngineHash(LobbyModel):
    class Meta:
        db_table = 'engine_hash'

    exe_hash = CharField(32)
    repo_version = CascadeFKey(RepoVersion, 'eng_hash')

class EnginePatch(LobbyModel):
    class Meta:
        db_table = 'engine_patch'

    from_hash = CascadeFKey(EngineHash, 'patch')
    to_hash = CascadeFKey(EngineHash)

    patch = LongBlobField()

__all__ = ['EngineHash','EnginePatch']