import os
from . import db, messages
from twilio.rest import Client
from flask import Flask, request


# create and configure the app
app = Flask(__name__)

user_num = '+17813093509'



def send_sms(to, message_body):
    account_sid = os.environ['TWILIO_ACCOUNT_SID']
    auth_token = os.environ['TWILIO_AUTH_TOKEN']
    twilio_num = '+17207949167'
    client = Client(account_sid, auth_token)
    print(message_body)
    client.messages.create(to=to, from_=twilio_num, body=message_body)

db.initialize()
db.add_user('+17813093509')


# entrance room page
@app.route('/entrance', methods=["GET", "POST"])
def entrance():
    send_sms(user_num, 'welcome to the entrance page! this is alan!')
    return 'Entrance room'

# cryptography room page
@app.route('/crypto')
def crypto():
    send_sms(user_num, 'greetings from the crypto room!')
    return "Cryptography room"

# logic room page
@app.route('/logic')
def logic():
    send_sms(user_num, 'time for a clue about logic')
    return "Logic room"

# puzzle room page
@app.route("/puzzle")
def puzzle():
    send_sms(user_num, 'are you excited for a puzzle??')
    return "Puzzle room"

@app.route('/victory')
def victory():
    send_sms(user_num, 'good job beating our game!!')
    return "Victory room"