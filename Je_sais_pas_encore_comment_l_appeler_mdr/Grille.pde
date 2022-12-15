int [][] Grille = new int[30][20];



void Ini_Grille() {
  for (int x = 0; x < 30; x = x+1) {
    for (int y = 0; y < 20; y = y+1) {
      Grille [x][y] = int(random(25, 60));  //Donne une valeur entre 25 et 60 en entier aux cases de la Grille

      fill(50);
      noStroke();

      rectMode(CORNER);                                           //Dessine la Grille une première fois
      rect(x*(width/30), y*(height/20), width/30, height/20);
    }
  }
}


void Grille() {
  for (int x = 0; x < 30; x = x+1) {
    for (int y = 0; y < 20; y = y+1) {

      fill(Grille[x][y]);
      noStroke();                         //Dessine la Grille en continu
      rectMode(CORNER);
      rect(x*(width/30), y*(height/20), width/30, height/20);
    }
  }
}
