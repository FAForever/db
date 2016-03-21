"""
Synchronous faf database abstraction

Just PyMYSQL.
"""
import pymysql
import sqlalchemy

connection = None
sa_engine = None


def init_db(config):
    """
    Initialize the global database connection pool
    """
    global connection, sa_engine
    db_config = config['DATABASE']
    uri = "mysql+pymysql://{}:{}@{}:{}/{}".format(db_config['user'],
                                                  db_config['password'],
                                                  db_config['host'],
                                                  db_config['port'],
                                                  db_config['db'])
    sa_engine = sqlalchemy.create_engine(uri)
    connection = sa_engine.connect().connection.connection  # conneception

    def get_cursor(cursor=None):
        """
        Ping the connection every time we get a cursor, will reconnect if the connection is dead.
        """
        connection.ping()
        return pymysql.connections.Connection.cursor(connection, cursor)
    connection.cursor = get_cursor
