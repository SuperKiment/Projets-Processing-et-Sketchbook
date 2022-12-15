enum Faction {
  Ennemy, Ally, NeutralP, NeutralA;
}
ArrayList<Entite> Entites = new ArrayList<Entite>();
int nbEntites = 50;

class Entite {

  PVector pos, acc, vel, drag;
  float taille;
  color couleur;
  Faction faction;
  float speed = 100, forceDrag = 0.01, changeSpeed = 0.1;

  Entite(float x, float y, float nt, Faction f) {
    pos = new PVector(x, y);
    Setup(nt, f);
  }
  Entite(PVector p, float nt, Faction f) {
    pos = p;
    Setup(nt, f);
  }

  void Setup(float nt, Faction f) {
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    taille = nt;
    faction = f;
    couleur = CouleurFaction(f);
  }


  void Update() {

    if (mousePressed) {
      acc = new PVector(mouseX-pos.x, mouseY-pos.y);
      acc.normalize();
      acc.setMag(speed);
    }else {
      acc = vel;
    }

    Drag();
    Deplacement();
    Display();
  }

  void Display() {
    push();

    fill(couleur);
    circle(pos.x, pos.y, taille);

    pop();
  }

  void Deplacement() {
    vel.lerp(acc, changeSpeed);
    vel.sub(drag);
    pos.add(vel);
  }
  void Drag() {
    drag = vel;
    drag.mult(forceDrag);
  }
}

void EntiteDisplay() {
  for (Entite ent : Entites) {
    ent.Update();
  }
}
