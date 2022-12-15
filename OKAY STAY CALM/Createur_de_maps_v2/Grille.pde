int nbCasesX = 50;
int nbCasesY = 50;

String Grille[][] = new String[nbCasesX][nbCasesY];

String herbe = "herbe";
String terre = "terre";
String roche = "roche";
String arbre = "arbre";
String eau = "eau";

String couleurSelect = terre;

void GrilleReset() {
  for (int x = 0; x<nbCasesX; x++) {
    for (int y = 0; y<nbCasesY; y++) {

      Grille[x][y] = herbe;
    }
  }

  Grille[3][2] = terre;
}

void GrilleAffichage(int taillepixels, int xAff, int yAff) {

  for (int x = 0; x<nbCasesX; x++) {
    for (int y = 0; y<nbCasesY; y++) {

      push();

      rectMode(CORNER);

      //noStroke();

      if (Grille[x][y] == herbe ) fill(0, 180, 68);
      if (Grille[x][y] == terre ) fill(167, 143, 102);
      if (Grille[x][y] == roche ) fill(140, 157, 154);
      if (Grille[x][y] == arbre ) fill(123, 63, 4);
      if (Grille[x][y] == eau ) fill(89, 168, 242);

      if (xAff == 0 && yAff == 0) {
        translate(camX, camY);

        rect(x*taillepixels, y*taillepixels, taillepixels, taillepixels);

        pop();
      } else {
        rect(x*taillepixels + xAff, y*taillepixels + yAff, taillepixels, taillepixels);
        pop();
      }
    }
  }
}

void GrilleRemplacement() {
  if (clickG == true && mouseX-camX>0 && mouseY-camY>0 && mouseX-camX<nbCasesX*50 && mouseY-camY<nbCasesY*50) {
    Grille[int((mouseX-camX)/50)][int((mouseY-camY)/50)] = couleurSelect;
  }
}
