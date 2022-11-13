class LogicRoom extends Room {
  
  
  boolean locked = false;
  PImage img;
  int boxFrame = -1000;
  boolean lockedDoor = true;
  boolean noDoublePress = false;
  boolean winScreen = false;
  boolean catActive = true;
  boolean endGame = false;
  float moveX;
  int cat = (int)(Math.random() * ((4) + 1)) + 1;
  int tries = 1;
  LogicRoom() {
    super();
    player = new Player(600, 400, boundaries);
    
  }


  private void result(int playerAns) {
    if (noDoublePress) {
      return;
    }
    if (playerAns == cat) {
      println("Cat Pos " + cat);
      winScreen = true;
      solveFrame = frameCount;
      requestTextMessage("/logic-solved");
      
    
      
    } else {
      boxFrame = frameCount;
      player.setPosition(600, 400);
      tries++;
      int leftOrRight = (int)(Math.random() * ((1) + 1)) + 0;
      if (cat == 5) {
        cat--;
      } else if (cat == 1) {
        cat++;
      } else if (leftOrRight == 1) {
        // Move Right
        cat++;
      } else {
        // Move Left
        cat--;
      }
    }
    noDoublePress = true;
  }




private void showCat() {
   if (cat == 1) {
     moveX = 250;
   } else if (cat == 2) {
     moveX = 400;
   } else if (cat == 3) {
     moveX = 550;
   } else if (cat == 4) {
     moveX = 700;
   } else if (cat == 5) {
     moveX = 850;
   }
   catActive = true; 
}
  public void move() {
    int x = player.getPosition()[0];
    int y = player.getPosition()[1];
    if (winScreen) {
      textSize(30);
      fill(255);
      if (tries == 1) {
        text("You found the cat in " + tries + " try!", 600, 700);
      } else {
        text("You found the cat in " + tries + " tries.", 600, 700);
      }
      showCat();
      img = loadImage("./img/Cute Cat.png");
      int catx = (int) min(950, moveX + 25 + 3 * (frameCount - solveFrame));
      image(img, catx, 155 + 20*abs(sin(catx/20.)));
      if (catx == 950) {
        img = loadImage("./img/open.png");
        image(img, 950, 100);
        endGame = true;
        lockedDoor = false;
      }
    }
    if (!lockedDoor && x >= 950 && x <= 1050 && y >= 100 && y <= 250) {
      nextRoom();
      
    }
    textSize(15);
    fill(255);
    textAlign(CENTER, CENTER);
    if (!endGame) {
      if (lockedDoor && x >= 950 && x <= 1050 && y >= 100 && y <= 250) {
        fill(255, 0, 0);
        text("This Door is Locked", 900, 125);
      }
      if (x >= 250 && x <= 350 && y < 350 && y >= 250) {        
        text("Press 'F' to \n select Box 1", 300, 200);
        if (key == 'f') {
          result(1);
        }
      } else if (x >= 400 && x <= 500 && y <= 350 && y >= 250) {
        text("Press 'F' to \n select Box 2", 450, 200);
        if (key == 'f') {
          result(2);
        }
      } else if (x >= 550 && x <= 700 && y <= 350 && y >= 225) {
        text("Press 'F' to \n select Box 3", 600, 200);
        if (key == 'f') {
          result(3);
        }
      } else if (x >= 700 && x <= 800 && y <= 350 && y >= 225) {
        text("Press 'F' to \n select Box 4", 750, 200);
        if (key == 'f') {
          result(4);
        }
      } else if (x >= 850 && x <= 950 && y <= 350 && y >= 225) {
        text("Press 'F' to \n select Box 5", 900, 200);
        if (key == 'f') {
          result(5);
        }
      } else {
        fill(255);
        noDoublePress = false;
      }
  } 

    
    
    
    
    
  }

  public void display() {
    displayBackground();
    fill(255);
    // Box images
    img = loadImage("./img/box.png");
    image(img, 250, 250);
    image(img, 400, 250);
    image(img, 550, 250);
    image(img, 700, 250);
    image(img, 850, 250);  
    textSize(25);
      if (frameCount - boxFrame < 100) {
        text("The cat was not in the box. He will now move to an adjacent box", 600, 700);  
      }
    // Number of tries display  
    fill(255);
    text("Try: " + tries, 200, 125);
    // Closed Door
    img = loadImage("./img/closed.png");
    image(img, 950, 100);

    
}


  void render() {
    display();
    move();
    print("cat pos " + cat);
  }
}
