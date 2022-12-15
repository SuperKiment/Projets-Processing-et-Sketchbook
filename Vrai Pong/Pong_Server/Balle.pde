class Balle {
  float x;
  float y;
  float mouvx;
  float mouvy;
  int taille = 10;

  Balle(float nouvx, float nouvy, float nouvmouvx, float nouvmouvy) {
    x = nouvx;
    y = nouvy;
    mouvx = nouvmouvx;
    mouvy = nouvmouvy;
  }

  void Deplacement() {
    x = x + mouvx;
    y = y + mouvy;

    if (y >= 1000 - taille) {
      mouvy = -mouvy;
    }
    if (y <= 0 + taille) {
      mouvy = -mouvy;
    }
  }


  void Gagne() {
    x = 750;
    y = 500;
    mouvx = random(1, 3);
    mouvy = random(0, 3);
    taille = int(random(5, 30));
  }


  void Rebond() {
    if (x >= 1500-20-taille && raquette2.y <= y && y <= raquette2.taille+raquette2.y) {
      mouvx = -mouvx;
      mouvx = mouvx-1;
    }
    if (x <= 0+20+taille && raquette1.y <= y && y <= raquette1.taille+raquette1.y) {
      mouvx = -mouvx;
      mouvx = mouvx+1;
    }
  }
}



void Balle() {
  balle1.Deplacement();
  balle1.Rebond();

  if (balle1.x >= 1500-balle1.taille) {
    scoreG++;
    balle1.Gagne();
    balle2.Gagne();
    start = false;
  }

  if (balle1.x <= 0+balle1.taille) {
    scoreD++;
    balle1.Gagne();
    balle2.Gagne();
    start = false;
  }
}
