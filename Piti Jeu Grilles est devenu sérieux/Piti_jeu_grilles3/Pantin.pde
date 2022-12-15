class Pantin {
  float x, y;
  int hp = 100, hpMax = 100;
  boolean indest = false;
  float xScreen, yScreen, taille = 0.4;
  float DPS = 0, DernierDPS, timerDPS = 0, intervalleDPS = 1000, maxDPS;

  Pantin(float nx, float ny, boolean nindest) {
    x = nx;
    y = ny;                   //Constructeur Indestructible
    indest = nindest;
  }

  Pantin(float nx, float ny, int nhp) {
    x = nx;
    y = ny;                   //Constructeur Destructible avec HP
    hp = nhp;
    hpMax = nhp;
  }

  Pantin(float nx, float ny) {
    x = nx;
    y = ny;                   //Constructeur Basique
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

    JaugeDPS();
  }

  void PerdHP(int hpPerdu) {
    if (!indest) {
      hp -= hpPerdu;
      println(hpPerdu + " dégats mis à Pantin en x : "+x+" / y : "+y);
    } else {
      DPS += hpPerdu;
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
      ConvPixelGrille(y1) > y-ConvPixelGrille(ConvGrillePixel(taille)) &&  //Si x1;y1 est en contact avec le pantin
      ConvPixelGrille(y1) < y+ConvPixelGrille(ConvGrillePixel(taille))) {
      println("Contact avec Pantin");
      return true;
    } else return false;
  }

  void JaugeDPS() {

    if (millis() - timerDPS >= intervalleDPS) {
      timerDPS = millis();
      DernierDPS = DPS;
      DPS = 0;

      if (maxDPS < DernierDPS) maxDPS = DernierDPS;
    }

    if (indest && DernierDPS != 0) {
      push();
      fill(0);
      rectMode(CENTER);                                      //Jauge Degats Par Seconde
      rect(xScreen, yScreen - grilleActive.tailleRect*0.7, 50, 20);
      fill(255);
      textSize(12);
      text(int(DernierDPS), xScreen-20, yScreen - grilleActive.tailleRect*0.7);
      text(int(maxDPS), xScreen-20, yScreen - grilleActive.tailleRect*0.7+10);
      pop();
    }
  }
}

void PantinFonctions() {
  for (int i = 0; i<AllPantins.size(); i++) {
    Pantin pantin = AllPantins.get(i);       //Mort du pantin et fonctions
    pantin.Fonctions();
    if (pantin.Mort()) AllPantins.remove(i);
  }
}

void AjouterPantinIndest(float x, float y) {
  AllPantins.add(new Pantin(x, y, true));
  println("Pantin posé en x : "+x+" / y : "+y);
}

void AjouterPantin(float x, float y, int hp) {
  AllPantins.add(new Pantin(x, y, hp));
  println("Pantin posé en x : "+x+" / y : "+y);
}
