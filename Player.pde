class Player {
  private final static int SPEED = 5;
  int x, y;
  Player(int _x, int _y) {
    x = _x;
    y = _y;
  }

  public void display() {
    ellipseMode(CENTER);
    circle(x, y, 30);
  }

  public void move() {
    if (pressed[0]) x -= SPEED;
    if (pressed[1]) y -= SPEED;
    if (pressed[2]) x += SPEED;
    if (pressed[3]) y += SPEED;
  }

  public void render() {
    move();
    display();
  }
}
