int room = 0;
Player p;
boolean[] pressed = new boolean[4]; // [0] = left, [1] = up, [2] = right, [3] = down

void setup() {
  size(1200, 800);
  p = new Player(width/2, height/2);
}

void draw() {
  background(255);
  //if (room == 0)
  //  renderOpening();
  if (room == 1) CryptoRoom.render();
  if (room == 2) LogicRoom.render();
  if (room == 3) PuzzleRoom.render();

  p.render();
  
  println(pressed);
}



void keyPressed() {
  char[] letters = new char[] {'a', 'w', 'd', 's'};
  char[] arrows = new char[] {LEFT, UP, RIGHT, DOWN};
  for (int i = 0; i < 4; i++) {
    if (key == letters[i] || keyCode == arrows[i]) pressed[i] = true;
  }
}

void keyReleased() {
  char[] letters = new char[] {'a', 'w', 'd', 's'};
  char[] arrows = new char[] {LEFT, UP, RIGHT, DOWN};
  for (int i = 0; i < 4; i++) {
    if (key == letters[i] || keyCode == arrows[i]) pressed[i] = false;
  }
}
