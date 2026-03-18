// ============================================
// Particule.pde - Système de particules avancé
// ============================================

ArrayList<Particule> AllParticules = new ArrayList<Particule>();

class Particule {
  float x, y, rotation;
  float taille;
  float speedRot;
  color couleur;
  float timer, limiteTemps;
  boolean estCercle;

  // Vélocité directionnelle
  float vx, vy;
  float friction;

  Particule(float nx, float ny, float nt, color nc, float duree,
            float nvx, float nvy, float nfriction, boolean cercle) {
    x = nx; y = ny;
    taille = nt;
    couleur = nc;
    limiteTemps = duree;
    vx = nvx; vy = nvy;
    friction = nfriction;
    estCercle = cercle;
    speedRot = random(-PI/10, PI/10);
    timer = millis();
  }

  void Fonctions() {
    // Physique
    x += vx;
    y += vy;
    vx *= friction;
    vy *= friction;
    rotation += speedRot;

    // Vie restante (0 à 1)
    float vie = 1.0 - (millis() - timer) / limiteTemps;
    vie = constrain(vie, 0, 1);

    push();
    translate(x, y);
    rotate(rotation);
    noStroke();
    fill(couleur, vie * 255);

    float t = taille * (0.3 + 0.7 * vie); // rétrécit en mourant
    if (estCercle) {
      ellipse(0, 0, t, t);
    } else {
      rectMode(CENTER);
      rect(0, 0, t, t);
    }
    pop();
  }

  boolean Mort() {
    return millis() - timer >= limiteTemps;
  }
}

// --- Fonctions de création ---

// Explosion classique (carrés blancs dispersés)
void BoumParticules(float x, float y, int nb, int range, float taille) {
  BoumParticulesCouleur(x, y, nb, range, taille, #FFFFFF);
}

// Explosion colorée
void BoumParticulesCouleur(float x, float y, int nb, int range, float taille, color c) {
  for (int i = 0; i < nb; i++) {
    float angle = random(TWO_PI);
    float force = random(1, 4);
    float duree = random(400, 1000);
    AllParticules.add(new Particule(
      x, y, random(taille * 0.5, taille * 1.5), c, duree,
      cos(angle) * force, sin(angle) * force, 0.92, false
    ));
  }
}

// Étincelles directionnelles (partent dans un cône)
void EtincellesDir(float x, float y, int nb, float angle, float spread, float force, color c) {
  for (int i = 0; i < nb; i++) {
    float a = angle + random(-spread, spread);
    float f = force * random(0.5, 1.5);
    float duree = random(200, 600);
    float t = random(2, 5);
    AllParticules.add(new Particule(
      x, y, t, c, duree,
      cos(a) * f, sin(a) * f, 0.88, true
    ));
  }
}

// Fumée (particules lentes, grises, longue durée)
void FumeeParticules(float x, float y, int nb) {
  for (int i = 0; i < nb; i++) {
    float angle = random(TWO_PI);
    float force = random(0.2, 0.8);
    float duree = random(800, 2000);
    float t = random(8, 18);
    int gris = (int)random(60, 120);
    AllParticules.add(new Particule(
      x, y, t, color(gris), duree,
      cos(angle) * force, sin(angle) * force - 0.3, 0.97, true
    ));
  }
}

// Feu (orange-rouge, rapide)
void FeuParticules(float x, float y, int nb) {
  for (int i = 0; i < nb; i++) {
    float angle = random(TWO_PI);
    float force = random(1, 3);
    float duree = random(300, 700);
    float t = random(4, 10);
    color c = lerpColor(#FF4400, #FFCC00, random(1));
    AllParticules.add(new Particule(
      x, y, t, c, duree,
      cos(angle) * force, sin(angle) * force - 0.5, 0.90, random(1) > 0.5
    ));
  }
}

// Aura de pickup (particules lentes autour d'un point)
void AuraParticules(float x, float y, color c) {
  if (random(1) > 0.3) return; // pas à chaque frame
  float angle = random(TWO_PI);
  float dist = random(5, 20);
  AllParticules.add(new Particule(
    x + cos(angle) * dist, y + sin(angle) * dist,
    random(2, 5), c, random(400, 800),
    0, random(-0.3, -0.8), 0.96, true
  ));
}

// --- Update global ---

void ParticuleFonctions() {
  for (int i = AllParticules.size() - 1; i >= 0; i--) {
    Particule part = AllParticules.get(i);
    part.Fonctions();
    if (part.Mort()) AllParticules.remove(i);
  }
}
