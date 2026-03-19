// ============================================
// Traces.pde - Traces au sol persistantes
// ============================================

PGraphics traces;

void Setup_Traces() {
  traces = createGraphics(LARGEUR, HAUTEUR, P2D);
  traces.beginDraw();
  traces.clear();
  traces.endDraw();
}

void EffacerTraces() {
  if (traces == null) return;
  traces.beginDraw();
  traces.clear();
  traces.endDraw();
}

void Dessiner_Traces() {
  if (traces == null) return;
  push();
  blendMode(BLEND);
  image(traces, 0, 0);
  pop();
}

// --- Traces de chenilles (appelé chaque frame par tank en mouvement) ---
void TraceChenille(float tx, float ty, float dir, float taille, color couleur) {
  if (traces == null) return;
  traces.beginDraw();
  traces.pushMatrix();
  traces.translate(tx, ty);
  traces.rotate(dir);
  traces.noStroke();

  float demi = taille * 0.45;
  float largTrace = taille * 0.18;
  float longTrace = taille * 0.3;

  if (modeJour) {
    // Jour : traces sombres sur sol clair (terre retournée)
    traces.fill(40, 30, 20, 50);
    traces.rectMode(CENTER);
    traces.rect(0, -demi, longTrace, largTrace);
    traces.rect(0, demi, longTrace, largTrace);
  } else {
    // Nuit : traces teintées de la couleur du tank
    color cTrace = lerpColor(couleur, #000000, 0.5);
    traces.fill(cTrace, 35);
    traces.rectMode(CENTER);
    traces.rect(0, -demi, longTrace, largTrace);
    traces.rect(0, demi, longTrace, largTrace);
  }

  traces.popMatrix();
  traces.endDraw();
}

// --- Marque d'explosion au sol ---
void TraceExplosion(float ex, float ey, float rayon) {
  if (traces == null) return;
  traces.beginDraw();
  traces.noStroke();

  if (modeJour) {
    // Jour : cratère de terre brûlée bien visible sur sol clair
    int nbEclats = max(10, (int)(rayon / 3));
    for (int i = 0; i < nbEclats; i++) {
      float angle = random(TWO_PI);
      float dist = random(rayon * 0.4, rayon * 1.6);
      float taille = random(3, 9);
      traces.fill(20, 10, 5, random(100, 200));
      traces.ellipse(ex + cos(angle) * dist, ey + sin(angle) * dist, taille, taille);
    }
    traces.fill(30, 20, 10, 180);
    traces.ellipse(ex, ey, rayon * 2.0, rayon * 2.0);
    traces.fill(15, 10, 5, 220);
    traces.ellipse(ex, ey, rayon * 1.2, rayon * 1.2);
    traces.fill(40, 30, 20, 120);
    traces.ellipse(ex, ey, rayon * 0.5, rayon * 0.5);
  } else {
    // Nuit
    int nbEclats = max(8, (int)(rayon / 4));
    for (int i = 0; i < nbEclats; i++) {
      float angle = random(TWO_PI);
      float dist = random(rayon * 0.4, rayon * 1.6);
      float taille = random(3, 8);
      traces.fill(30, 15, 5, random(60, 130));
      traces.ellipse(ex + cos(angle) * dist, ey + sin(angle) * dist, taille, taille);
    }
    traces.fill(25, 12, 5, 120);
    traces.ellipse(ex, ey, rayon * 2.0, rayon * 2.0);
    traces.fill(0, 0, 0, 160);
    traces.ellipse(ex, ey, rayon * 1.2, rayon * 1.2);
    traces.fill(50, 40, 30, 80);
    traces.ellipse(ex, ey, rayon * 0.5, rayon * 0.5);
  }

  traces.endDraw();
}

// --- Marque de mort d'un tank ---
void TraceMort(float mx, float my, float taille, color couleur) {
  if (traces == null) return;
  traces.beginDraw();
  traces.noStroke();

  int nbDebris = 16;

  if (modeJour) {
    // Jour : débris sombres très visibles sur sol clair
    for (int i = 0; i < nbDebris; i++) {
      float angle = random(TWO_PI);
      float dist = random(taille * 0.3, taille * 2.2);
      float sz = random(3, 8);
      traces.fill(lerpColor(couleur, #1A1A1A, random(0.5, 0.8)), random(120, 220));
      traces.rect(mx + cos(angle) * dist - sz/2, my + sin(angle) * dist - sz/2, sz, sz);
    }
    traces.fill(couleur, 80);
    traces.ellipse(mx, my, taille * 3.5, taille * 3.5);
    traces.fill(20, 15, 10, 200);
    traces.ellipse(mx, my, taille * 2.5, taille * 2.5);
    traces.fill(35, 25, 15, 150);
    traces.ellipse(mx, my, taille * 1.5, taille * 1.5);
  } else {
    // Nuit
    for (int i = 0; i < nbDebris; i++) {
      float angle = random(TWO_PI);
      float dist = random(taille * 0.3, taille * 2.2);
      float sz = random(3, 7);
      traces.fill(lerpColor(couleur, #000000, random(0.3, 0.7)), random(80, 160));
      traces.rect(mx + cos(angle) * dist - sz/2, my + sin(angle) * dist - sz/2, sz, sz);
    }
    traces.fill(couleur, 60);
    traces.ellipse(mx, my, taille * 3.5, taille * 3.5);
    traces.fill(0, 0, 0, 150);
    traces.ellipse(mx, my, taille * 2.5, taille * 2.5);
    traces.fill(20, 10, 5, 100);
    traces.ellipse(mx, my, taille * 1.5, taille * 1.5);
  }

  traces.endDraw();
}
