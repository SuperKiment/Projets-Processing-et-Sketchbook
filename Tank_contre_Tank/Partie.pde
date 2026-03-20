// ============================================
// Partie.pde - Gestion de la partie en cours
// ============================================

Partie partieActuelle;
float timerFinManche = 0;

class Partie {
  Carte carte;
  int nbJoueurs;
  int[] scores;
  int manche = 0;
  int dernierGagnant = -1;
  boolean partieTerminee = false;
  float timerMortDernier = 0;
  boolean mancheEnAttente = false;

  // --- Respawn ---
  boolean respawnActif = false;
  float delaiRespawn = 3000; // ms avant respawn

  // --- Roi de la colline ---
  float zoneX, zoneY, zoneRayon;
  float[] scoreColline;
  float scoreCollineMax = 60;    // points pour gagner (~60s de capture pure)
  float dernierDeplacementZone;
  float delaiDeplacementZone = 20000; // 20 secondes
  int zoneOccupant = -1;
  // Animation de transition de zone
  float ancienneZoneX, ancienneZoneY;
  float nouvelleZoneX, nouvelleZoneY;
  float transitionZone = 1.0; // 0→1, 1 = terminée
  float debutTransition = 0;

  Partie(Carte c, int nj) {
    carte = c;
    nbJoueurs = nj;
    scores = new int[nj];
    scoreColline = new float[nj];
  }

  void Demarrer() {
    NouvelleManche();
  }

  void NouvelleManche() {
    manche++;

    // Jour/nuit aléatoire
    if (paramJourNuitAleatoire) {
      modeJour = random(1) > 0.5;
    } else {
      modeJour = false; // toujours nuit par défaut
    }

    // Changement de couleurs aléatoire entre manches
    if (paramCouleursAleatoires) {
      int idx = (int)random(PALETTES_COULEURS.length);
      carte.couleurFond = PALETTES_COULEURS[idx][0];
      carte.couleurMur = PALETTES_COULEURS[idx][1];
      carte.couleurFondJour = PALETTES_COULEURS[idx][2];
      carte.couleurMurJour = PALETTES_COULEURS[idx][3];
    } else {
      carte.RestaureTheme();
    }

    carte.Charger(); // recharge murs + pickups fixes
    AllTanks.clear();
    AllMunitions.clear();
    AllParticules.clear();
    AllZonesFeu.clear();
    AllZonesFumee.clear();
    AllTourelles.clear();
    AllTextesFlottants.clear();
    AllFlashs.clear();

    // Terrains (persistent entre manches, placés qu'à la première manche)
    if (manche == 1) {
      AllTerrains.clear();
      SpawnerTerrainsAleatoires(6);
    }

    // 2 pickups aléatoires
    SpawnerPickupsAleatoires(2);

    for (int i = 0; i < nbJoueurs; i++) {
      PointSpawn sp = carte.spawns.get(i % carte.spawns.size());
      String nomTank = tankChoisiParJoueur[i];
      TypeTank type = TypesTanks.get(nomTank);
      if (type == null) type = TypesTanks.get("Sentinelle");
      PlayerInput pi = inputManager.GetJoueur(i);

      Tank t = new Tank(i, type, sp.x, sp.y, sp.dir, pi);
      t.couleur = COULEURS_JOUEURS[i];
      AllTanks.add(t);
    }

    // Roi de la colline : init zone + scores + respawn
    if (EstModeColline()) {
      for (int i = 0; i < nbJoueurs; i++) scoreColline[i] = 0;
      zoneRayon = 80;
      PlacerZoneColline();
      nouvelleZoneX = zoneX;
      nouvelleZoneY = zoneY;
      transitionZone = 1.0;
      dernierDeplacementZone = millis();
      respawnActif = true;
    } else {
      respawnActif = false;
    }
  }

