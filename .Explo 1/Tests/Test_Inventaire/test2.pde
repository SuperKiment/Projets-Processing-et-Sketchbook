class Stockage {

  int invX, invY, tailleX, tailleY;
  String [][] interieur;
  boolean actif = false;
  int coordX, coordY;


  Stockage(int newinvX, int newinvY, int newtailleX, int newtailleY) {

    invX = newinvX;
    invY = newinvY;
    tailleX = newtailleX;
    tailleY = newtailleY;

    interieur = new String [invX][invY];
    Cases = new Case[invX][invY];

    coordX = (width*3/4)-(tailleX/2);
    coordY = (height/2)-(tailleY/2);
  }

  void Affichage() {
    if (actif) {
      push();
      translate(0, 0, 100);
      stroke(0);
      fill(255);
      if (DansFenetre()) fill(200);
      rectMode(CENTER);
      rect(width*3/4, height/2, tailleX, tailleY);
      pop();

      for (int x=0; x<invX; x++) {
        for (int y=0; y<invY; y++) {
          Cases[x][y].Affichage(coordX, coordY);
        }
      }
    }
  }

  void ActifInactif() {
    int actif2 = 0;

    if (actif) actif2 = 1;
    if (!actif) actif2 = 0;

    switch (actif2) {
    case 0:
      actif = true;
      break;
    case 1:
      actif = false;
      break;
    }
  }

  boolean DansFenetre() {
    boolean oui = false;

    if (mouseX > (width*3/4)-(tailleX/2) && mouseX < (width*3/4)+(tailleX/2) && mouseY < (height/2)+(tailleY/2) && mouseY > (height/2)-(tailleY/2)) {
      return oui = true;
    } else {
      return oui = false;
    }
  }

  //--------------------------------------CASES----------------

  class Case {

    int coordX, coordY, quantite = 0;
    String objet = "";

    Case(int newcoordX, int newcoordY) {
      coordX = newcoordX;
      coordY = newcoordY;
    }
    Case(int newcoordX, int newcoordY, String newobjet, int qt) {
      coordX = newcoordX;
      coordY = newcoordY;
      objet = newobjet;
      quantite = qt;
    }

    void Affichage(int x, int y) {
      push();
      fill(150, 150, 150, 125);
      AffichageRect(x, y);
      fill(255);
      text(quantite, x + coordX*50, y + coordY*50+40);
      pop();
    }

    void AffichageRect(int x, int y) {
      if (objet == "epee") fill(150, 200, 0);
      if (objet == "bouclier") fill(150, 100, 50);
      rect(x + coordX*50, y + coordY*50, 40, 40);
    }
  }

  Case[][] Cases;

  void IniCases() {
    for (int x=0; x<invX; x++) {
      for (int y=0; y<invY; y++) {
        Case caseBase = new Case(x, y);
        Cases[x][y] = caseBase;
      }
    }
  }

  void ptdrEpee() {
    Cases[2][2].objet  = "epee";
    Cases[2][2].quantite++;
    println("epee");
  }

  void Ajouter(String ajout, int qt) {
    boolean pose = false;
    int xw = 0, yw = 0;


    while (pose == false) {

      if (xw == invX) {
        yw++;
        xw = 0;
        println("xw : " + xw);
      }

      if (yw == invY) {
        pose = true;
        println("retour a la ligne");
      }

      if (Cases[xw][yw].objet == ajout && !pose) {
        pose = true;
        Cases[xw][yw].quantite += qt;
        println("posé en ajout");
      }

      if (Cases[xw][yw].objet == "" && !pose) {
        pose = true;
        Case caseBase = new Case(xw, yw, ajout, qt);
        Cases[xw][yw] = caseBase;
        println("posé en rempl");
      }

      xw++;
    }
  }

  void Retirer(int xw, int yw) {
    Case caseBase = new Case(xw, yw);
    Cases[xw][yw] = caseBase;
  }
}

Stockage stockTest = new Stockage(5, 5, 100, 100);

//----------------------------------------------------------------------------

void StockageInterfaces() {
  stockTest.Affichage();
}
