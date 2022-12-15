String Grille[][] = new String[50][50];

String herbe = "herbe";

void GrilleReset() {
  for (int x = 0; x<50; x++) {
    for (int y = 0; y<50; y++) {

      Grille[x][y] = herbe;
    }
  }
}

void GrilleAffichage() {

  for (int x = 0; x<50; x++) {
    for (int y = 0; y<50; y++) {
      
      push();
      
      rectMode(CORNER);
      rect(x*50, y*50, 50, 50);
      
      pop();
    }
  }
}