  void Fonctions() {
    inputManager.MettreAJour();

    // Pause manette (Start)
    for (int i = 0; i < nbJoueurs; i++) {
      if (inputManager.GetJoueur(i).pause) {
        ChangerEtat(Etat.PAUSE);
        return;
      }
    }

    Dessiner_Traces();
    Dessiner_Terrains();
    Dessiner_OmbresMurs();
    Fonctions_Murs();

    for (int i = AllTanks.size() - 1; i >= 0; i--) {
      Tank tank = AllTanks.get(i);
      tank.Fonctions();
    }

    Fonctions_Munitions();
    Fonctions_ZonesFeu();
    Fonctions_ZonesFumee();
    Fonctions_Tourelles();
    Fonctions_Terrains();
    Fonctions_Pickups();
    ParticuleFonctions();
    Fonctions_TextesFlottants();

    Dessiner_Eclairage();
    Appliquer_PostProcess();

    if (DEBUG_MODE) {
      placeMur.Fonctions();
    }

    // Respawn
    if (respawnActif) {
      Fonctions_Respawn();
    }

    // Roi de la colline : logique de zone
    if (EstModeColline()) {
      Fonctions_Colline();
      Dessiner_ZoneColline();
    }

    Afficher_HUD();
    Afficher_LabelPostProcess();
    VerifierFinManche();
  }

  void VerifierFinManche() {
    if (EstModeColline()) {
      VerifierFinMancheColline();
    } else {
      VerifierFinMancheDeathmatch();
    }
  }

  void VerifierFinMancheDeathmatch() {
    int vivantsCount = 0;
    int dernierVivant = -1;

    for (int i = 0; i < AllTanks.size(); i++) {
      if (AllTanks.get(i).vivant) {
        vivantsCount++;
        dernierVivant = i;
      }
    }

    if (vivantsCount <= 1 && AllTanks.size() > 1) {
      if (!mancheEnAttente) {
        mancheEnAttente = true;
        timerMortDernier = millis();
        return;
      }
      if (millis() - timerMortDernier < 1000) return;

      mancheEnAttente = false;

      if (dernierVivant >= 0) {
        scores[dernierVivant]++;
        dernierGagnant = dernierVivant;
      } else {
        dernierGagnant = -1;
      }

      for (int i = 0; i < nbJoueurs; i++) {
        if (scores[i] >= SCORE_VICTOIRE) {
          partieTerminee = true;
          ChangerEtat(Etat.FIN_PARTIE);
          return;
        }
      }

      ChangerEtat(Etat.FIN_MANCHE);
    }
  }

  void VerifierFinMancheColline() {
    // Un joueur atteint le score max → gagne la manche
    for (int i = 0; i < nbJoueurs; i++) {
      if (scoreColline[i] >= scoreCollineMax) {
        scores[i]++;
        dernierGagnant = i;

        for (int j = 0; j < nbJoueurs; j++) {
          if (scores[j] >= SCORE_VICTOIRE) {
            partieTerminee = true;
            ChangerEtat(Etat.FIN_PARTIE);
            return;
          }
        }

        ChangerEtat(Etat.FIN_MANCHE);
        return;
      }
    }
  }

  // --- Respawn ---

  void Fonctions_Respawn() {
    for (Tank t : AllTanks) {
      if (!t.vivant && t.attenteRespawn) {
        if (millis() - t.timerMort >= delaiRespawn) {
          // Trouver un spawn éloigné des autres tanks
          PointSpawn meilleur = carte.spawns.get(0);
          float meilleurDist = 0;
          for (PointSpawn sp : carte.spawns) {
            float distMin = 99999;
            for (Tank autre : AllTanks) {
              if (!autre.vivant) continue;
              float d = dist(sp.x, sp.y, autre.x, autre.y);
              if (d < distMin) distMin = d;
            }
            if (distMin > meilleurDist) {
              meilleurDist = distMin;
              meilleur = sp;
            }
          }
          t.Respawn(meilleur.x, meilleur.y, meilleur.dir);
          JouerSon("manche_debut", 0.5, 1.5);
        } else {
          // Afficher timer de respawn
          float reste = (delaiRespawn - (millis() - t.timerMort)) / 1000.0;
          String txt = nf(reste, 1, 1) + "s";
          TexteCentre(txt, t.x, t.y - 15, 16, color(red(t.couleur), green(t.couleur), blue(t.couleur), 150));
          // Cercle de respawn
          push();
          noFill();
          stroke(t.couleur, 100);
          strokeWeight(2);
          float progress = (millis() - t.timerMort) / delaiRespawn;
          arc(t.x, t.y, 40, 40, -HALF_PI, -HALF_PI + TWO_PI * progress);
          pop();
        }
      }
    }
  }

