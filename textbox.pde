public class Textbox {
  int x, y, w, h;
  int start;
  String text;
  boolean focus = false;

  Textbox(int _x, int _y, int _w, int _h) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
    start = x - w/2 + 20;
    text = "";
  }

  public void display() {
    rectMode(CENTER);
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);

    fill(0);
    textAlign(LEFT, CENTER);
    textSize(60);
    text(text, start, y-10);
  }

  public boolean hovering() {
    return mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2;
  }
  
  public boolean hasBlinker() {
    if (text.equals("")) return false;
    return text.charAt(text.length()-1) == '|';
  }
  
  public String removeLast (String s) {
    if (s.equals("")) return "";
    return s.substring(0, s.length()-1);
  }

  public void move() {
    if (mousePressed) {
      focus = hovering();
    }
    if (focus) {
      if (frameCount % 120 < 60 && !hasBlinker()) text = text + "|";
      if (frameCount % 120 >= 60 && hasBlinker()) text = removeLast(text);
    }
    
    if (focus && keyReleased) {
      if (hasBlinker()) text = removeLast(text);
      if (key == BACKSPACE) text = removeLast(text);
      else if (text.length() == 10) return;
      else if (Character.isDigit(key)) text += key;
      text += '|';
    }
  }

  public void render() {
    move();
    display();
  }
}
