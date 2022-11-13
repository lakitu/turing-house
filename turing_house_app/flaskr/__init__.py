import os
from . import db, messages, turing_ai
from twilio.rest import Client
from flask import Flask, render_template, request, session

# create and configure the app
app = Flask(__name__)
app.static_folder = 'static'
app.config['SECRET_KEY'] = 'PGLGl6Qg0plkjl768gljMljopL7'


# create database if not set up already
try:
    db.initialize()
except:
    pass

user_num = '+12035131620'

# send user messages throughout game
def send_sms(to, message_body, media_url=None):
    account_sid = os.environ['TWILIO_ACCOUNT_SID']
    auth_token = os.environ['TWILIO_AUTH_TOKEN']
    twilio_num = '+17207949167'
    client = Client(account_sid, auth_token)
    print(message_body)
    client.messages.create(to=to, from_=twilio_num, body=message_body, media_url=media_url)

# cryptography - receive letters
def receive_sms(methods=["GET", "POST"]):
    body = request.values.get('Body', None)
    from_num = request.values.get('From', None)
    if body.isalpha() and len(body) == 1:
        db.add_letter(from_num, body)


@app.route("/")
def home():
    return render_template("index.html")

# entrance room page
@app.route('/entrance', methods=["GET", "POST"])
def entrance():
    #user_num = '+1' + str(request.args.get('pn'))
    print(user_num)
    # db.add_user(user_num)
    return 'Entrance room'

@app.route('/sms', methods=["GET", "POST"])
def sms_receive():
    receive_sms()
    return "Hi there!"


# cryptography room page
@app.route('/crypto')
def crypto():
    #user_num = '+1' + str(request.args.get('pn'))
    print(user_num)
    send_sms(user_num, messages.ent_message())
    send_sms(user_num, messages.crpt_message())
    return "Cryptography room"

@app.route('/crypto-request')
def crypto_request():
    #user_num = '+1' + str(request.args.get('pn'))
    letter = db.check_letter(user_num)
    if letter:
        return letter
    else:
        return None

# logic room question page
@app.route('/logic-question')
def logic_question():
    #user_num = '+1' + str(request.args.get('pn'))
    print(user_num)
    send_sms(user_num, messages.lgc_message1())
    send_sms(user_num, messages.lgc_message2(), media_url="https://cdn.discordapp.com/attachments/1041206701438816319/1041209230344077323/cat.png")
    return "Logic room 1"

# logic room answer page
@app.route('/logic-solved')
def logic_solved():
    #user_num = '+1' + str(request.args.get('pn'))
    send_sms(user_num, messages.lgc_message_solve(), media_url="https://cdn.discordapp.com/attachments/1041206701438816319/1041210449720508437/catkey.png")
    return "Logic room 2"

# puzzle room page
@app.route("/puzzle")
def puzzle():
    #user_num = '+1' + str(request.args.get('pn'))
    print(user_num)
    send_sms(user_num, messages.pz_message1())
    send_sms(user_num, messages.pz_message2())
    return "Puzzle room"

# victory room page
@app.route('/victory')
def victory():
    #user_num = '+1' + str(request.args.get('pn'))
    print(user_num)
    send_sms(user_num, messages.vct_message())


# turingbot method
@app.route('/get')
def get_response(methods=["POST"]):
    userText = request.args.get('msg')
    chat_log = session.get('chat_log')
    answer = turing_ai.ask(userText, chat_log)
    session['chat_log'] = turing_ai.append_convo(userText, answer,
    chat_log)
    return str(answer)

if __name__ == "__main__":
    app.run()