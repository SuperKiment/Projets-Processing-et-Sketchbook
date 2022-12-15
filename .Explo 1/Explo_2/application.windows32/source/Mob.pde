Mob mob1 = new Mob(12, 15, "Textures/Mob1.png", 0);

class Mob {

  int x, y, hp = 100, vitesse = 10;
  PImage texture = ImageMob1;
  int dimension = 0;

  Mob(int newx, int newy, String image, int newdimension) {
    x = newx;
    y = newy;
    texture = ImageMob1;
    dimension = newdimension;
  }

  void Affichage() {
    if (dimensionActive == dimension) {
      push();
      fill(255);
      TranslateArPl();
      try {
        image(ImageMob1, x*50, y*50);
      }
      catch(Exception e) {
        rect(x*50, y*50, 50, 50);
      }
      pop();
    }
  }
}

void MobsFonctions() {
  mob1.Affichage();
}
