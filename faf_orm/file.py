"""
File ORM Model
"""

from ._base import *

class DBFile(LobbyModel):
    class Meta:
        db_table = 'file'

    name = CharField(help_text='(optional) human readable name', null=True)

    time_added = CTimeField()
    time_updated = MTimeField()

    mime_type    = EnumField('application', 'audio', 'image',
                             'message', 'model', 'text', 'video', index=True)
    mime_subtype = EnumField('fafreplay', 'gif', 'jpeg', 'png', 'bmp', index=True)

    data = LongBlobField()

__all__ = [
    'DBFile'
]