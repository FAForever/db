from peewee import Clause, SQL, Param, EnclosedClause, Proxy, DoesNotExist

def Match(match, against: str, mode='BOOLEAN'):
    "Create a mysql MATCH () AGAINST () full-text search clause"
    return Clause(
        SQL('MATCH'), EnclosedClause(*match),
        SQL('AGAINST'), EnclosedClause(
            Clause(Param(against), SQL('IN %s MODE' % mode)))
    )

# DB is uninitialized. Initialize it at runtime
db = Proxy()

def faf_orm_init_db(database):
    db.initialize(database)
    db.field_overrides['primary_key'] = 'INTEGER UNSIGNED AUTO_INCREMENT'
    db.field_overrides['uint'] = 'INTEGER UNSIGNED'

    db.field_overrides['longblob'] = 'LONGBLOB'
    db.field_overrides['enum'] = 'ENUM'
    db.field_overrides['timestamp'] = 'TIMESTAMP'

# Exported names
__all__ = [
    'db', 'faf_orm_init_db',
    'Match', 'DoesNotExist'
]

from .engine import *
from .file import *
from .game import *
from .map import *
from .mod import *
from .oauth import *
from .user import *
from .version import *

from importlib import import_module

# Add models to exported names
for sub_mod in ['engine', 'file', 'game',
                'map', 'mod', 'oauth', 'user', 'version']:
    mod = import_module(__name__+'.'+sub_mod)
    __all__.extend(mod.__all__)
