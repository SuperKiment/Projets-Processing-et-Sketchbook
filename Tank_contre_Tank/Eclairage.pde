// ============================================
// Eclairage.pde - Éclairage dynamique + post-process
// ============================================

PGraphics lumiere;

// --- Système de shaders post-process ---
PShader[] postShaders;
String[] postShaderNoms;
int postShaderActuel = 0;
float shaderLabelTimer = 0;

// --- Flash écran ---
ArrayList<FlashEcran> AllFlashs = new ArrayList<FlashEcran>();

class FlashEcran {
  float intensite;
  color couleur;
  float timer;
  float duree;
  float x, y;        // position source (-1 = plein écran)
  float rayon;

  FlashEcran(float i, color c, float d) {
    intensite = i; couleur = c; duree = d;
    timer = millis();
    x = -1; y = -1; rayon = 0;
  }

  FlashEcran(float i, color c, float d, float fx, float fy, float fr) {
    intensite = i; couleur = c; duree = d;
    timer = millis();
    x = fx; y = fy; rayon = fr;
  }

  float Vie() {
    float t = (millis() - timer) / duree;
    return max(0, 1.0 - t * t); // ease out quadratique
  }

  boolean Mort() { return millis() - timer >= duree; }
}

void Setup_Eclairage() {
  lumiere = createGraphics(LARGEUR, HAUTEUR, P2D);

  // Charger tous les shaders
  postShaderNoms = new String[] {
    "Normal", "VHS", "Noir & Blanc", "Ultra Colore",
    "Retro", "Neon", "Thermique", "Glitch"
  };
  String[] fichiers = {
    "vignette.glsl", "vhs.glsl", "noir_blanc.glsl", "ultra_colore.glsl",
    "retro.glsl", "neon.glsl", "thermique.glsl", "glitch.glsl"
  };
  postShaders = new PShader[fichiers.length];
  for (int i = 0; i < fichiers.length; i++) {
    postShaders[i] = loadShader(fichiers[i]);
  }
}

void CyclerPostProcess() {
  postShaderActuel = (postShaderActuel + 1) % postShaders.length;
  shaderLabelTimer = millis();
}

void CyclerPostProcessInverse() {
  postShaderActuel = (postShaderActuel - 1 + postShaders.length) % postShaders.length;
  shaderLabelTimer = millis();
}

// --- Flash helpers ---

void FlashExplosion(float fx, float fy, float rayon) {
  AllFlashs.add(new FlashEcran(0.8, #FF6600, 300, fx, fy, rayon * 3));
}

void FlashMort(float fx, float fy) {
  AllFlashs.add(new FlashEcran(0.6, #FFFFFF, 400, fx, fy, 400));
}

void FlashTir(float fx, float fy, color c) {
  AllFlashs.add(new FlashEcran(0.15, c, 80, fx, fy, 120));
}

void FlashPleinEcran(float intensite, color c, float duree) {
  AllFlashs.add(new FlashEcran(intensite, c, duree));
}

// --- Ombres ---

void Dessiner_OmbresMurs() {
  push();
  noStroke();
  rectMode(CENTER);
  if (modeJour) {
    // Jour : ombres portées plus marquées et décalées (soleil)
    for (Mur m : AllMurs) {
      fill(0, 40);
      rect(m.x + 5, m.y + 5, m.tailleX + 8, m.tailleY + 8);
      fill(0, 60);
      rect(m.x + 4, m.y + 4, m.tailleX, m.tailleY);
    }
  } else {
    // Nuit : ombres diffuses
    for (Mur m : AllMurs) {
      fill(0, 25);
      rect(m.x, m.y, m.tailleX + 16, m.tailleY + 16);
      fill(0, 35);
      rect(m.x + 3, m.y + 3, m.tailleX, m.tailleY);
    }
  }
  pop();
}

// --- Éclairage dynamique ---

void Dessiner_Eclairage() {
  if (!modeJour) {
    // Mode nuit : assombrissement avec lumières dynamiques
    lumiere.beginDraw();
    lumiere.background(40, 40, 55);
    lumiere.blendMode(ADD);
    lumiere.noStroke();

    // Lumière des tanks
    for (Tank t : AllTanks) {
      if (!t.vivant) continue;
      DessinerLumiere(lumiere, t.x, t.y, 280, t.couleur, 55);
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

    // Lumière des grosses particules
    for (Particule part : AllParticules) {
      if (part.taille > 6) {
        float vie = 1.0 - (millis() - part.timer) / part.limiteTemps;
        if (vie > 0.3) {
          DessinerLumiere(lumiere, part.x, part.y, part.taille * 8, part.couleur, vie * 30);
        }
      }
    }

    // Lumière des flashs
    for (FlashEcran f : AllFlashs) {
      float vie = f.Vie();
      if (vie <= 0) continue;
      if (f.x < 0) {
        lumiere.fill(red(f.couleur), green(f.couleur), blue(f.couleur), f.intensite * vie * 150);
        lumiere.rect(LARGEUR/2, HAUTEUR/2, LARGEUR, HAUTEUR);
      } else {
        DessinerLumiere(lumiere, f.x, f.y, f.rayon * vie, f.couleur, f.intensite * vie * 200);
      }
    }

    lumiere.blendMode(BLEND);
    lumiere.endDraw();

    blendMode(MULTIPLY);
    image(lumiere, 0, 0);
    blendMode(BLEND);
  }

  // Flashs additifs par-dessus (jour ET nuit)
  Dessiner_Flashs();
}

void Dessiner_Flashs() {
  for (int i = AllFlashs.size() - 1; i >= 0; i--) {
    FlashEcran f = AllFlashs.get(i);
    float vie = f.Vie();
    if (f.Mort()) {
      AllFlashs.remove(i);
      continue;
    }

    push();
    noStroke();
    blendMode(ADD);
    if (f.x < 0) {
      // Flash plein écran
      fill(red(f.couleur), green(f.couleur), blue(f.couleur), f.intensite * vie * 80);
      rectMode(CORNER);
      rect(0, 0, LARGEUR, HAUTEUR);
    } else {
      // Flash localisé avec gradient
      float r = f.rayon * (0.5 + vie * 0.5);
      int steps = 4;
      for (int s = steps; s >= 1; s--) {
        float rad = r * s / steps;
        float a = f.intensite * vie * 60 * (steps - s + 1) / (steps + 1);
        fill(red(f.couleur), green(f.couleur), blue(f.couleur), a);
        ellipse(f.x, f.y, rad, rad);
      }
    }
    blendMode(BLEND);
    pop();
  }
}

// --- Post-process ---

void Appliquer_PostProcess() {
  PShader shader = postShaders[postShaderActuel];
  shader.set("time", millis() / 1000.0);
  shader.set("resolution", (float)LARGEUR, (float)HAUTEUR);
  filter(shader);
}

void Afficher_LabelPostProcess() {
  if (millis() - shaderLabelTimer > 2000) return;
  float vie = 1.0 - (millis() - shaderLabelTimer) / 2000.0;

  push();
  textAlign(CENTER, CENTER);
  // Fond
  fill(0, vie * 180);
  noStroke();
  rectMode(CENTER);
  rect(LARGEUR/2, HAUTEUR - 60, 250, 35, 8);
  // Texte
  fill(255, vie * 255);
  textSize(16);
  text("Filtre: " + postShaderNoms[postShaderActuel], LARGEUR/2, HAUTEUR - 60);
  // Indicateur
  fill(255, vie * 100);
  textSize(11);
  text("TAB / Shift+TAB pour changer", LARGEUR/2, HAUTEUR - 38);
  pop();
}

// --- Utilitaire lumière ---

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
