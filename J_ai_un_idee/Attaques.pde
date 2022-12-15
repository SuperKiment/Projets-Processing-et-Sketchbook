class Slash {
  float x;
  float y;
  float puissance;
  float portee;
  int nojoueur;
  float orientation;
  int compteur = 30;
  boolean actif;
  int compteurStatique;

  Slash() {
  }

  void Ini(int newcompteur, boolean newactif, float neworientation) {
    compteur = newcompteur;
    orientation = neworientation;    //Valeurs qui ne changent pas duant l'action
    actif = newactif;

    compteurStatique = compteur;
  }

  void Attaque(float newx, float newy, float newpuissance, float newportee, int newjoueur) {

    x = newx;
    y = newy;
    puissance = newpuissance;  //Valeurs qui changent
    portee = newportee;
    nojoueur = newjoueur;



    if (nojoueur == 1 && actif == true && compteur > 0) {
      push();
      translate(x, y);
      rotate(orientation);
      strokeWeight(3);
      stroke(0);
      fill(200, 0, 0);
      rectMode(CENTER);
      rect(portee, compteur - compteurStatique/2, 20, 50);

      compteur = compteur - 10;
      if (compteur == 0) actif = false;
      pop();
    }
    
    if (nojoueur != 1 && actif == true && compteur > 0) {
      push();
      translate(joueur.x + x, joueur.y + y);
      rotate(orientation);
      strokeWeight(3);
      stroke(0);
      fill(200, 0, 0);
      rectMode(CENTER);
      rect(portee, compteur - compteurStatique/2, 20, 50);

      compteur = compteur - 10;
      if (compteur == 0) actif = false;
      pop();
    }
  }
}
