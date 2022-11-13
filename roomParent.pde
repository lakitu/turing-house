public class Room {

  Room() {
    Thread getTexts = new Thread(() -> {
      // initialize the network client
      String url = "https://3eb6-128-197-29-253.ngrok.io";
      try {
        URL urlObject = new URL(url + paths[activeRoom]);
        HttpURLConnection conn = (HttpURLConnection) urlObject.openConnection();
        conn.setRequestMethod("GET");
        conn.connect();
        int status = conn.getResponseCode();
        println(status);
      }
      catch (Exception e) {
        println(e);
      }
    }
    );
    getTexts.start();
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
