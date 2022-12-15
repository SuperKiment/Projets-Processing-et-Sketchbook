class Pantin {
  float x, y;
  int hp, hpMax;
  boolean indest = false;
  float xScreen, yScreen, taille = 0.4;

  Pantin(float nx, float ny, int nhp, boolean nindest) {
    x = nx;
    y = ny; 
    hp = nhp;
    hpMax = nhp;
    indest = nindest;
  }

  void Affichage() {
    xScreen = x*grilleActive.tailleRect;
    yScreen = y*grilleActive.tailleRect;
    push();
    fill(#D1B737); //Couleur paille
    rectMode(CENTER);
    strokeWeight(2);
    rect(xScreen, yScreen, ConvGrillePixel(taille), ConvGrillePixel(taille));
    pop();

    if (hp != hpMax) {
      push();
      fill(0);
      rectMode(CENTER);       //Barre de vie
      rect(xScreen, yScreen - grilleActive.tailleRect*0.7, hpMax*grilleActive.tailleRect/100, 10);
      fill(255, 0, 0);
      rect(xScreen, yScreen - grilleActive.tailleRect*0.7, hp*grilleActive.tailleRect/100, 8);
      pop();
    }
  }

  void PerdHP(int hpPerdu) {
    if (!indest) {
      hp -= hpPerdu;
      println(hpPerdu + " dégats mis à Pantin en x : "+x+" / y : "+y);
    }
  }

  boolean Mort() {
    if (hp <= 0) {
      println("Pantin mort en x : "+x+" / y : "+y);
      return true;
    } else return false;
  }

  void Fonctions() {
    Affichage();
  }


  boolean Contact(float x1, float y1) {
    if (ConvPixelGrille(x1) > x-ConvPixelGrille(ConvGrillePixel(taille)) &&
      ConvPixelGrille(x1) < x+ConvPixelGrille(ConvGrillePixel(taille)) &&
      ConvPixelGrille(y1) > y-ConvPixelGrille(ConvGrillePixel(taille)) &&
      ConvPixelGrille(y1) < y+ConvPixelGrille(ConvGrillePixel(taille))) {
      println("Contact avec Pantin");
      return true;
    } else return false;
  }
}

void PantinFonctions() {
  for (int i = 0; i<AllPantins.size(); i++) {
    Pantin pantin = AllPantins.get(i);
    pantin.Fonctions();
    if (pantin.Mort()) AllPantins.remove(i);
  }
}

void AjouterPantin(float x, float y, int hp, boolean ind) {
  AllPantins.add(new Pantin(x, y, hp, ind));
  println("Pantin posé en x : "+x+" / y : "+y);
}
