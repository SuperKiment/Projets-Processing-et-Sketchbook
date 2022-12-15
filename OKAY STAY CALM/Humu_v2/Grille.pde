String Grille[][] = new String[50][50];

String herbe = "herbe";
String terre = "terre";
String roche = "roche";
String arbre = "arbre";
String eau = "eau";

void GrilleReset() {
  for (int x = 0; x<50; x++) {
    for (int y = 0; y<50; y++) {

      Grille[x][y] = herbe;
    }
  }
  
  Grille[3][2] = terre;
  
}

void GrilleAffichage() {

  for (int x = 0; x<50; x++) {
    for (int y = 0; y<50; y++) {
      
      push();
      
      rectMode(CORNER);
      
      noStroke();
      
      if (Grille[x][y] == herbe ) fill(0,180,68);
      if (Grille[x][y] == terre ) fill(167,143,102);
      if (Grille[x][y] == roche ) fill(140,157,154);
      if (Grille[x][y] == arbre ) fill(123,63,4);
      if (Grille[x][y] == eau ) fill(89,168,242);
      rect(x*50, y*50, 50, 50);
      
      pop();
    }
  }
}
