ArrayList<Vie> AllVies = new ArrayList<Vie>();
int limiteVie = 3;
float intervalleVie = 100, timerVie;

class Vie {
  float x, y, taille = 20, rangeTaille = 2;

  Vie() {
    x = random(-translateX, translateX);
    y = random(-translateY, translateY);
    taille = random(taille/rangeTaille, taille*rangeTaille);
  }

  void Affichage() {
    push();
    strokeWeight(3);
    stroke(#00FFAA);
    strokeWeight(5);
    fill(#00FF00);
    ellipse(x, y, taille, taille);
    pop();
  }

  boolean CollisionJoueur() {
    boolean collision = false;

    float distJoueur = sqrt(pow(x-joueur.x, 2)+pow(y-joueur.y, 2));

    if (distJoueur <= taille/2) {
      collision = true;
      joueur.vies++;
    }
    return collision;
  }

  void Fonctions() {
    Affichage();
  }
}

void VieFonctions() {
  for (int i = 0; i < AllVies.size(); i++) {
    Vie vie = AllVies.get(i);
    vie.Fonctions();

    if (vie.CollisionJoueur()) AllVies.remove(i);
  }

  if (millis()-timerVie >= intervalleVie && AllVies.size() < limiteVie) { 
    timerVie = millis();
    Vie vie = new Vie();
    AllVies.add(vie);
    println("vie créée en x:"+vie.x+" / y : "+vie.y);
  }
}
