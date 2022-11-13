import java.util.Random;

class CryptoRoom extends Room {
  
  Random rand = new Random();
  private int picked = -1;
  private int[][] rects = {{rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100,rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100,rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}};
  private String[] words = {
    "turing",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  };
  
  
  
  public boolean isOn() {
    int[] pos = p.getPosition();
    for (int i = 0; i < rects.length; i++) {
      if (pos[0] > rects[i][0] && pos[0] < (rects[i][0] + 60)) {
         if (pos[1] > rects[i][1] && pos[1] < (rects[i][1] + 60)) {
            if (picked == -1) {
            text("Press the CTRL key to pick up a letter", 180, 770);
            }
            if (keyCode == CONTROL) {
              picked = i;
            }
            return true;
        }
      }
    }
   return false;
  }

  public void pickup() {
    int[] pos = p.getPosition();
    if (picked != -1) {
      if (keyCode == ALT) {
        picked = -1;
      }
      else {
      text("Press the ALT key to put down a letter", 170, 770);
      rects[picked] = pos;
      }
    }
  }
  
  public void drop() {
    int[] pos = p.getPosition();
    for (int i = 0; i < rects.length; i++) {
      if (pos[0] > (100 + (i * 150)) && pos[0] < (200 + (i * 150))) {
        if (pos[1] > 600 && pos[1] < 700) {
          if (keyCode == ALT) {
            if (picked != -1) {
           rects[picked][0] = (120 + (i * 150));
           rects[picked][1] = (620);
           picked = -1;
            }
           }
        }
      }
    }  
  }
  
  public void winCheck() {
    if (rects.length == 6) {
    if (rects[0][0] == 120 && rects[1][0] == 270 && rects[2][0] == 420 && rects[3][0] == 570 && rects[4][0] == 720 && rects[5][0] == 870) {
      fill(#50C878);
      rect(100,600,100,100);
      rect(250,600,100,100);
      rect(400,600,100,100);
      rect(550,600,100,100);
      rect(700,600,100,100);
      rect(850,600,100,100);
      nextRoom();
    }
    }
  }

  public void display() {
    displayBackground();
    shininess(5);
    textSize(56);
    fill(100);
    rect(100,600,100,100);
    rect(250,600,100,100);
    rect(400,600,100,100);
    rect(550,600,100,100);
    rect(700,600,100,100);
    rect(850,600,100,100);
    fill(#50C878);
    isOn();
    drop();
    pickup();
    for (int i = 0; i < rects.length; i++) {
    rect(rects[i][0], rects[i][1], 60, 60, 28);
    rect(rects[i][0], rects[i][1], 60, 60, 28);
    rect(rects[i][0], rects[i][1], 60, 60, 28);
    rect(rects[i][0], rects[i][1], 60, 60, 28);
    rect(rects[i][0], rects[i][1], 60, 60, 28);
    rect(rects[i][0], rects[i][1], 60, 60, 28);
    }
    fill(#FFFFFF);
    text("t", (rects[0][0] + 16), (rects[0][1] + 45));
    text("u", (rects[1][0] + 20), (rects[1][1] + 47));
    text("r", (rects[2][0] + 20), (rects[2][1] + 45));
    text("i", (rects[3][0] + 16), (rects[3][1] + 45));
    text("n", (rects[4][0] + 16), (rects[4][1] + 43));
    text("g", (rects[5][0] + 24), (rects[5][1] + 47));
    winCheck();
  }
  
  public void move() {
    
  }
  
  void render() {
    move();
    display();
  }
}
