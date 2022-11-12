class Player {
  private final static int SPEED = 5;
  private final static int SIZE = 50;
  
  private int x, y;
  int initTime;
  Player(int _x, int _y) {
    setPosition(_x, _y);
    initTime = millis();
  }

  private float mouseAngle() {
    int xDiff = x - mouseX;
    int yDiff = y - mouseY;
    PVector v = new PVector(xDiff, yDiff);
    return v.heading() - HALF_PI;
  }

  private void display() {
    ellipseMode(CENTER);
    strokeWeight(1);
    stroke(0);
    
    push();
    translate(x, y);
    rotate(mouseAngle());
    
    // face
    fill(#88CCFF);
    circle(0, 0, SIZE);

    // hands
    fill(#ffffff);
    circle(-SIZE/3, -SIZE/2.5, SIZE/2);
    circle(SIZE/3, -SIZE/2.5, SIZE/2);

    pop();
  }

  private void move() {
    if (pressed[0]) x -= SPEED;
    if (pressed[1]) y -= SPEED;
    if (pressed[2]) x += SPEED;
    if (pressed[3]) y += SPEED;
  }

  public void render() {
    move();
    display();
  }
  
  public void setPosition (int _x, int _y) {
    x = _x;
    y = _y;
  }
  public int[] getPosition() {
    return new int[] {x, y};
  }
}
