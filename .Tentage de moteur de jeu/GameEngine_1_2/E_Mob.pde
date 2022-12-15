class Mob extends Entite {  
  Mob(float x, float y, String nom) {
    super(x, y, nom);
  }

  Mob() {
    super();
  }
}

class NuageEntites extends Mob {

  ArrayList<Particule> AllParticules = new ArrayList<Particule>();
  int nbParticules = 20;

  NuageEntites() {  
    super();
    Constructeur();
  }

  NuageEntites(float x, float y, String nom) {
    super(x, y, nom);
    Constructeur();
  }

  void Constructeur() {
    for (int i=0; i<nbParticules; i++) {
      AllParticules.add(new Particule(taille));
    }
    controllable = true;
  }

  void DisplayEntite() {

    for (Particule part : AllParticules) {
      part.Display();
    }
  }

  class Particule extends Entite {

    float range;
    float taille = 5;

    Particule(float r) {
      super();
      range = r/2;      
      position = new PVector(random(-range, range), random(-range, range));
    }

    void DisplayEntite() {
      push();
      fill(255, 0, 0);
      ellipse(position.x, position.y, taille, taille);
      pop();
    }
  }
}
