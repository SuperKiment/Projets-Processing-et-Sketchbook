
class Explosion {

  float x, y, radius = 0;
  float radiusMax;

  Explosion(float nx, float ny, float nradiusMax) {
    x = nx;
    y = ny;
    radiusMax = nradiusMax*map(grilleActive.tailleRect, 0, 50, 0, 1);
  }

  void Affichage() {
    push();
    fill(#FF5E00);
    ellipse(x, y, radius, radius);
    pop();
  }

  void Expension() {
    radius += (radiusMax-radius)/8;
  }

  boolean StopExplosion() {
    if (radiusMax - radius < 5) return true; 
    else return false;
  }

  void Fonctions() {
    Expension();
    Affichage();
  }
}

void Explosions() {
  for (int i = 0; i<AllExplosions.size(); i++) {
    Explosion explosion = AllExplosions.get(i);
    explosion.Fonctions();
    if (explosion.StopExplosion()) {
      AllExplosions.remove(i);
      println("Explosion finie");
    }
  }
}

void Explosion(float x, float y, int radius) {
  AllExplosions.add(new Explosion(x, y, radius));
  println("Explosion ajoutée :    x : " + x + " / y : " + y + " / radius : " + radius);
}
