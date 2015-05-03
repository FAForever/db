"""
Base classes for models / fields, overloaded fields.
"""

from . import db
from peewee import *
from peewee import EnclosedClause
from datetime import datetime

# Unbreak foreign key type
def _ForeignKeyField_get_db_field(self):
    if not isinstance(self.to_field, PrimaryKeyField):
        return self.to_field.get_db_field()
    return "uint"

ForeignKeyField.get_db_field = _ForeignKeyField_get_db_field

class CascadeFKey(ForeignKeyField):
    def __init__(self, rel_model, related_name=None, on_delete='CASCADE',
                 on_update='CASCADE', extra=None, to_field=None, **kwargs):
        super(CascadeFKey, self).__init__(
            rel_model=rel_model, related_name=related_name,
            on_delete=on_delete, on_update=on_update,
            extra=extra, to_field=to_field, **kwargs)

class TimeStampField(DateTimeField):
    db_field = 'time'

class CTimeField(TimeStampField):
    "Created timestamp field."
    def __init__(self, *args, **kwargs):
        kwargs.update(constraints=[SQL('DEFAULT NOW()')])
        super(CTimeField, self).__init__(*args, **kwargs)

class MTimeField(TimeStampField):
    "Update timestamp field."
    def __init__(self, *args, **kwargs):
        kwargs.update(constraints=[SQL('DEFAULT NOW() ON UPDATE NOW()')])
        super(MTimeField, self).__init__(*args, **kwargs)

class LongBlobField(BlobField):
    db_field = 'longblob'

class UIntField(IntegerField):
    db_field = 'uint'

class EnumField(CharField):
    db_field = 'enum'

    def __init__(self, *enum_strings, **kwargs):
        super(EnumField, self).__init__(**kwargs)

        for enum in enum_strings:
            assert isinstance(enum, str) and "Enums must be strings."

        self._enum = list(enum_strings)

    def __ddl_column__(self, column_type):
        return Clause(SQL(column_type),
                      EnclosedClause(*map(lambda e: Param(e), self._enum)))

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