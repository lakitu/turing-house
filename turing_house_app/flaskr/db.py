# for cryptography room

import sqlite3
from flask import current_app

def initialize():

    db = sqlite3.connect("database.sql")

    db.execute("""CREATE TABLE user (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "number" TEXT UNIQUE NOT NULL,
        "letters" TEXT NOT NULL
    )""")

    

    db.close()

def add_user(user_num):
    db = sqlite3.connect("database.sql")

    db.execute(f'''
        INSERT INTO user VALUES (0, {user_num}, "")
    ''')

    db.close()

def add_letter(user_num, letter):
    db = sqlite3.connect("database.sql")

    db.execute(f"UPDATE user SET letters = 'a' WHERE {user_num}")

    db.close()

def check_letter(user_num):
    db = sqlite3.connect("database.sql")

    db.execute(f"""
        SELECT letters FROM number WHERE number = {user_num}
    """)