ArrayList<Munition> AllMunitions = new ArrayList<Munition>();

class Munition {

  float x, y, angle, speed;
  float mvtx, mvty;

  Munition(float nx, float ny, float nangle, float nspeed) {
    x = nx;
    y = ny;
    speed = nspeed;
    angle = -nangle+PI/2;
  }

  void Deplacement() {

    mvtx = sin(angle)*speed;
    mvty = cos(angle)*speed;

    x+=mvtx;
    y+=mvty;
  }

  void Affichage() {
    ellipse(x, y, 20, 20);
  }

  void Fonctions() {
    Deplacement();
    Affichage();
  }
}

void Tir() {
  AllMunitions.add(new Munition(width/2, height/2, rotation, 20));
}
