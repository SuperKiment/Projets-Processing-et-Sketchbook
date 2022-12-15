
int nbCasesX = 50;
int nbCasesY = 50;

float echelle = 1;

float tailleCase = 50*echelle;


String Grille[][] = new String[nbCasesX][nbCasesY];

String herbe = "herbe";
String terre = "terre";
String roche = "roche";   //Ini des strings pour ne pas utiliser à chaque fois des chaines et eviter les erreurs
String arbre = "arbre";
String eau = "eau";

String couleurSelect = terre;

void GrilleReset() {
  for (int x = 0; x<nbCasesX; x++) {
    for (int y = 0; y<nbCasesY; y++) {


      Grille[x][y] = herbe;
    }
  }

  Grille[3][2] = terre;       //Point remarquable
}

void GrilleAffichage(int taillepixels, int xAff, int yAff) {

  tailleCase = 50*echelle;

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

      if (xAff == 0 && yAff == 0) {   //Si c'est le display de la grille de jeu (pas une minimap)
        translate(camX, camY);
        
        scale(echelle);
        rect(x*taillepixels, y*taillepixels, taillepixels, taillepixels);

        pop();
      } else {
        rect(x*taillepixels + xAff, y*taillepixels + yAff, taillepixels, taillepixels);    //Sinon c'est une minimap donc pas de scale() etc.
        pop();
      }
    }
  }
}

void GrilleRemplacement() {

  if (clickG == true && mouseX-camX>0 && mouseY-camY>0 && mouseX-camX<nbCasesX*tailleCase && mouseY-camY<nbCasesY*tailleCase) {
//Je sais pas comment j'ai fait mais ça marche mdr
    Grille[int((mouseX-camX)/echelle/50)][int((mouseY-camY)/echelle/50)] = couleurSelect;
  }
}
