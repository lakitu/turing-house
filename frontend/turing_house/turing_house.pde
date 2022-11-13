import processing.net.*;
import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLConnection;
import java.io.InputStreamReader;

String url = "https://50d4-128-197-29-253.ngrok.io";

Room[] rooms;
Player player;
final String[] paths = new String[] {null, "/crypto", "/logic-question", "/puzzle", "/victory"};
// /logic-solved
boolean[] pressed = new boolean[4]; // [0] = left, [1] = up, [2] = right, [3] = down
boolean keyReleased = false;
int activeRoom;
String phoneNumber;

void setup() {
  size(1200, 800);

  activeRoom = 0;
  rooms = new Room[5]; // number of rooms
  rooms[0] = new EntranceRoom();

  // test code
<<<<<<< HEAD:frontend/turing_house/turing_house.pde
  //activeRoom = 3;
=======
  activeRoom = 3;
>>>>>>> 29707808b67599b84510441492406a0ac217a435:turing_house.pde
  //rooms[4] = new VictoryRoom();

  // real code
  player = new Player(width/2, height/2, new int[] {0, 0, width, height});
<<<<<<< HEAD:frontend/turing_house/turing_house.pde
  //nextRoom();
=======
  nextRoom();
>>>>>>> 29707808b67599b84510441492406a0ac217a435:turing_house.pde
}

void draw() {
  background(255);
  rooms[activeRoom].render();

  player.render();
  keyReleased = false;
<<<<<<< HEAD:frontend/turing_house/turing_house.pde
  println(player.SIZE);
  //println(frameRate);
=======
  println(frameRate);
>>>>>>> 29707808b67599b84510441492406a0ac217a435:turing_house.pde
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
