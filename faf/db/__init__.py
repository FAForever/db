"""
Synchronous faf database abstraction

Just PyMYSQL.
"""
import pymysql

connection = None


def init_db(config):
    global connection
    connection = pymysql.connect(**config['DATABASE'])

    def get_cursor(cursor=None):
        """
        Ping the connection every time we get a cursor, will if the connection is dead.
        """
        connection.ping()
        return pymysql.connections.Connection.cursor(connection, cursor)
    connection.cursor = get_cursor
