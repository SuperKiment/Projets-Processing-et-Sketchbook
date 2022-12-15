Map map;

class Map {

  ArrayList<Player> AllPlayers;
  int tailleCase = 50;
  float tailleBlocs = 20;


  Map() {
    AllPlayers = new ArrayList<Player>();

    Player e = new Player(5, 5);
    e.controllable = true;

    AllPlayers.add(e);
  }

  void Display() {

    push();
    stroke(255);
    strokeWeight(0.1);
    for (int x = 1; x<=50*tailleCase; x+=tailleCase) {
      line(x, 0, x, 10000);
      push();
      fill(255);
      textSize(10);
      text(x-1 + " , " + x/tailleCase, x, 0);
      pop();
    }

    for (int y = 1; y<=50*tailleCase; y+=tailleCase) {      
      line(0, y, 10000, y);
      push();
      fill(255);
      textSize(10);
      text(y-1 + " , " + y/tailleCase, 0, y);
      pop();
    }
    pop();

    for (Player e : AllPlayers) {
      e.Display();
    }
  }

  void Update() {
    for (Player e : AllPlayers) {
      e.Update();
    }
  }
}
