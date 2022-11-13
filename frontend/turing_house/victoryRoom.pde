public class VictoryRoom extends Room {
  
  PImage turing;
  int[] turingDim = new int[] {1052, 1398};
  
  VictoryRoom() {
    super();
    animateSliding = false;
    turing = loadImage("alanTuring.png");
    player.setPosition(width/2, height);
  }
  
  void displayComputer() {
    imageMode(CENTER);
    tint(#1373d9 + #222222);
    image(turing, width/2, height/2, turingDim[0]/4, turingDim[1]/4);
    //tint(0, 0, 0, 127);
    //image(computer, width/2, height/2, width/4, height/4);
  }
  
  void display() {
    displayBackground();
    displayComputer();
  }
  
  void move() {
    int[] playerPos = player.getPosition();
    PVector playerToTuring = new PVector(width/2-playerPos[0], height/2-playerPos[1]);
    playerToTuring.setMag(6);
    player.setPosition(playerPos[0] + (int)playerToTuring.x, playerPos[1] + (int)playerToTuring.y);
    
    if (dist(playerPos[0], playerPos[1], width/2, height/2) < 200 && !roomSolved) {
      link(url);
      roomSolved = true;
      exit();
    }
  }
}
