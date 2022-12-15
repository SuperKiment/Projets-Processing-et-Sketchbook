class Grille {
  int taillex, tailley;
  boolean actif;
  color grille[][];
  String nom;
  int tailleRect = 60;

  Grille(int newtaillex, int newtailley, String newNom, int taille) {
    taillex = newtaillex;
    tailley = newtailley;
    grille = new color[taillex][tailley];
    nom = newNom;
    tailleRect = taille;

    for (int x = 0; x<taillex; x++) {
      for (int y = 0; y<tailley; y++) {
        grille[x][y] = vert_gazon;
      }
    }

    grille[2][2] = rouge_pointe;
  }


  void Affichage() {
    push();
    rectMode(CENTER);
    for (int x = 0; x<taillex; x++) {
      for (int y = 0; y<tailley; y++) {     //Passe par toutes les cases


        //Change les couleurs de la grille
        fill(grille[x][y]);


        strokeWeight(3*map(grilleActive.tailleRect, 0, 50, 0, 1));
        rect(x*tailleRect, y*tailleRect, tailleRect, tailleRect);
      }
    }
    fill(255);
    textSize(20);
    text(nom, -tailleRect/2, -tailleRect/2 - 5);
    pop();
  }
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
    if (key == '+') {
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
