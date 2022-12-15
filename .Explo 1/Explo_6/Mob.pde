Mob mob1;

class Mob {

  int x, y, hp = 100, vitesse = 10;
  PImage texture;
  int dimension = 0;

  Mob(int newx, int newy, PImage image, int newdimension) {
    x = newx;
    y = newy;
    texture = image;
    dimension = newdimension;

    println("créé : Mob");
  }


  void Affichage() {
    if (dimensionActive == dimension) {
      push();
      fill(255);
      TranslateArPl(true);
      try {
        image(texture, x*50, y*50);
      }
      catch(Exception e) {
        rect(x*50, y*50, 50, 50);
        println("Pas de sanglier");
      }
      pop();
    }
  }
}

void MobIni() {
  mob1 = new Mob(12, 15, ImMob1, 0);
}

void MobsFonctions() {
  mob1.Affichage();
}
