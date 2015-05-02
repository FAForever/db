"""
Base classes for models / fields, overloaded fields.
"""

from . import db
from peewee import *
from datetime import datetime

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