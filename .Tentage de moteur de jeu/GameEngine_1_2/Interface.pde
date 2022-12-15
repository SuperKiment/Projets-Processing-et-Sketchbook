void Fond() {
  background(0);
  int taille = 100;
  push();
  stroke(125);
  for (int i=0; i<width/taille; i++) {
    line(i*taille, 0, i*taille, height);    //Grille de taille par taille
  }
  for (int i=0; i<height/taille; i++) {
    line(0, i*taille, width, i*taille);
  }
  pop();
}

void Devant() {
  consoleE.Affichage();
}

class ConsoleE {
  float x = 0, y = 0, tx = 300;
  float tailleTxt = 10;

  StringList liste = new StringList();

  ConsoleE(float ntx) {
    tx = ntx;
  }
  ConsoleE() {
  }

  void Affichage() {

    push();
    resetMatrix();
    translate(x, y);
    fill(255, 255, 255, 100);
    noStroke();
    rect(0, 0, tx, liste.size()*tailleTxt);

    for (int i = 0; i<liste.size(); i++) {
      String aff = liste.get(i);

      fill(0);
      textSize(tailleTxt);
      text(aff, 0, i*tailleTxt+tailleTxt);
    }

    pop();
  }

  void add(String ajout) {
    liste.append(ajout);
  }
}
ConsoleE consoleE;
