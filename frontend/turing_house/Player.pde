class Player {
  private final static int SPEED = 5;
  public int SIZE;

  private int x, y;
  private int[] boundaries;
  int initTime;

  // takes initial x, y, and an array of boundaries of size 4 (left, top, right, bottom)
  Player(int _x, int _y, int[] _bounds) {
    this(_x, _y);
    if (_bounds.length != 4) _bounds = new int[] {0, 0, width, height};
    boundaries = _bounds;
  }

  Player(int _x, int _y) {
    setPosition(_x, _y);
    SIZE = 50;
    initTime = millis();
  }

  public float mouseAngle() {
    int xDiff = x - mouseX;
    int yDiff = y - mouseY;
    return (float) Math.atan2(yDiff, xDiff) - HALF_PI;
    //return v.heading() - HALF_PI;
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

    if (boundaries == null) return;
    if (x - SIZE/2 < boundaries[0]) x = boundaries[0]+SIZE/2;
    if (x + SIZE/2 > boundaries[2]) x = boundaries[2]-SIZE/2;
    if (y - SIZE/2 < boundaries[1]) y = boundaries[1]+SIZE/2;
    if (y + SIZE/2 > boundaries[3]) y = boundaries[3]-SIZE/2;
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
