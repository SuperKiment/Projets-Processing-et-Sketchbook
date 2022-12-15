class Grille {
  int taillex, tailley;
  boolean actif;
  color grille[][];
  String nom;
  int tailleRect = 60;
  int timerVerd, intervalleVerd = 5000;

  Grille(int newtaillex, int newtailley, String newNom, int taille) {
    taillex = newtaillex;
    tailley = newtailley;
    grille = new color[taillex][tailley];
    nom = newNom;
    tailleRect = taille;

    for (int x = 0; x<taillex; x++) {
      for (int y = 0; y<tailley; y++) {  //Mettre toutes les cases vertes
        grille[x][y] = vert_gazon;
      }
    }

    grille[2][2] = rouge_pointe;   //Case test
  }


  void Affichage() {
    push();
    rectMode(CENTER);
    for (int x = 0; x<taillex; x++) {
      for (int y = 0; y<tailley; y++) {     //Passe par toutes les cases
        fill(grille[x][y]);                //Affichage des cases colorées
        strokeWeight(3*map(grilleActive.tailleRect, 0, 50, 0, 1));    
        rect(x*tailleRect, y*tailleRect, tailleRect, tailleRect);
      }
    }
    fill(255);
    textSize(20);
    text(nom, -tailleRect/2, -tailleRect/2 - 5);  //Nom de la grille active
    pop();
  }

  void Verdification() {
    if (millis() - timerVerd >= intervalleVerd) {  //Tous les intervalleVerd :
      timerVerd = millis();

      boolean vertOK = false;
      int x=0, y=0;
      int compteur = 0;

      while (!vertOK) {
        compteur++;
        if (compteur >= 10) vertOK = true;        //Prend une case au hasard et la verdit
        //Si elle est déjà verte, recommencer 
        x = int(random(0, taillex));
        y = int(random(0, tailley));

        if (grille[x][y] != vert_gazon) {
          grille[x][y] = vert_gazon;
          vertOK = true;                       //Verdification
          intervalleVerd = int(random(100, 500));
        }
      }
    }
  }
}

void GrilleFonctions() {
  grilleActive.Affichage(); 
  grilleActive.Verdification();
}

//----------------------------------------------------------------------------

void CreationGrilles() {
  ToutesGrilles.add(new Grille(7, 7, "Base", 50)); 
  ToutesGrilles.add(new Grille(10, 10, "Test 2", 50)); 
  ToutesGrilles.add(new Grille(50, 50, "Test Grand", 10));
}

//----------------------------------------------------------------------------

void ChangementGrille() {
  if (key == '+' || key == '-') {
    joueur.ResetPos(); 
    if (key == '+') {                                      //Passer d'une grille à l'autre
      if (noGrilleActive+1 < ToutesGrilles.size()) {
        noGrilleActive++; 
        println("Changement de grille active : " + ToutesGrilles.get(noGrilleActive).nom +
          " / grille n°" + noGrilleActive);
      }
    }
    if (key == '-') {
      if (noGrilleActive-1 > -1) {
        noGrilleActive--; 
        println("Changement de grille active : " + ToutesGrilles.get(noGrilleActive).nom +
          " / grille n°" + noGrilleActive);
      }
    }
  }
}
