public class EntranceRoom extends Room {
  Textbox t;
  int bx, by, bw, bh;
  int[] playerPos;
  
  EntranceRoom() {
    super();
    t = new Textbox(6*width/16, height/3, 340, 100);
    bx = t.x + t.w;
    by = t.y;
    bw = width/2-t.w;
    bh = t.h;
    playerPos = player.getPosition();
  }
  
  boolean hoveringOverEnter() {
    return mouseX > bx-bw/2 && mouseX < bx+bw/2 && mouseY > by-bh/2 && mouseY < by+bh/2;
  }
  
  void display() {
    // instructions
    fill(0);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("Enter a US phone number", width/2, height/6);
    
    // textbox
    t.render();
    
    // enter button
    rectMode(CENTER);
    fill(255);
    if (hoveringOverEnter()) fill(200);
    stroke(0);
    rect(bx, by, bw, bh, 20);
    
    fill(0);    
    textAlign(CENTER, CENTER);
    text("Enter", bx, by-10);
    
    if (roomSolved) {
      player.setPosition(playerPos[0], playerPos[1]);
      fill(0);
      noStroke();
      rectMode(CENTER);
      rect(playerPos[0], playerPos[1], 100, 100);
      if (frameCount % 2 == 0) player.SIZE--;
      if (player.SIZE <= 0) {
        phoneNumber = t.text;
        requestTextMessage("/entrance", "POST");
        nextRoom();
      }
    }
  }
  
  void move() {
    if (hoveringOverEnter() && mousePressed && t.text.length() == (t.hasBlinker() ? 11 : 10)) {
      roomSolved = true;
      solveFrame = frameCount;
      playerPos = player.getPosition();
    }
  }
}
