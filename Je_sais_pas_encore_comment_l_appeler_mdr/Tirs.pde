class Tir {
  int x_dep;
  int y_dep;
  int x;
  int y;
  int taillex;
  int tailley;

  int Compteur;

  boolean feu = false;

  Tir(int nouvx, int nouvy, int nouvtaillex, int nouvtailley) {
    x = nouvx;
    y = nouvy;
    taillex = nouvtaillex;
    tailley = nouvtailley;
  }

  void aff() {
    ellipseMode(CENTER);
    fill(200, 0, 0);
    ellipse(x, y, taillex, tailley);
  }

  void feu_Ini(int xShipz, int yShipz) {
    x_dep = xShipz + width/60;
    y_dep = yShipz + height/40;
    Compteur = 0;
    feu = true;
  }

  void feu(int sens) {
    if (feu == true) {
      x = x_dep + Compteur;
      y = y_dep;
      Compteur = Compteur + (20*sens);
    }
    if (x > width) { 
      feu = false; 
      x = width/20; 
      y = height/6;
    }
  }
}


void Affichage_Tirs() {
  tir_G.aff();
  tir_G.feu(1);
  tir_D.aff();
  tir_D.feu(-1);
}


void Tir_G() {
  tir_G.feu_Ini(xShipG, yShipG);
}

void Tir_D() {
  tir_D.feu_Ini(xShipD, yShipD);
}
