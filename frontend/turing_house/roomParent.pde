public class Room {
  int[] boundaries;
  boolean roomSolved;
  int solveFrame;
  boolean animateSliding;

  int[][] brickColors;
  color lightBrick = #b14434;
  color darkBrick = #4b2122;
  color mortar = #b9bcab + #222222;
  int brickHeight = 10, brickWidth = 15;

  float panelLength, panelHeight;
  color lightPanel = #653332;
  color darkPanel = #3d1c1b;
  int[][] panelColors;

  Room() {
    this(new int[] {150, 100, 1200-150, 800});
    
  }

  Room(int[] _bounds) {
    boundaries = _bounds;
    
    roomSolved = false;
    solveFrame = -1000;
    animateSliding = true;

    brickColors = new int [(width/brickWidth) + 1][height/brickHeight];
    for (int i = 0; i < brickColors.length; i++) {
      for (int j = 0; j < brickColors[i].length; j++) {
        brickColors[i][j] = (int)lerpColor(lightBrick, darkBrick, noise(0.11*i, 0.1*j));
      }
    }

    panelLength = (boundaries[2]-boundaries[0])/10.;
    panelHeight = 20;
    panelColors = new int[10 + 1][(boundaries[3]-boundaries[1])/20 + 1];
    for (int i = 0; i < panelColors.length; i++) {
      for (int j = 0; j < panelColors[i].length; j++) {
        panelColors[i][j] = lerpColor(lightPanel, darkPanel, noise(i + 100*j));
      }
    }

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
        //if (status == 418) {
        //  BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        //  String inputLine;
        //  StringBuffer response = new StringBuffer();

        //  while ((inputLine = in.readLine()) != null) {
        //    response.append(inputLine);
        //  }
        //  in.close();

        //  // print result
        //  System.out.println(response.toString());
        //}
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
    stroke(mortar);
    strokeWeight(2);

    //for (int i = 0; i < brickColors.length; i++) {
    //  for (int j = 0; j < brickColors[i].length; j++) {
    //    fill(brickColors[i][j]);
    //    rect(i * brickWidth - (j % 2)*brickWidth/2, j * brickHeight, brickWidth, brickHeight);
    //  }
    //}
    // side walls
    int sideWidth = boundaries[0];
    for (int i = 0; brickHeight * i < height; i++) {
      for (int j = 0; brickWidth * j <= sideWidth; j++) {
        fill(brickColors[j][i]);
        //fill(lerpColor(lightBrick, darkBrick, noise(0.1*i + 0.01*j)));
        rect(j * brickWidth - (i % 2)*brickWidth/2, i * brickHeight, brickWidth, brickHeight);

        //fill(lerpColor(lightBrick, darkBrick, noise(100 + 0.1*i + 0.01*j)));
        fill(brickColors[j][i]);
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
        fill(brickColors[j][i]);
        //fill(lerpColor(lightBrick, darkBrick, noise(0.1*i + 0.01*j)));
        rect(j * brickWidth - (i % 2)*brickWidth/2, i * brickHeight, brickWidth, brickHeight);
      }
    }

    //// cover brick edges
    //fill(255);
    //stroke(0);
    //noStroke();
    //rectMode(CORNERS);
    ////int[] corners = new int[] {sideWidth-brickWidth, topHeight, width-sideWidth+brickWidth, height};
    //rect(boundaries[0], boundaries[1], boundaries[2], boundaries[3]);



    // wood floor
    strokeWeight(1);
    stroke(0);
    rectMode(CORNER);
    stroke(lightPanel);
    //fill(darkPanel);
    int j = 0, i = 0;
    for (int y = boundaries[3]; y >= boundaries[1]; y -= panelHeight) {
      for (int x = boundaries[0]; x <= boundaries[2]-panelLength; x += panelLength) {
        fill(panelColors[i][j]);
        rect(x, y, panelLength, panelHeight);
        i++;
      }
      i = 0;
      j++;
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
