import java.util.Random;

class CryptoRoom extends Room {

  Random rand = new Random();
  private int picked = -1;
  private int[][] rects = {{rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}, {rand.nextInt(1000) + 100, rand.nextInt(550)}};
  private String[] words = {
    "turing",
    //"",
    //"",
    //"",
    //"",
    //"",
    //"",
    //"",
    //"",
    //""
  };

  CryptoRoom() {
    super(new int[] {70, 100, 1200-70, 800});
    player = new Player(width/2, height/2);
  }



  public boolean isOn() {
    int[] pos = player.getPosition();
    textAlign(CENTER, CENTER);
    for (int i = 0; i < rects.length; i++) {
      if (pos[0] > rects[i][0] && pos[0] < (rects[i][0] + 60)) {
        if (pos[1] > rects[i][1] && pos[1] < (rects[i][1] + 60)) {
          if (picked == -1) {
            text("Press [SPACE] or 'f' to pick up a letter", width/2, 750);
            //text("Press the CTRL key to pick up a letter", width/2, 750);
          }
          //if (keyCode == CONTROL) {
          //  picked = i;
          //}
          if (keyReleased && (key == ' ' || key == 'f' || key == 'F')) {
            picked = i;
            keyReleased = false;
          }
          return true;
        }
      }
    }
    return false;
  }

  public void pickup() {
    int[] pos = player.getPosition();
    if (picked != -1) {
      if (keyCode == ALT) {
        //picked = -1;
      } else {
        //text("Press the ALT key to put down a letter", width/2, 750);
        text("Press [SPACE] or 'f' to put down a letter", width/2, 750);
        rects[picked] = pos;
      }
    }
  }

  public void drop() {
    int[] pos = player.getPosition();
    for (int i = 0; i < rects.length; i++) {
      if (pos[0] > (50 + (i * 150)) && pos[0] < (250 + (i * 150))) {
        if (pos[1] > 550 && pos[1] < 750) {
          //if (keyCode == ALT) {
          if (keyReleased && (key == 'f' || key == 'F' || key == ' ')) {
            if (picked != -1) {
              rects[picked][0] = (120 + (i * 150));
              rects[picked][1] = (620);
              picked = -1;
              keyReleased = false;
            }
          }
        }
      }
      if (keyReleased && (key == 'f' || key == 'F' || key == ' ')) {
        if (picked != -1) {
          rects[picked][0] = pos[0];
          rects[picked][1] = pos[1];
          picked = -1;
          keyReleased = false;
        }
      }
    }
  }

  public void winCheck() {
    if (rects.length == 6) {
      if (rects[0][0] == 120 && rects[1][0] == 270 && rects[2][0] == 420 && rects[3][0] == 570 && rects[4][0] == 720 && rects[5][0] == 870 && abs(player.getPosition()[1] - 600) <= 100) {
        fill(#50C878);
        rect(100, 600, 100, 100);
        rect(250, 600, 100, 100);
        rect(400, 600, 100, 100);
        rect(550, 600, 100, 100);
        rect(700, 600, 100, 100);
        rect(850, 600, 100, 100);
        nextRoom();
      }
    }
  }

  public void display() {
    displayBackground();
    shininess(5);
    textSize(56);
    fill(100);
    // boxes
    rect(100, 600, 100, 100);
    rect(250, 600, 100, 100);
    rect(400, 600, 100, 100);
    rect(550, 600, 100, 100);
    rect(700, 600, 100, 100);
    rect(850, 600, 100, 100);

    // letter boxes
    fill(#50C878);
    for (int i = 0; i < rects.length; i++) {
      rect(rects[i][0], rects[i][1], 60, 60, 28);
      rect(rects[i][0], rects[i][1], 60, 60, 28);
      rect(rects[i][0], rects[i][1], 60, 60, 28);
      rect(rects[i][0], rects[i][1], 60, 60, 28);
      rect(rects[i][0], rects[i][1], 60, 60, 28);
      rect(rects[i][0], rects[i][1], 60, 60, 28);
    }
    // letters
    fill(#FFFFFF);
    text("t", (rects[0][0] + 16), (rects[0][1] + 45));
    text("u", (rects[1][0] + 20), (rects[1][1] + 47));
    text("r", (rects[2][0] + 20), (rects[2][1] + 45));
    text("i", (rects[3][0] + 16), (rects[3][1] + 45));
    text("n", (rects[4][0] + 16), (rects[4][1] + 43));
    text("g", (rects[5][0] + 24), (rects[5][1] + 47));
  }

  public void move() {
    drop();
    isOn();
    pickup();

    winCheck();
  }
}
