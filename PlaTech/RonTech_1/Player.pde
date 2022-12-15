class Player {

  PVector pos, vel, dirCible, dir, acc, taille;
  boolean controllable = false;
  float speed = 0.1, rotSpeed = 0.1;
  String name = "";

  ArrayList<Module> AllModules = new ArrayList<Module>();

  Player() {
    Constructor();
  }

  Player(float x, float y) {
    Constructor();
    pos = new PVector(x, y);
  }

  void Constructor() {
    pos = new PVector();
    vel = new PVector();
    dirCible = new PVector();
    dir = new PVector();
    acc = new PVector();
    taille = new PVector(50, 50);
  }

  void Display() {

    for (Module m : AllModules) {
      m.Display();
    }

    push();
    translate(pos.x*map.tailleCase, pos.y*map.tailleCase);

    ellipse(0, 0, taille.x, taille.y);

    pop();
  }

  void Update() {
    Deplacement();

    for (int i=0; i<AllModules.size(); i++) {
      Module m = AllModules.get(i);
      m.Update();
    }
  }

  void Deplacement() {
    dirCible = inputControl.keyDir; 

    vel = dirCible; 
    vel.setMag(speed); 

    pos.add(vel);
  }

  boolean IsOnThis(float x, float y) {
    float tailleCase = map.tailleCase; 
    if (x >= pos.x * tailleCase - taille.x/2 &&
      x <= pos.x * tailleCase + taille.x/2 &&
      y >= pos.y * tailleCase - taille.y/2 &&
      y <= pos.y * tailleCase + taille.y/2) {
      return true;
    } else return false;
  }

  String Print() {
    String pr = name; 
    if (pr.equals("")) pr = "NoName"; 

    return "Ensemble " + pr + " / Position " + pos;
  }
}
