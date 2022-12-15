ArrayList<Particule> AllParticules = new ArrayList<Particule>();

class Particule {
  float x = width/2, y = height/2, xC, yC, rotation;
  float taille = 5, speedMov = 0.05, speedRot = PI/20;
  color couleur = #FFFFFF;
  int range = width/4;
  float timer, limiteTemps = 1000;

  Particule() {
  }
  Particule(float nx, float ny, int nr, float nt) {
    taille = nt;
    x = nx;
    y = ny;
    range = nr;
    xC = random(x-range, x+range);
    yC = random(y-range, y+range);
    speedRot = random(PI/50, PI/10);
    timer = millis();
    limiteTemps = random(limiteTemps/2, limiteTemps*1.5);
    speedMov = random(speedMov/2, speedMov*1.5);
  }

  void Fonctions() {

    x = lerp(x, xC, speedMov);
    y = lerp(y, yC, speedMov);//Depl
    rotation += speedRot;

    push();
    rectMode(CENTER);
    translate(x, y);
    rotate(rotation);
    fill(couleur);
    rect(0, 0, taille, taille);
    pop();
  }

  boolean Mort() {
    if (millis()-timer >= limiteTemps) return true; 
    else return false;
  }
}

void BoumParticules(float x, float y, int pui, int range, float nt) {
  for (int i = 0; i<pui; i++) {
    AllParticules.add(new Particule(x, y, range, nt));
  }
  println("Créé "+pui+" particules");
}

void ParticuleFonctions() {
  for (int i=0; i<AllParticules.size(); i++) {
    Particule part = AllParticules.get(i);
    part.Fonctions();
    if (part.Mort()) AllParticules.remove(i);
  }
}
