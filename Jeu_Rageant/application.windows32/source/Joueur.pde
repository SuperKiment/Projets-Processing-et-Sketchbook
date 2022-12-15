Joueur joueur = new Joueur();

class Joueur {
  int x, y;
  float xScreen, yScreen;
  int taille = 10;
  color blanc = #FFFFFF;
  int vies;
  int viesBase = 5;
  Joueur() {
    vies = viesBase;
  }

  void Affichage() {

    xScreen = x-translateX;
    yScreen = y-translateY;

    push();
    strokeWeight(3);
    rectMode(CENTER);
    fill(blanc);
    rect(x, y, taille, taille);
    pop();
  }

  void Deplacement() {
    x = mouseX-int(translateX);
    y = mouseY-int(translateY);
  }

  boolean Mort() {
    if (vies <= 0) return true;
    else return false;
  }

  void Reset() {
    vies = viesBase;
  }

  void Fonctions() {
    Deplacement();
    Affichage();

    if (Mort()) {
      ecran = "Mort"; 
      timer.Stop();
    }

    push();
    fill(blanc);
    textSize(20);
    text("Nombre de vies restantes : "+vies, 50, 80);
    pop();
  }
}