  // --- Roi de la colline : méthodes ---

  boolean EstModeColline() {
    return modeActuel != null && modeActuel.nom.equals("Roi de la colline");
  }

  void Fonctions_Colline() {
    // Déplacer la zone périodiquement
    if (paramZoneMobile && millis() - dernierDeplacementZone > delaiDeplacementZone) {
      DemarrerTransitionZone();
      dernierDeplacementZone = millis();
      JouerSon("plaque_pression", 1, 0.8);
    }

    // Animation de transition
    if (transitionZone < 1.0) {
      float dureeTransition = 1000; // 1 seconde
      float t = constrain((millis() - debutTransition) / dureeTransition, 0, 1);
      // Easing out cubic
      float ease = 1 - pow(1 - t, 3);
      zoneX = lerp(ancienneZoneX, nouvelleZoneX, ease);
      zoneY = lerp(ancienneZoneY, nouvelleZoneY, ease);
      transitionZone = t;
    }

    // Trouver qui est dans la zone
    ArrayList<Integer> dansZone = new ArrayList<Integer>();
    for (Tank t : AllTanks) {
      if (!t.vivant) continue;
      if (dist(t.x, t.y, zoneX, zoneY) < zoneRayon) {
        dansZone.add(t.joueurId);
      }
    }

    // Un seul joueur dans la zone = il capture (pas pendant transition)
    if (dansZone.size() == 1 && transitionZone >= 1.0) {
      int id = dansZone.get(0);
      zoneOccupant = id;
      scoreColline[id] += 1.0 / frameRate;
    } else {
      zoneOccupant = -1;
    }
  }

  void DemarrerTransitionZone() {
    ancienneZoneX = zoneX;
    ancienneZoneY = zoneY;
    PlacerZoneColline();
    nouvelleZoneX = zoneX;
    nouvelleZoneY = zoneY;
    // Remettre la position à l'ancienne pour l'animation
    zoneX = ancienneZoneX;
    zoneY = ancienneZoneY;
    transitionZone = 0;
    debutTransition = millis();
  }

  void PlacerZoneColline() {
    // Trouver une position valide (pas dans un mur, éloignée de la position actuelle)
    float marge = zoneRayon + 40;
    float distMin = 150; // distance minimum de l'ancienne position
    float ancX = zoneX;
    float ancY = zoneY;

    for (int tentative = 0; tentative < 100; tentative++) {
      float nx = random(marge, LARGEUR - marge);
      float ny = random(marge + 40, HAUTEUR - marge);

      // Trop près de l'ancienne position
      if (dist(nx, ny, ancX, ancY) < distMin) continue;

      boolean valide = true;
      for (Mur m : AllMurs) {
        if (dist(nx, ny, m.x, m.y) < zoneRayon + max(m.tailleX, m.tailleY)/2) {
          valide = false;
          break;
        }
      }
      if (valide) {
        zoneX = nx;
        zoneY = ny;
        return;
      }
    }
    // Fallback : position opposée sur la carte
    zoneX = LARGEUR - ancX;
    zoneY = HAUTEUR - ancY;
    zoneX = constrain(zoneX, marge, LARGEUR - marge);
    zoneY = constrain(zoneY, marge + 40, HAUTEUR - marge);
  }

