# add messages to send to users to this file based on room actions

# initial message
def ent_message():
    ent_message = "Hi there, this is Alan Turing. Welcome to my house! You will be faced with daunting logic puzzles and tricky tests. Best of luck to you!"
    return ent_message

# cryptography room message
def crpt_message():
    crpt_message = "One thing many people know me for is my work in crpytography during World War II. Try solving this cryptographic puzzle and see what you can come up with."
    return crpt_message

# logic room messages
def lgc_message1():
    lgc_message1 = """
    Here's your clue: A cat is hiding in one of the five boxes. After each try, the cat moves to a box adjacent to the one he was hiding in. Find this cat as quickly as possible.
    """
    return lgc_message1

def lgc_message2():
    lgc_message2 = """
    This cat will show you the way!
    """
    return lgc_message2


def lgc_message_solve():
    lgc_message4 = """
    The cat unlocked the room for you!
    """
    return lgc_message4

# puzzle room messages
def pz_message1():
    pz_message1 = """
    After the war, I began to focus on early forms of what is now known as AI. I was quickly drawn to chess, and saw it as a true test of a machine's brain. The program I created, Turbochamp, wasn't too successful... however, its modern successors have become incredible!
    """
    return pz_message1

def pz_message2():
    pz_message2 = """
    Here, a chess puzzle is presented before you. You are playing as white, and the objective is to mate black in 3 moves. Hint: there's more than one way to do it.
    """
    return pz_message2

# final message
def vct_message():
    vct_message = """
    Congratulations on cracking the enigma that is my house! As a reward, I've put you in touch with the artificial intelligence of the future. One example of this is GPT-3 at OpenAI. \nI've opened a portal for you to communicate with me there. Hope you enjoy the conversation!
    """
    return vct_message