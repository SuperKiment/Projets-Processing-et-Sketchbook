class Oiseau {

  float speed = 5, taille = 10;
  PVector position, dir, vel, dirC;

  Oiseau(PVector pos) {
    position = pos;
    dir = new PVector(0, 1);
    dirC = new PVector(1, 0);
    vel = new PVector(sqrt(2), sqrt(2));
  }
  Oiseau(PVector pos, PVector dire) {
    position = pos;
    dir = dire;
    dirC = new PVector(1, 0);
    vel = new PVector(sqrt(2)/2, sqrt(2)/2);
  }

  void Affichage() {
    push();
    fill(0);
    stroke(255);
    translate(position.x, position.y);

    ellipse(0, 0, taille, taille);

    stroke(255);
    line(0, 0, vel.x*taille*2, vel.y*taille*2);

    stroke(255, 0, 0);
    line(0, 0, dir.x*taille*2, dir.y*taille*2);

    pop();
  }

  void Depl() {
    position.add(vel);
  }
}

Oiseau test = new Oiseau(new PVector(50, 50));
