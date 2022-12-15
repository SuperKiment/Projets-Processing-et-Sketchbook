class Joueur {
  int x, y, hp = 100;
  float recupDepl, chronoDepl, stopDepl;
  int vitesse = 100;
  boolean haut, bas, droite, gauche, deplacementOk;
  float xSui, ySui, vitesseSui = 10;

  Joueur(int newx, int newy) {
    x = newx;
    y = newy;
    xSui = newx*50;
    ySui = newy*50;
  }

  void RecupJoueur() {
    stopDepl = millis();
  }

  void ChronoJoueur() {
    deplacementOk = false;
    chronoDepl = millis() - stopDepl;
    if (chronoDepl >= vitesse) {
      RecupJoueur();
      deplacementOk = true;
    }
  }

  void LezGoDepl() {
    deplacementOk = true;
  }

  void DeplacementOn(char depl) {

    switch(depl) {
    case 'z' :
      haut = true;
      break;

    case 'q' :
      gauche = true;
      break;

    case 's' :
      bas = true;
      break;

    case 'd' :
      droite = true;
      break;
    }
  }
  void DeplacementOff(char depl) {

    switch(depl) {
    case 'z' :
      haut = false;
      break;

    case 'q' :
      gauche = false;
      break;

    case 's' :
      bas = false;
      break;

    case 'd' :
      droite = false;
      break;
    }
  }

  void DeplacementContinu() {
    if (deplacementOk == true) {
      if (haut   == true && y > 0) {
        if (VerifCollisionOk(x, y, Dim0.Grille, 'h')) y--;
      }
      if (bas    == true && y < Dim0.y-1) {
        if (VerifCollisionOk(x, y, Dim0.Grille, 'b')) y++;
      }
      if (gauche == true && x > 0) {
        if (VerifCollisionOk(x, y, Dim0.Grille, 'g')) x--;
      }
      if (droite == true && x < Dim0.x-1) {
        if (VerifCollisionOk(x, y, Dim0.Grille, 'd')) x++;
      }
    }
  }

  void Affichage() {
    push();
    fill(255);
    translate(-xSui+475, -ySui+475);
    rect(x*50, y*50, 50, 50);
    pop();
  }

  void Suiveur() {
    push();

    if (x*50>xSui) xSui+=vitesseSui;
    if (x*50<xSui) xSui-=vitesseSui;
    if (y*50>ySui) ySui+=vitesseSui;
    if (y*50<ySui) ySui-=vitesseSui;

    translate(-xSui+475, -ySui+475);

    fill(255, 0, 0);
    rect(xSui, ySui, 50, 50);

    pop();
  }

  void ChangeurDeCouleur() {
    Dim0.Grille[x][y] = "sol";
  }
}

void JoueurFonctions() {
  //joueur1.Affichage();
  joueur1.ChronoJoueur();
  joueur1.DeplacementContinu();
  joueur1.Suiveur();
  //joueur1.ChangeurDeCouleur();
}

Joueur joueur1 = new Joueur(5, 5);

boolean VerifCollisionOk(int x, int y, String Tabl[][], char direction) {
  boolean ok = true;


  switch (direction) {

  case 'd' :
    x++;
    break;

  case 'g' :
    x--;
    break;

  case 'b' :
    y++;
    break;

  case 'h' :
    y--;
    break;
  }

  switch(Tabl[x][y]) {
  case "herbe":
    ok = true;
    break;
  case "sol":
    ok = false;
    break;
  }

  return ok;
}
