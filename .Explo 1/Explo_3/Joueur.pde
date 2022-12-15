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
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'h')) y--;
      }
      if (bas    == true && y < ValDimensionActuelle("y")-1) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'b')) y++;
      }
      if (gauche == true && x > 0) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'g')) x--;
      }
      if (droite == true && x < ValDimensionActuelle("x")-1) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'd')) x++;
      }
    }
  }

  void Affichage() {
    push();
    fill(255);
    TranslateJoueur();
    rect(x*50, y*50, 50, 50);
    pop();
  }

  void Suiveur() {
    push();

    if (x*50>xSui) xSui+=vitesseSui;
    if (x*50<xSui) xSui-=vitesseSui;
    if (y*50>ySui) ySui+=vitesseSui;
    if (y*50<ySui) ySui-=vitesseSui;

    TranslateJoueur();    

    fill(255, 0, 0);
    rect(xSui, ySui, 50, 50);

    pop();
  }

  void ChangeurDeCouleur() {
    Dim0.Grille[x][y] = "sol";
  }

  void ResetPos() {
    x = 5;
    y = 5;
    xSui = 500;
    ySui = 500;
  }

  void TranslateJoueur() {
    translate(-xSui+width/2-25, -ySui+height/2-25);
  }


  boolean poseBloc = false;

  void Selectionneur(int portee) {

    if (mouseX > width/2-portee*50 && mouseX < width/2+portee*50 && mouseY > height/2-portee*50 && mouseY < height/2+portee*50) {
      push();

      ellipse(mouseX, mouseY, 10, 10);
      poseBloc = true;

      pop();
    } else {
      poseBloc = false;
    }
  }

  void PoseBloc() {

    int blocPointeX = int(mouseX+joueur1.xSui+width/2-25)/50-35;
    int blocPointeY = int(mouseY+joueur1.ySui+height/2-25)/50-19;

    if (poseBloc) {

      switch(dimensionActive) {
      case 0:
        if (blocPointeX >= 0 && blocPointeX < Dim0.x && blocPointeY >= 0 && blocPointeY < Dim0.y) {
          
          Dim0.Grille[blocPointeX][blocPointeY] = barreInventaire.objSelect;
          
          println("Bloc posé : x : " + (blocPointeX) + " y : " + (blocPointeY));
          break;
        }

      case 1:
        if (blocPointeX >= 0 && blocPointeX < Dim1.x && blocPointeY >= 0 && blocPointeY < Dim1.y) {
          Dim1.Grille[blocPointeX][blocPointeY] = "arbre";
          println("Bloc posé : x : " + (blocPointeX) + " y : " + (blocPointeY));
          break;
        }
      }
    }
  }
}


//---------------------------------------------------------------------------------

void JoueurFonctions() {
  //joueur1.Affichage();
  joueur1.ChronoJoueur();
  joueur1.DeplacementContinu();
  joueur1.Suiveur();
  joueur1.Selectionneur(4);
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
    ok = true;
    break;
  case "roche":
    ok = false;
    break;
  case "arbre":
    ok = false;
    break;
  case "eau":
    ok = true;
    break;
  case "eau claire":
    ok = true;
    break;
  case "eau profonde":
    ok = false;
    break;
  case "feuilles":
    ok = false;
    break;
  case "mur":
    ok = false;
    break;
  case "piques":
    ok = false;
    break;
  }

  return ok;
}
