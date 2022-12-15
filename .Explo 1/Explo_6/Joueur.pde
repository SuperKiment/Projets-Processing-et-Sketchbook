class Joueur {
  int x, y, hp = 100;
  float recupDepl, chronoDepl, stopDepl;
  int vitesse = 100;
  boolean haut, bas, droite, gauche, deplacementOk;
  float xSui, ySui, vitesseSui = 10;
  Terrain dimension;

  Joueur(int newx, int newy) {
    x = newx;
    y = newy;
    xSui = newx*50;
    ySui = newy*50;

    println("créé : Joueur");
  }

  void RecupJoueur() {
    stopDepl = millis();
  }

  void ChronoJoueur() {
    deplacementOk = false;
    chronoDepl = millis() - stopDepl;       //Deplacement de case en cases non saccadé
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
      gauche = true;      //booleans haut bas tout ça = true
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
      gauche = false;      //booleans haut bas tout ça = false
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
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'b')) y++;  //Verif collision et que booleans = true
      }
      if (gauche == true && x > 0) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'g')) x--;  //Puis déplacement
      }
      if (droite == true && x < ValDimensionActuelle("x")-1) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'd')) x++;
      }
    }

    vitesse = 100;
    vitesseSui = 10;

    switch (dimension.Grille[x][y]) {
    case "eau" :
      vitesse = 200;
      vitesseSui = 5;              //Ralentissement par l'eau
      break;
    }
  }

  void Affichage() {
    push();
    fill(255);
    TranslateJoueur();      //Affichage mdr il est pas actif
    rect(x*50, y*50, 50, 50);
    pop();
  }

  void Suiveur() {
    push();

    if (x*50>xSui) xSui+=vitesseSui;
    if (x*50<xSui) xSui-=vitesseSui;  //// Suiveur smooth à refaire avec un offset et des /10 tout ça
    if (y*50>ySui) ySui+=vitesseSui;
    if (y*50<ySui) ySui-=vitesseSui;

    TranslateJoueur();    

    fill(255, 0, 0);
    rect(xSui, ySui, 50, 50);

    pop();
  }

  void ChangeurDeCouleur() {
    Dim0.Grille[x][y] = "sol";    //Depl coloré
  }

  void ResetPos() {
    x = 5;
    y = 5;             //Tp spawn
    xSui = 500;
    ySui = 500;
  }

  void TranslateJoueur() {
    translate(-xSui+width/2-25, -ySui+height/2-25);   //Translate du joueur
  }


  boolean poseBloc = false;

  void Selectionneur(int portee) {

    if (mouseX > width/2-portee*50 && mouseX < width/2+portee*50 && mouseY > height/2-portee*50 && mouseY < height/2+portee*50) {
      push();//Si la souris est à portée

      ellipse(mouseX, mouseY, 10, 10);  //Faire une ellipse toute mignonne
      poseBloc = true;  //Autorisé à poser

      pop();
    } else {
      poseBloc = false;
    }
  }

  void PoseBloc() {

    int blocPointeX = int(mouseX+joueur1.xSui+width/2-25)/50-35;
    int blocPointeY = int(mouseY+joueur1.ySui+height/2-25)/50-19;// Là où est la souris sur le terrain

    if (poseBloc) {

      switch(dimensionActive) {
      case 0:
        if (blocPointeX >= 0 && blocPointeX < Dim0.x && blocPointeY >= 0 && blocPointeY < Dim0.y) {

          Dim0.Grille[blocPointeX][blocPointeY] = barreInventaire.objSelect;

          //Pose dans la dimension active

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

  void SprintOn() {
    vitesse = 50;
    vitesseSui = 20;
  }
  void SprintOff() {
    vitesse = 100;
    vitesseSui = 10;
  }

  void DimensionActuelle() {
    switch (dimensionActive) {
    case 0 :
      dimension = Dim0;         //recup de la dim active pour analyse pas pour changement
      break;
    case 1 :
      dimension = Dim1;
      break;
    }
  }
}


//---------------------------------------------------------------------------------

void JoueurFonctions() {
  joueur1.DimensionActuelle();
  //joueur1.Affichage();
  joueur1.ChronoJoueur();
  joueur1.DeplacementContinu(); //Fonctions
  joueur1.Suiveur();
  joueur1.Selectionneur(4);
  //joueur1.ChangeurDeCouleur();
}

Joueur joueur1 = new Joueur(5, 5);

boolean VerifCollisionOk(int x, int y, String Tabl[][], char direction) {
  boolean ok = true;


  switch (direction) {  //Verificateur de collision
    //Renvoie true si il y a pas de coll
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
    break;         //A automatiser
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
