import sqlite3

def initialize():

    db = sqlite3.connect("database.db")

    db.execute(
        'CREATE TABLE users (number TEXT, score INT)'
    )

    db.close()

def add_user(user_num):
    db = sqlite3.connect("database.db")

    db.execute(f'''
        INSERT INTO users VALUES ({user_num}, 0)
    ''')

    db.close()


