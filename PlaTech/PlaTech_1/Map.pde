Map map;

class Map {

  ArrayList<Ensemble> AllEnsembles;
  int tailleCase = 50;
  float tailleBlocs = 20;


  Map() {
    AllEnsembles = new ArrayList<Ensemble>();

    Ensemble e = new Ensemble(5, 5);
    e.controllable = true;

    AllEnsembles.add(e);
  }

  void Display() {

    push();
    stroke(255);
    strokeWeight(0.1);
    for (int x = 1; x<=50*tailleCase; x+=tailleCase) {
      line(x, 0, x, 10000);
    }

    for (int y = 1; y<=50*tailleCase; y+=tailleCase) {      
      line(0, y, 10000, y);
    }
    pop();

    for (Ensemble e : AllEnsembles) {
      e.Display();
    }
  }

  void Update() {
    for (Ensemble e : AllEnsembles) {
      e.Update();
    }
  }
}
