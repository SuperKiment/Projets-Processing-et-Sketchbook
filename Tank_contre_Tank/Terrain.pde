// ============================================
// Terrain.pde - Éléments de terrain au sol
// ============================================

ArrayList<Terrain> AllTerrains = new ArrayList<Terrain>();

class Terrain {
  float x, y, rayon;
  String type;
  float dirConvoyeur = 0; // direction pour convoyeurs/ventilateurs
  float portalLien = -1;  // index du portail lié
  boolean actif = true;
  float timer = 0;

  Terrain(float nx, float ny, float nr, String t) {
    x = nx; y = ny; rayon = nr; type = t;
    timer = millis();
  }

  // Applique l'effet sur un tank
  void AppliquerSurTank(Tank tank) {
    float d = dist(tank.x, tank.y, x, y);
    if (d >= rayon) return;

    if (type.equals("huile")) {
      // Glisse : rotation incontrôlable
      tank.dir += random(-0.08, 0.08);
      tank.speed *= 1.02;
    }
    else if (type.equals("boue")) {
      // Ralentit fortement
      tank.speed *= 0.85;
    }
    else if (type.equals("glace")) {
      // Glisse sans friction
      tank.speed = max(tank.speed, tank.SpeedMax() * 0.6);
    }
    else if (type.equals("convoyeur")) {
      // Pousse dans une direction
      tank.x += cos(dirConvoyeur) * 1.5;
      tank.y += sin(dirConvoyeur) * 1.5;
    }
    else if (type.equals("sable_mouvant")) {
      // Ralentit progressivement et empêche le tir
      tank.speed *= 0.7;
    }
    else if (type.equals("trampoline")) {
      // Propulse le tank dans sa direction
      if (d < rayon * 0.5 && millis() - timer > 500) {
        tank.speed = tank.SpeedMax() * 2.5;
        EtincellesDir(tank.x, tank.y, 6, tank.dir, PI/4, 4, #44FF44);
        JouerSon("trampoline");
        timer = millis();
      }
    }
    else if (type.equals("portail")) {
      // Téléporte vers le portail lié
      if (d < rayon * 0.4 && millis() - timer > 1000) {
        int idx = (int)portalLien;
        if (idx >= 0 && idx < AllTerrains.size()) {
          Terrain dest = AllTerrains.get(idx);
          if (dest.type.equals("portail")) {
            BoumParticulesCouleur(tank.x, tank.y, 8, 20, 4, #FF44FF);
            tank.x = dest.x;
            tank.y = dest.y;
            BoumParticulesCouleur(tank.x, tank.y, 8, 20, 4, #FF44FF);
            JouerSon("portail");
            timer = millis();
            dest.timer = millis();
          }
        }
      }
    }
    else if (type.equals("herbe")) {
      // Rend le tank semi-invisible
      if (!tank.ABoost("boost_invisible")) {
        // Effet temporaire : on ne l'ajoute que si pas déjà dedans
        boolean dejaHerbe = false;
        for (BoostActif b : tank.boosts) {
          if (b.categorie.equals("herbe_cache")) { dejaHerbe = true; b.fin = millis() + 200; break; }
        }
        if (!dejaHerbe) tank.boosts.add(new BoostActif("herbe_cache", 1, 200));
      }
    }
    else if (type.equals("lave")) {
      // Dégâts périodiques
      if (millis() - timer > 800) {
        tank.PrendreDegas(1);
        FeuParticules(tank.x, tank.y, 3);
        JouerSon("lave");
        timer = millis();
      }
    }
    else if (type.equals("plaque_pression")) {
      // Active un effet quand on marche dessus
      if (!actif) return;
      if (d < rayon * 0.5) {
        actif = false;
        timer = millis();
        // Tire des projectiles dans 4 directions
        TypeMunition standard = TypesMunitions.get("standard");
        for (int i = 0; i < 4; i++) {
          float angle = i * HALF_PI;
          Munition m = new Munition(x, y, angle, standard, -1);
          m.speed = 10;
          AllMunitions.add(m);
        }
        BoumParticulesCouleur(x, y, 10, 25, 4, #FFAA00);
        JouerSon("plaque_pression");
      }
    }
    else if (type.equals("ventilateur")) {
      // Pousse le tank et les munitions
      tank.x += cos(dirConvoyeur) * 2.0;
      tank.y += sin(dirConvoyeur) * 2.0;
    }
  }

  // Applique l'effet sur une munition
  void AppliquerSurMunition(Munition mun) {
    float d = dist(mun.x, mun.y, x, y);
    if (d >= rayon) return;

    if (type.equals("ventilateur")) {
      mun.x += cos(dirConvoyeur) * 1.5;
      mun.y += sin(dirConvoyeur) * 1.5;
    }
    else if (type.equals("convoyeur")) {
      mun.x += cos(dirConvoyeur) * 0.8;
      mun.y += sin(dirConvoyeur) * 0.8;
    }
    else if (type.equals("trampoline")) {
      if (d < rayon * 0.5) {
        mun.speed *= 1.5;
      }
    }
  }

  void Afficher() {
    push();
    noStroke();

    if (type.equals("huile")) {
      fill(#222222, 100);
      ellipse(x, y, rayon * 2, rayon * 2);
      fill(#333344, 60);
      ellipse(x + rayon * 0.2, y - rayon * 0.1, rayon * 1.2, rayon * 1.0);
      // Reflets arc-en-ciel
      fill(lerpColor(#FF00FF, #00FFFF, sin(millis() * 0.002) * 0.5 + 0.5), 25);
      ellipse(x - rayon * 0.15, y + rayon * 0.1, rayon * 0.8, rayon * 0.6);
    }
    else if (type.equals("boue")) {
      fill(#4A3520, 120);
      ellipse(x, y, rayon * 2, rayon * 2);
      fill(#3A2510, 80);
      ellipse(x + 5, y + 3, rayon * 1.4, rayon * 1.2);
      fill(#5A4530, 60);
      ellipse(x - 8, y - 5, rayon * 0.6, rayon * 0.5);
    }
    else if (type.equals("glace")) {
      fill(#AADDFF, 50);
      ellipse(x, y, rayon * 2, rayon * 2);
      fill(#CCEEFF, 40);
      ellipse(x, y, rayon * 1.4, rayon * 1.4);
      // Reflets
      fill(#FFFFFF, 30);
      ellipse(x - rayon * 0.2, y - rayon * 0.2, rayon * 0.5, rayon * 0.3);
    }
    else if (type.equals("convoyeur")) {
      fill(#555555, 80);
      ellipse(x, y, rayon * 2, rayon * 2);
      // Flèches de direction
      fill(#FFAA00, 100);
      float anim = (millis() * 0.003) % 1.0;
      for (int i = 0; i < 3; i++) {
        float offset = ((anim + i * 0.33) % 1.0 - 0.5) * rayon * 1.5;
        float fx = x + cos(dirConvoyeur) * offset;
        float fy = y + sin(dirConvoyeur) * offset;
        pushMatrix();
        translate(fx, fy);
        rotate(dirConvoyeur);
        triangle(6, 0, -4, -4, -4, 4);
        popMatrix();
      }
    }
    else if (type.equals("sable_mouvant")) {
      fill(#C4A050, 80);
      ellipse(x, y, rayon * 2, rayon * 2);
      // Spirale
      noFill();
      stroke(#A08030, 50);
      strokeWeight(2);
      float spirale = millis() * 0.001;
      for (int i = 0; i < 20; i++) {
        float a = spirale + i * 0.4;
        float r = i * rayon * 0.04;
        point(x + cos(a) * r, y + sin(a) * r);
      }
      noStroke();
    }
    else if (type.equals("trampoline")) {
      float bounce = abs(sin(millis() * 0.005)) * 0.2;
      fill(#44FF44, 60);
      ellipse(x, y, rayon * 2 * (1 + bounce), rayon * 2 * (1 + bounce));
      fill(#44FF44, 100);
      ellipse(x, y, rayon * 1.2, rayon * 1.2);
      fill(#88FF88, 60);
      ellipse(x, y, rayon * 0.6, rayon * 0.6);
    }
    else if (type.equals("portail")) {
      float pulse = sin(millis() * 0.008) * 0.3 + 0.7;
      fill(#FF44FF, 30 * pulse);
      ellipse(x, y, rayon * 2, rayon * 2);
      noFill();
      stroke(#FF44FF, 120 * pulse);
      strokeWeight(2);
      ellipse(x, y, rayon * 1.5, rayon * 1.5);
      stroke(#FF88FF, 80 * pulse);
      strokeWeight(1);
      ellipse(x, y, rayon * 1.8 * pulse, rayon * 1.8 * pulse);
      noStroke();
      fill(#FFFFFF, 60 * pulse);
      ellipse(x, y, rayon * 0.4, rayon * 0.4);
    }
    else if (type.equals("herbe")) {
      fill(#228822, 60);
      ellipse(x, y, rayon * 2, rayon * 2);
      // Brins d'herbe
      stroke(#33AA33, 80);
      strokeWeight(1);
      for (int i = 0; i < 8; i++) {
        float a = i * TWO_PI / 8 + sin(millis() * 0.002 + i) * 0.2;
        float r = rayon * 0.5;
        line(x + cos(a) * r * 0.3, y + sin(a) * r * 0.3,
             x + cos(a) * r, y + sin(a) * r);
      }
      noStroke();
    }
    else if (type.equals("lave")) {
      fill(#FF2200, 60);
      ellipse(x, y, rayon * 2, rayon * 2);
      fill(#FF6600, 50);
      ellipse(x, y, rayon * 1.4, rayon * 1.4);
      fill(#FFAA00, 40);
      float lp = sin(millis() * 0.004) * rayon * 0.2;
      ellipse(x + lp, y - lp * 0.5, rayon * 0.6, rayon * 0.6);
      // Particules de lave
      if (random(1) > 0.9) {
        FeuParticules(x + random(-rayon, rayon), y + random(-rayon, rayon), 1);
      }
    }
    else if (type.equals("plaque_pression")) {
      if (actif) {
        fill(#FFAA00, 80);
        rectMode(CENTER);
        rect(x, y, rayon * 1.2, rayon * 1.2, 4);
        fill(#FFCC44, 60);
        rect(x, y, rayon * 0.8, rayon * 0.8, 2);
        // Point d'exclamation
        fill(#FF4400, 120);
        ellipse(x, y + rayon * 0.2, 4, 4);
        rectMode(CENTER);
        rect(x, y - rayon * 0.05, 3, rayon * 0.3);
      } else {
        // Désactivée
        fill(#666666, 40);
        rectMode(CENTER);
        rect(x, y, rayon * 1.2, rayon * 1.2, 4);
        // Réactivation après 8s
        if (millis() - timer > 8000) actif = true;
      }
    }
    else if (type.equals("ventilateur")) {
      fill(#88BBCC, 50);
      ellipse(x, y, rayon * 2, rayon * 2);
      // Lignes de vent
      stroke(#AADDEE, 50);
      strokeWeight(1);
      float anim = millis() * 0.004;
      for (int i = 0; i < 4; i++) {
        float offset = ((anim + i * 0.25) % 1.0) * rayon * 2 - rayon;
        float wx = x + cos(dirConvoyeur) * offset;
        float wy = y + sin(dirConvoyeur) * offset;
        float perp = dirConvoyeur + HALF_PI;
        line(wx + cos(perp) * 8, wy + sin(perp) * 8,
             wx - cos(perp) * 8, wy - sin(perp) * 8);
      }
      noStroke();
    }

    pop();
  }
}

void Dessiner_Terrains() {
  for (Terrain t : AllTerrains) {
    t.Afficher();
  }
}

void Fonctions_Terrains() {
  for (Terrain terrain : AllTerrains) {
    for (Tank tank : AllTanks) {
      if (!tank.vivant) continue;
      terrain.AppliquerSurTank(tank);
    }
    for (Munition mun : AllMunitions) {
      terrain.AppliquerSurMunition(mun);
    }
  }
}

void SpawnerTerrainsAleatoires(int nb) {
  String[] types = {
    "huile", "boue", "glace", "convoyeur", "sable_mouvant",
    "trampoline", "herbe", "lave", "ventilateur"
  };

  // D'abord placer une paire de portails (probabilité 40%)
  if (random(1) < 0.4) {
    float[] pos1 = PosTerrainValide(35);
    float[] pos2 = PosTerrainValide(35);
    Terrain p1 = new Terrain(pos1[0], pos1[1], 35, "portail");
    Terrain p2 = new Terrain(pos2[0], pos2[1], 35, "portail");
    int idx1 = AllTerrains.size();
    int idx2 = idx1 + 1;
    p1.portalLien = idx2;
    p2.portalLien = idx1;
    AllTerrains.add(p1);
    AllTerrains.add(p2);
  }

  // Plaque de pression (probabilité 30%)
  if (random(1) < 0.3) {
    float[] pos = PosTerrainValide(25);
    AllTerrains.add(new Terrain(pos[0], pos[1], 25, "plaque_pression"));
  }

  // Terrains aléatoires
  for (int i = 0; i < nb; i++) {
    String type = types[(int)random(types.length)];
    float rayon = random(30, 55);
    float[] pos = PosTerrainValide(rayon);
    Terrain t = new Terrain(pos[0], pos[1], rayon, type);
    if (type.equals("convoyeur") || type.equals("ventilateur")) {
      t.dirConvoyeur = random(TWO_PI);
    }
    AllTerrains.add(t);
  }
}

float[] PosTerrainValide(float rayon) {
  float marge = 80;
  for (int tentative = 0; tentative < 50; tentative++) {
    float nx = random(marge, LARGEUR - marge);
    float ny = random(marge, HAUTEUR - marge);
    boolean valide = true;

    // Pas dans un mur
    for (Mur m : AllMurs) {
      if (PointDansRect(nx, ny, m.x, m.y, m.tailleX + rayon * 2, m.tailleY + rayon * 2)) {
        valide = false; break;
      }
    }
    // Pas sur un spawn
    if (valide && partieActuelle != null) {
      for (PointSpawn sp : partieActuelle.carte.spawns) {
        if (dist(nx, ny, sp.x, sp.y) < 100) { valide = false; break; }
      }
    }
    // Pas trop près d'un autre terrain
    for (Terrain t : AllTerrains) {
      if (dist(nx, ny, t.x, t.y) < rayon + t.rayon + 20) { valide = false; break; }
    }
    if (valide) return new float[] { nx, ny };
  }
  return new float[] { random(marge, LARGEUR - marge), random(marge, HAUTEUR - marge) };
}
