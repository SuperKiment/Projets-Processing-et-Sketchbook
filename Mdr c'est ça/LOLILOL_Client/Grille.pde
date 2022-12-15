void Grille() {

  for (int j = 0; j < 50; j++) {
    for (int i = 0; i < 50; i++) {

      if (Tableau[i][j] == 0) {
        fill(0, 0, 0);
      }
      if (Tableau[i][j] == 1) {
        fill(255, 0, 0);
      }
      if (Tableau[i][j] == 2) {
        fill(0, 255, 0);
      }
      if (Tableau[i][j] == 3) {
        fill(0, 0, 255);
      }
      if (Tableau[i][j] == 4) {
        fill(255, 255, 255);
      }

      rect(i*50, j*50, 50, 50);
    }
  }
}

int [][] Tableau = new int [50][50];

void IntGrille() {

  for (int j = 0; j < 50; j++) {
    for (int i = 0; i < 50; i++) {

      Tableau[i][j] = int(random(0, 4.5));
    }
  }
}
