class ItemAuSol {

  int x, y, quantite;
  String objet;
  int taille = int(random(5, 15));
  int xoffset = int(random(0, 50-taille)), yoffset = int(random(0, 50-taille));

  ItemAuSol(int newx, int newy, String newobjet) {
    x = newx;
    y = newy;
    objet = newobjet;
    println("créé : Item au sol");
  }

  void Affichage() {
    push();
    TranslateArPl(true);
    fill(255);
    stroke(0);
    strokeWeight(3);
    rect(x*50+ xoffset, y*50+yoffset, taille, taille);
    pop();
  }

  boolean APortee() {
    if (abs(joueur1.x - x) <= 1) {
      return true;
    } else return false;
  }
}

ItemAuSol itemTest = new ItemAuSol(3, 2, "coucou");

//------------------------------------------------------------------------------------

void ItemsAuSol() {
  itemTest.Affichage();
}

void ItemsIni() {
}
