// ============================================
// Eclairage.pde - Système d'éclairage dynamique
// ============================================

PGraphics lumiere;
PShader vignetteShader;

void Setup_Eclairage() {
  lumiere = createGraphics(LARGEUR, HAUTEUR, P2D);
  vignetteShader = loadShader("vignette.glsl");
}

void Dessiner_OmbresMurs() {
  push();
  noStroke();
  rectMode(CENTER);
  for (Mur m : AllMurs) {
    // Halo sombre autour du mur (fausse occlusion ambiante)
    fill(0, 25);
    rect(m.x, m.y, m.tailleX + 16, m.tailleY + 16);
    // Ombre portée décalée
    fill(0, 35);
    rect(m.x + 3, m.y + 3, m.tailleX, m.tailleY);
  }
  pop();
}

void Dessiner_Eclairage() {
  lumiere.beginDraw();
  lumiere.background(40, 40, 55); // ambient
  lumiere.blendMode(ADD);
  lumiere.noStroke();

  // Lumière des tanks
  for (Tank t : AllTanks) {
    if (!t.vivant) continue;
    DessinerLumiere(lumiere, t.x, t.y, 280, t.couleur, 55);
    // Cône de lumière devant le canon
    float cx = t.x + cos(t.dir) * 60;
    float cy = t.y + sin(t.dir) * 60;
    DessinerLumiere(lumiere, cx, cy, 140, t.couleur, 35);
  }

  // Lumière des munitions
  for (Munition m : AllMunitions) {
    float r = 80 + m.type.taille * 4;
    DessinerLumiere(lumiere, m.x, m.y, r, m.type.couleur, 70);
  }

  // Lumière des pickups
  for (Pickup p : AllPickups) {
    if (!p.actif) continue;
    DessinerLumiere(lumiere, p.x, p.y, 160, p.type.couleur, 40);
  }

  // Lumière des zones de feu
  for (ZoneFeu z : AllZonesFeu) {
    DessinerLumiere(lumiere, z.x, z.y, z.rayon * 4, #FF4400, 50);
  }

  // Lumière des explosions (particules proches)
  for (Particule part : AllParticules) {
    if (part.taille > 6) {
      float vie = 1.0 - (millis() - part.timer) / part.limiteTemps;
      if (vie > 0.3) {
        DessinerLumiere(lumiere, part.x, part.y, part.taille * 8, part.couleur, vie * 30);
      }
    }
  }

  lumiere.blendMode(BLEND);
  lumiere.endDraw();

  // Appliquer sur la scène
  blendMode(MULTIPLY);
  image(lumiere, 0, 0);
  blendMode(BLEND);
}

void Appliquer_Vignette() {
  filter(vignetteShader);
}

void DessinerLumiere(PGraphics pg, float lx, float ly, float rayon, color c, float intensite) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  int steps = 5;
  for (int i = steps; i >= 1; i--) {
    float rad = rayon * i / steps;
    float a = intensite * (steps - i + 1) / (steps + 1);
    pg.fill(r, g, b, a);
    pg.ellipse(lx, ly, rad, rad);
  }
}
