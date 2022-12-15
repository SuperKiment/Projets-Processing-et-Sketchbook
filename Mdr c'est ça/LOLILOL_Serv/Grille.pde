PImage herbe;
PImage herbe2;
PImage sol;
PImage sol2;
PImage roche;
int tailleGrille = 100;

void Grille() {

  push();



  for (int j = 0; j < tailleGrille; j++) {
    for (int i = 0; i < tailleGrille; i++) {

      if (Tableau[i][j] == 0) {
        fill(127, 77, 5);
        image(sol2, i*50, j*50);
      }

      if (Tableau[i][j] == 1) {
        fill(169, 169, 169);
        image(roche, i*50, j*50);
      }

      if (Tableau[i][j] == 2) {
        fill(161, 110, 1);
        image(sol, i*50, j*50);
      }

      if (Tableau[i][j] == 3) {
        fill(0, 121, 11);
        image(herbe, i*50, j*50);
      }

      if (Tableau[i][j] == 4) {
        fill(1, 152, 26);
        image(herbe2, i*50, j*50);
      }
    }
  }

  pop();
}

int [][] Tableau = new int [tailleGrille][tailleGrille];

void IntGrille() {

  for (int j = 0; j < tailleGrille; j++) {
    for (int i = 0; i < tailleGrille; i++) {

      Tableau[i][j] = int(random(0, 4.5));
    }
  }
}