  void Dessiner_ZoneColline() {
    push();
    noStroke();

    // Cercle extérieur pulsant
    float pulse = 0.9 + sin(millis() * 0.003) * 0.1;
    float r = zoneRayon * pulse;

    // Couleur selon l'occupant
    color cZone;
    if (zoneOccupant >= 0) {
      cZone = COULEURS_JOUEURS[zoneOccupant];
    } else {
      cZone = #FFA726;
    }

    // Halo
    fill(cZone, 15);
    ellipse(zoneX, zoneY, r * 3, r * 3);

    // Zone principale
    fill(cZone, 30);
    ellipse(zoneX, zoneY, r * 2, r * 2);

    // Bordure
    stroke(cZone, 120);
    strokeWeight(2);
    noFill();
    ellipse(zoneX, zoneY, r * 2, r * 2);

    // Bordure intérieure pointillée
    stroke(cZone, 60);
    strokeWeight(1);
    float segments = 24;
    for (int i = 0; i < segments; i += 2) {
      float a1 = TWO_PI * i / segments + millis() * 0.001;
      float a2 = TWO_PI * (i + 1) / segments + millis() * 0.001;
      float ri = r * 0.7;
      line(zoneX + cos(a1) * ri, zoneY + sin(a1) * ri,
           zoneX + cos(a2) * ri, zoneY + sin(a2) * ri);
    }

    // Icône couronne au centre
    noStroke();
    fill(cZone, 80);
    float cs = 8;
    // Base couronne
    rect(zoneX - cs, zoneY + cs * 0.3, cs * 2, cs * 0.5);
    // Pointes
    triangle(zoneX - cs, zoneY + cs * 0.3, zoneX - cs, zoneY - cs * 0.5, zoneX - cs * 0.5, zoneY);
    triangle(zoneX, zoneY + cs * 0.3, zoneX, zoneY - cs * 0.8, zoneX, zoneY);
    triangle(zoneX + cs, zoneY + cs * 0.3, zoneX + cs, zoneY - cs * 0.5, zoneX + cs * 0.5, zoneY);

    // Timer déplacement zone (barre circulaire + compte à rebours)
    if (paramZoneMobile) {
      float progression = (millis() - dernierDeplacementZone) / delaiDeplacementZone;
      stroke(cZone, 40);
      strokeWeight(3);
      noFill();
      arc(zoneX, zoneY, r * 2.3, r * 2.3, -HALF_PI, -HALF_PI + TWO_PI * progression);

      // Compte à rebours visible
      float secsRestantes = (delaiDeplacementZone - (millis() - dernierDeplacementZone)) / 1000.0;
      if (secsRestantes > 0 && secsRestantes < 6) {
        TexteCentre((int)ceil(secsRestantes) + "", zoneX, zoneY - zoneRayon - 15, 14, cZone);
      }
    }

    pop();

    // Barres de score colline en bas de l'écran
    Dessiner_BarresColline();
  }

  void Dessiner_BarresColline() {
    push();
    rectMode(CORNER);
    float barW = 200;
    float barH = 14;
    float totalW = nbJoueurs * (barW + 20);
    float startX = (LARGEUR - totalW) / 2;
    float y = HAUTEUR - 30;

    for (int i = 0; i < nbJoueurs; i++) {
      float bx = startX + i * (barW + 20);

      // Fond barre
      fill(0, 0, 0, 150);
      noStroke();
      rect(bx, y, barW, barH, 3);

      // Remplissage
      float pct = scoreColline[i] / scoreCollineMax;
      color c = COULEURS_JOUEURS[i];
      fill(c, 200);
      rect(bx, y, barW * pct, barH, 3);

      // Bordure
      noFill();
      stroke(c, 150);
      strokeWeight(1);
      rect(bx, y, barW, barH, 3);

      // Pourcentage
      TexteCentre((int)(pct * 100) + "%", bx + barW/2, y + barH/2, 10, COULEUR_UI_TEXTE);

      // Label joueur
      TexteCentre("J" + (i+1), bx + barW/2, y - 10, 11, c);
    }

    pop();
  }
}

void LancerPartie() {
  int nbJoueurs = CompterJoueursActifs();
  if (nbJoueurs < 2) nbJoueurs = 2; // Minimum 2 joueurs

  EffacerTraces();
  AllTerrains.clear();
  partieActuelle = new Partie(carteSelectionnee, nbJoueurs);
  partieActuelle.Demarrer();
}

void Fonctions_Partie() {
  if (partieActuelle != null) {
    partieActuelle.Fonctions();
  }
}
