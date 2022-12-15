ArrayList<Ennemi> AllEnnemis = new ArrayList<Ennemi>();
int limiteEnnemis = 500;

class Ennemi {
  int hp, taille = 20, speed = 2;
  float x, y, direction;
  float xScreen, yScreen;
  float imprecision;

  color blanc = #FFFFFF;
  color gris = #888888;

  float rangeTaille = 2;
  float rangeSpeed = 2;
  float rangeImprecision = 2;


  Ennemi() {
    speed *= difficulte;
    taille *= difficulte;
    boolean plafond = false;
    float rand = random(-1, 1);
    while (rand == 0) rand = random(-1, 1);
    if (rand < 0) plafond = true; 
    else plafond = false;


    if (!plafond) {
      int cote = int(random(-10, 10));
      while (cote == 0) cote = int(random(-10, 10));
      if (cote < 0) cote = -1;
      if (cote > 0) cote = 1;

      y = int(random(-translateY, translateY));
      x = (translateX+100)*cote;
    }
    if (plafond) {
      int cote = int(random(-10, 10));
      while (cote == 0) cote = int(random(-10, 10));
      if (cote < 0) cote = -1;
      if (cote > 0) cote = 1;

      x = int(random(-translateX, translateX));
      y = (translateY+100)*cote;
    }


    speed = int(random(speed/rangeSpeed, speed*rangeSpeed));
    taille = int(random(taille/rangeTaille, taille*rangeTaille));
    imprecision = int(random(-PI*rangeImprecision/2, PI*rangeImprecision/2));
  }

  void Affichage() {
    push();
    strokeWeight(3);
    stroke(gris);
    fill(blanc);
    ellipse(x, y, taille, taille);
    pop();
  }

  void Deplacement() {

    float distX = x-joueur.x, distY = y-joueur.y;

    direction = atan(distY/distX);
    if (distX>0) direction += PI;

    direction += random(-imprecision, imprecision);

    x += speed*cos(direction);
    y += speed*sin(direction);
  }



  boolean HorsLimite() {
    if (x>width-translateX || x < 0-translateX ||
      y > height-translateY || y < 0-translateY) return true;
    else return false;
  }

  boolean CollisionJoueur() {
    boolean collision = false;

    float distJoueur = sqrt(pow(x-joueur.x, 2)+pow(y-joueur.y, 2));

    if (distJoueur <= taille/2) {
      collision = true;
      joueur.vies--;
      background(gris);
    }

    return collision;
  }

  void Numerotation(int no) {
    push();
    fill(blanc);
    text(no, x+20, y+20);
    pop();
  }

  void Fonctions(int no) {
    Deplacement();
    Affichage();
    //Numerotation(no);
  }
}

void EnnemiFonctions() {
  push();
  fill(255);
  textSize(20);
  text("Nombre d'ennemis : "+AllEnnemis.size(), 50, 50);
  pop();

  for (int i = 0; i<AllEnnemis.size(); i++) {
    Ennemi ennemi = AllEnnemis.get(i);
    ennemi.Fonctions(i);

    if (ennemi.CollisionJoueur()) AllEnnemis.remove(i);
    //if (ennemi.HorsLimite()) AllEnnemis.remove(i);
  }

  if (AllEnnemis.size() >= limiteEnnemis) AllEnnemis.remove(1);

  if (millis()-timerEnnemi >= intervalleEnnemi) { 
    timerEnnemi = millis();
    AllEnnemis.add(new Ennemi());
  }
}

void EnnemiReset() {
  for (int i = 0; i<AllEnnemis.size(); i++) {
    AllEnnemis.remove(i);
  }
}
