
from ._base import *
from .user import User

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

    user = CascadeFKey(User, 'oauth_tokens')

    client = CascadeFKey(OAuthClient, 'tokens')

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

__all__ = [
    'OAuthClient', 'OAuthGrant', 'OAuthToken'
]