public class Room {
  int[] boundaries = new int[] {150, 100, 1200-150, 800};
  boolean roomSolved;
  int solveFrame;
  boolean animateSliding;

  Room() {
    roomSolved = false;
    solveFrame = -1000;
    animateSliding = true;

    // get the text messages
    requestTextMessage(paths[activeRoom]);
  }

  // requestTextMessage("/logic-solved");
  void requestTextMessage(String path) {
    requestTextMessage(path, "GET");
  }

  void requestTextMessage(String path, String method) {
    if (path == null) return;
    Thread getTexts = new Thread(() -> {
      // initialize the network client
      try {
        URL urlObject = new URL(url + path + "?pn="+phoneNumber);
        HttpURLConnection conn = (HttpURLConnection) urlObject.openConnection();
        conn.setRequestMethod(method);
        conn.connect();
        int status = conn.getResponseCode();
        println(path + " returned a code of " + status);
      }
      catch (Exception e) {
        println(e);
      }
    }
    );
    getTexts.start();
  }

  public void displayBackground() {
    // set up walls
    rectMode(CORNER);

    color lightBrick = #b14434;
    color darkBrick = #4b2122;
    color mortar = #b9bcab + #222222;
    int brickHeight = 10, brickWidth = 15;

    stroke(mortar);
    strokeWeight(2);
    // side walls
    int sideWidth = boundaries[0];
    for (int i = 0; brickHeight * i < height; i++) {
      for (int j = 0; brickWidth * j <= sideWidth; j++) {
        fill(lerpColor(lightBrick, darkBrick, noise(0.1*i + 0.01*j)));
        rect(j * brickWidth - (i % 2)*brickWidth/2, i * brickHeight, brickWidth, brickHeight);

        fill(lerpColor(lightBrick, darkBrick, noise(100 + 0.1*i + 0.01*j)));
        if (roomSolved && animateSliding && i > 50 && i < 60) {
          rect(width - ((j+1) * brickWidth)+(i%2)*brickWidth/2 + (frameCount - solveFrame)/2, i * brickHeight, brickWidth, brickHeight);
          continue;
        }
        rect(width - ((j+1) * brickWidth)+(i%2)*brickWidth/2, i * brickHeight, brickWidth, brickHeight);
      }
    }

    // top walls
    int topHeight = boundaries[1];
    for (int i = 0; brickHeight * i < topHeight; i++) {
      for (int j = 0; brickWidth * j < width; j++) {
        fill(lerpColor(lightBrick, darkBrick, noise(0.1*i + 0.01*j)));
        rect(j * brickWidth - (i % 2)*brickWidth/2, i * brickHeight, brickWidth, brickHeight);
      }
    }

    // cover brick edges
    fill(255);
    stroke(0);
    noStroke();
    rectMode(CORNERS);
    //int[] corners = new int[] {sideWidth-brickWidth, topHeight, width-sideWidth+brickWidth, height};
    rect(boundaries[0], boundaries[1], boundaries[2], boundaries[3]);



    // wood floor
    strokeWeight(1);
    stroke(0);
    rectMode(CORNER);

    float panelLength = (boundaries[2]-boundaries[0])/10., panelHeight = 20;
    color lightPanel = #653332;
    color darkPanel = #3d1c1b;
    stroke(lightPanel);
    //fill(darkPanel);
    for (int y = boundaries[3]; y >= boundaries[1]; y -= panelHeight) {
      for (int x = boundaries[0]; x <= boundaries[2]-panelLength; x += panelLength) {
        fill(lerpColor(lightPanel, darkPanel, noise(x + 100*y)));
        rect(x, y, panelLength, panelHeight);
      }
    }
  }

  public void display() {
  }
  public void move() {
  }
  public void render() {
    display();
    move();
  }
}
