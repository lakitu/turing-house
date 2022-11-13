class PuzzleRoom extends Room {
  // chess puzzle
  public final color[] boardColors = new color[] {#ffffdd, #86a666};
  int[] boundaries = new int[] {150, 100, 1200-150, 800};
  int boardSize = 600;
  final int[] boardData = new int[] {(boundaries[0] + boundaries[2])/2 - boardSize/2, boundaries[1], boardSize/8};
  PShape blackPawn, blackRook, blackKnight, blackBishop, blackQueen, blackKing, whitePawn, whiteRook, whiteKnight, whiteBishop, whiteQueen, whiteKing;
  ArrayList<Piece> pieces;
  int moveNum;

  PuzzleRoom() {
    super();

    player = new Player(width/2, height, boundaries);
    pieces = new ArrayList<Piece>();
    moveNum = 0;


    blackPawn = loadShape("blackPawn.svg");
    blackRook = loadShape("blackRook.svg");
    blackKnight = loadShape("blackKnight.svg");
    blackBishop = loadShape("blackBishop.svg");
    blackQueen = loadShape("blackQueen.svg");
    blackKing = loadShape("blackKing.svg");

    whitePawn = loadShape("whitePawn.svg");
    whiteRook = loadShape("whiteRook.svg");
    whiteKnight = loadShape("whiteKnight.svg");
    whiteBishop = loadShape("whiteBishop.svg");
    whiteQueen = loadShape("whiteQueen.svg");
    whiteKing = loadShape("whiteKing.svg");

    addPiece(blackRook, 0, 0, 0);
    addPiece(blackKnight, 0, 6, 1);
    addPiece(blackPawn, 1, 0, 2);
    addPiece(blackPawn, 1, 1, 3);
    addPiece(blackPawn, 1, 2, 4);
    addPiece(blackQueen, 1, 4, 5);
    addPiece(blackBishop, 2, 2, 6);
    addPiece(blackPawn, 2, 3, 7);
    addPiece(blackKing, 2, 6, 8);
    addPiece(blackPawn, 2, 7, 9);
    addPiece(blackRook, 3, 5, 10);
    addPiece(whitePawn, 3, 6, 11);
    addPiece(whiteQueen, 4, 3, 12);
    addPiece(blackPawn, 4, 4, 13);
    addPiece(whiteKnight, 5, 2, 14);
    addPiece(whitePawn, 6, 0, 15);
    addPiece(whitePawn, 6, 1, 16);
    addPiece(whitePawn, 6, 2, 17);
    addPiece(whiteBishop, 6, 4, 18);
    addPiece(whiteKing, 7, 2, 19);
    addPiece(whiteRook, 7, 3, 20);
    addPiece(whiteRook, 7, 7, 21);
  }

  private void displayBoard() {
    // chessboard
    stroke(0);
    strokeWeight(1);
    noStroke();
    rectMode(CORNER);

    for (int i = 0; i < 8; i++) {
      int x = boardData[0] + i*boardSize/8;
      for (int j = 0; j < 8; j++) {
        int y = boardData[1] + j*boardSize/8;
        fill(boardColors[(i+j)%2]);
        rect(x, y, boardSize/8, boardSize/8);
      }
    }
  }

  public void addPiece(PShape piece, int row, int col, int pieceCode) {
    pieces.add(new Piece(piece, boardData, row, col, pieceCode));
  }

  public void validNextMove(Piece piece, int newRow, int newCol) {
    if (moveNum == 0 && piece.pieceCode == 18 && newRow == 3 && newCol == 7) {
      piece.setSquare(newRow, newCol);
      pieces.get(8).setSquare(3, 6);
      pieces.remove(11);
      moveNum++;
      return;
    }
    if (moveNum == 1 && piece.pieceCode == 20 && newRow == 7 && newCol == 6) {
      piece.setSquare(newRow, newCol);
      pieces.get(8).setSquare(4, 5);
      moveNum++;
      return;
    }
    if (moveNum == 2 && ((piece.pieceCode == 21 && newRow == 4 && newCol == 7) || (moveNum == 2 && piece.pieceCode == 14 && newRow == 6 && newCol == 4))) { // mate with rook or knight
      piece.setSquare(newRow, newCol);
      moveNum++;
      roomSolved = true;
      solveFrame = frameCount;
      int[] tempPos = player.getPosition();
      player = new Player(tempPos[0], tempPos[1], new int[] {boundaries[0], boundaries[1], width, boundaries[3]});
    }
  }

  public void display() {
    displayBackground();
    displayBoard();
    for (int i = pieces.size()-1; i >= 0; i--) pieces.get(i).display(this);
    if (roomSolved) {
      textAlign(CENTER, CENTER);
      textSize(50);
      fill(255);
      text("Checkmate!", width/2, 750);
    }
  }

  public void move() {
    if (player.getPosition()[0] + Player.SIZE + 5 > width) nextRoom();
  }
}



public class Piece {
  PShape self;
  int row, col;
  int x, y;
  int[] boardData;
  boolean pickedUp;
  boolean isWhite;
  public int pieceCode;


  Piece(PShape self, int[] boardData, int row, int col, int pieceCode) {
    this.self = self;
    this.boardData = boardData;
    this.isWhite = !(pieceCode <= 10 || pieceCode == 13);
    this.pieceCode = pieceCode;
    pickedUp = false;

    setSquare(row, col);
  }

  void setPosition(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void setSquare(int row, int col) {
    this.row = row;
    this.col = col;

    x = col*boardData[2] + boardData[0];
    y = row*boardData[2] + boardData[1];
  }

  int[] playerCoords() {
    int[] playerPlace = player.getPosition();
    for (int i = 0; i < 2; i++) {
      playerPlace[i] -= boardData[i];
      playerPlace[i] /= boardData[2];
    }
    return playerPlace;
  }

  boolean touchingPerson() {
    int[] playerPlace = playerCoords();
    if (col == playerPlace[0] && row == playerPlace[1]) return true;
    return false;
  }

  boolean properKeyPressed() {
    return keyReleased && (key == ' ' || key == 'f' || key == 'F');
  }

  void display(PuzzleRoom g) {
    if (g.roomSolved) pickedUp = false;
    if (!pickedUp) {
      shapeMode(CORNER);
      shape(this.self, x+.1*boardData[2], y+.1*boardData[2], 0.8*boardData[2], 0.8*boardData[2]);
    } else {
      if (properKeyPressed()) { // put the piece down
        int[] playerPlace = playerCoords();
        g.validNextMove(this, playerPlace[1], playerPlace[0]);
        pickedUp = false;
        keyReleased = false;
      }
      // display a shadow of the piece
      // draw the piece
      shapeMode(CORNER);
      shape(this.self, x+.1*boardData[2], y+.1*boardData[2], 0.8*boardData[2], 0.8*boardData[2]);
      // draw a film on top
      rectMode(CORNER);
      color[] boardColors = new color[] {#ffffdd, #86a666};
      fill(boardColors[(row+col)%2], 3*255/4);
      rect(x, y, boardData[2], boardData[2]);

      // get the player to hold the piece
      int[] playerPlace = player.getPosition();
      shapeMode(CENTER);
      push();
      translate(playerPlace[0], playerPlace[1]);
      rotate(player.mouseAngle());
      shape(this.self, 0, - Player.SIZE, 0.8*boardData[2], 0.8*boardData[2]);
      pop();
    }

    if (touchingPerson() && isWhite && !g.roomSolved) {
      textAlign(CENTER, CENTER);
      textSize(50);
      fill(255);
      text("Press [SPACE] or 'f' to pick up the piece", width/2, 750);
      if (properKeyPressed()) {
        pickedUp = true;
      }
    }
  }
}
