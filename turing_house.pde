import processing.net.*;
import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLConnection;

Room[] rooms;
Player player;
final String[] paths = new String[] {"/entrance", "/crypto", "/logic", "/puzzle", "/victory"};
boolean[] pressed = new boolean[4]; // [0] = left, [1] = up, [2] = right, [3] = down
boolean keyReleased = false;
int activeRoom;


void setup() {
  size(1200, 800);
  player = new Player(width/2, height/2, new int[] {0, 0, width, height});

  activeRoom = 0;
  rooms = new Room[5]; // number of rooms
  rooms[0] = new EntranceRoom();

  // test code
}

void draw() {
  background(255);
  rooms[activeRoom].render();

  player.render();
  keyReleased = false;
}

void nextRoom() {
  activeRoom++;
  if (activeRoom == 1) rooms[1] = new CryptoRoom();
  else if (activeRoom == 2) rooms[2] = new LogicRoom();
  else if (activeRoom == 3) rooms[3] = new PuzzleRoom();
  else if (activeRoom == 4) rooms[4] = new VictoryRoom();
}


void keyPressed() {
  char[] letters = new char[] {'a', 'w', 'd', 's'};
  char[] arrows = new char[] {LEFT, UP, RIGHT, DOWN};
  for (int i = 0; i < 4; i++) {
    if (key == letters[i] || keyCode == arrows[i]) pressed[i] = true;
  }
}

void keyReleased() {
  keyReleased = true;
  char[] letters = new char[] {'a', 'w', 'd', 's'};
  char[] arrows = new char[] {LEFT, UP, RIGHT, DOWN};
  for (int i = 0; i < 4; i++) {
    if (key == letters[i] || keyCode == arrows[i]) pressed[i] = false;
  }
}
