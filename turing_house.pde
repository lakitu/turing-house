int room = 0;
Player p;

void setup() {
  size(1200, 800);
  p = new Player(500, 500);
}

void draw() {
  
  //if (room == 0)
  //  renderOpening();
  if (room == 1) CryptoRoom.render();
  if (room == 2) LogicRoom.render();
  if (room == 3) PuzzleRoom.render();
  
  p.render();
}
