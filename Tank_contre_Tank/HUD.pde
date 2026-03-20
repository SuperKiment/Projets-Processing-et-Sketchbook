// ============================================
// HUD.pde - Interface en jeu
// ============================================

void Afficher_HUD() {
  if (partieActuelle == null) return;

  push();
  rectMode(CORNER);

  // Barre du haut avec les joueurs (2 rangées)
  float barreHaut = 52;
  fill(0, 0, 0, 150);
  noStroke();
  rect(0, 0, LARGEUR, barreHaut);

  float segmentLarg = LARGEUR / partieActuelle.nbJoueurs;
  float ligne1 = 16;  // Rangée 1 : nom joueur, nom tank, score
  float ligne2 = 38;  // Rangée 2 : HP, ammo, boosts, spécial

  for (int i = 0; i < partieActuelle.nbJoueurs; i++) {
    float sx = i * segmentLarg;
    Tank tank = (i < AllTanks.size()) ? AllTanks.get(i) : null;

    // Bande couleur joueur
    fill(COULEURS_JOUEURS[i]);
    noStroke();
    rect(sx, 0, segmentLarg, 5);

    // Séparateur vertical entre joueurs
    if (i > 0) {
      stroke(255, 30);
      strokeWeight(1);
      line(sx, 5, sx, barreHaut);
      noStroke();
    }

    // --- Rangée 1 : Nom joueur + tank + score ---
    String tankNom = (tank != null) ? tank.type.nom : "";
    TexteGauche("J" + (i+1), sx + 10, ligne1, 15, COULEURS_JOUEURS[i]);
    TexteGauche(tankNom, sx + 42, ligne1, 11, COULEUR_UI_TEXTE_DIM);

    // Score (aligné à droite, rangée 1)
    fill(COULEUR_UI_TEXTE);
    textAlign(RIGHT, CENTER);
    textSize(18);
    if (partieActuelle.EstModeColline()) {
      int pct = (int)(partieActuelle.scoreColline[i] / partieActuelle.scoreCollineMax * 100);
      text(partieActuelle.scores[i] + "/" + SCORE_VICTOIRE + "  " + pct + "%", sx + segmentLarg - 10, ligne1);
    } else {
      text(partieActuelle.scores[i] + "/" + SCORE_VICTOIRE, sx + segmentLarg - 10, ligne1);
    }

    // --- Rangée 2 : HP, ammo, boosts, spécial ---
    if (tank != null && tank.vivant) {
      float hpX = sx + 10;
      for (int h = 0; h < tank.type.hpMax; h++) {
        fill(h < tank.hp ? COULEURS_JOUEURS[i] : #333333);
        noStroke();
        rect(hpX + h * 16, ligne2 - 6, 12, 12, 2);
      }
      // Munition actuelle
      float afterHP = hpX + tank.type.hpMax * 16 + 6;
      if (tank.canon.munsSpecialesRestantes > 0) {
        fill(tank.canon.typeMunActuel.couleur);
        noStroke();
        ellipse(afterHP + 4, ligne2, 8, 8);
        TexteGauche("" + tank.canon.munsSpecialesRestantes, afterHP + 12, ligne2, 11, tank.canon.typeMunActuel.couleur);
        afterHP += 30;
      }
      // Boosts actifs
      for (int b = 0; b < tank.boosts.size(); b++) {
        BoostActif boost = tank.boosts.get(b);
        float vie = (boost.fin - millis()) / 1000.0;
        if (vie > 0) {
          color bc = BoostCouleur(boost.categorie);
          fill(bc);
          noStroke();
          ellipse(afterHP + b * 14, ligne2, 8, 8);
          // Barre de durée restante
          fill(bc, 80);
          rect(afterHP + b * 14 - 4, ligne2 + 6, 8 * min(1, vie / 5.0), 2);
        }
      }
      // Spécial cooldown (aligné à droite, rangée 2)
      float cd = tank.CooldownSpecial();
      float cdW = 50;
      float cdX = sx + segmentLarg - cdW - 10;
      fill(cd >= 1.0 ? COULEUR_UI_ACCENT : #444444);
      noStroke();
      rectMode(CORNER);
      rect(cdX, ligne2 - 8, cdW, 16, 3);
      fill(COULEUR_UI_ACCENT, 180);
      rect(cdX, ligne2 - 8, cdW * cd, 16, 3);
      fill(COULEUR_UI_TEXTE);
      textAlign(CENTER, CENTER);
      textSize(10);
      text(tank.type.specialNom, cdX + cdW/2, ligne2 - 1);
    } else {
      TexteGauche("K.O.", sx + 10, ligne2, 14, #EF5350);
    }
  }

  // Numéro de manche + mode + indicateur jour/nuit
  String mancheLabel = "Manche " + partieActuelle.manche;
  if (modeActuel != null && !modeActuel.nom.equals("Deathmatch")) {
    mancheLabel += "  -  " + modeActuel.nom;
  }
  if (paramJourNuitAleatoire) {
    mancheLabel += modeJour ? "  [Jour]" : "  [Nuit]";
  }
  TexteCentre(mancheLabel, LARGEUR/2, barreHaut + 15, 12, COULEUR_UI_TEXTE_DIM);

  pop();
}

void Afficher_Pause() {
  // Overlay semi-transparent
  push();
  rectMode(CORNER);
  fill(0, 0, 0, 180);
  noStroke();
  rect(0, 0, LARGEUR, HAUTEUR);

  TexteCentre("PAUSE", LARGEUR/2, HAUTEUR/2 - 60, 48, COULEUR_UI_TEXTE);
  TexteCentre("P pour reprendre", LARGEUR/2, HAUTEUR/2 + 10, 20, COULEUR_UI_TEXTE_DIM);
  TexteCentre("ECHAP pour quitter au menu", LARGEUR/2, HAUTEUR/2 + 45, 18, COULEUR_UI_TEXTE_DIM);
  TexteCentre("TAB : changer filtre visuel (" + postShaderNoms[postShaderActuel] + ")", LARGEUR/2, HAUTEUR/2 + 80, 16, COULEUR_UI_TEXTE_DIM);
  pop();
}

void Afficher_FinManche() {
  // Dessiner le jeu en fond (gelé)
  FondEcran(CouleurFondJeu());
  Dessiner_Traces();
  Dessiner_Terrains();
  Fonctions_Murs();
  for (Tank t : AllTanks) {
    t.Affichage();
  }
  ParticuleFonctions();

  // Overlay
  push();
  rectMode(CORNER);
  fill(0, 0, 0, 180);
  noStroke();
  rect(0, 0, LARGEUR, HAUTEUR);

  if (partieActuelle.dernierGagnant >= 0) {
    color cGagnant = COULEURS_JOUEURS[partieActuelle.dernierGagnant];
    TexteCentre("Joueur " + (partieActuelle.dernierGagnant + 1) + " gagne la manche!",
                LARGEUR/2, HAUTEUR/2 - 60, 36, cGagnant);
  } else {
    TexteCentre("Egalite!", LARGEUR/2, HAUTEUR/2 - 60, 36, COULEUR_UI_TEXTE);
  }

  // Afficher les scores
  String scoreTexte = "";
  for (int i = 0; i < partieActuelle.nbJoueurs; i++) {
    scoreTexte += "J" + (i+1) + ": " + partieActuelle.scores[i] + "  ";
  }
  TexteCentre(scoreTexte, LARGEUR/2, HAUTEUR/2, 24, COULEUR_UI_TEXTE);

  // Timer auto-avance
  float tempsRestant = DELAI_FIN_MANCHE - (millis() - timerFinManche);
  if (tempsRestant > 0) {
    TexteCentre("Prochaine manche dans " + nf(tempsRestant/1000, 1, 1) + "s...",
                LARGEUR/2, HAUTEUR/2 + 60, 18, COULEUR_UI_TEXTE_DIM);
  }

  TexteCentre("ESPACE pour continuer", LARGEUR/2, HAUTEUR/2 + 100, 16, COULEUR_UI_TEXTE_DIM);
  pop();

  // Auto-avance
  if (millis() - timerFinManche >= DELAI_FIN_MANCHE) {
    partieActuelle.NouvelleManche();
    ChangerEtat(Etat.EN_JEU);
  }
}

void Afficher_FinPartie() {

  // Trouver le gagnant
  int gagnant = 0;
  for (int i = 1; i < partieActuelle.nbJoueurs; i++) {
    if (partieActuelle.scores[i] > partieActuelle.scores[gagnant]) gagnant = i;
  }

  TexteCentre("VICTOIRE!", LARGEUR/2, 150, 56, COULEURS_JOUEURS[gagnant]);
  TexteCentre("Joueur " + (gagnant + 1), LARGEUR/2, 220, 36, COULEURS_JOUEURS[gagnant]);

  // Scores finaux
  for (int i = 0; i < partieActuelle.nbJoueurs; i++) {
    float sy = 300 + i * 50;
    color c = (i == gagnant) ? COULEURS_JOUEURS[i] : COULEUR_UI_TEXTE_DIM;
    TexteCentre("Joueur " + (i+1) + " : " + partieActuelle.scores[i] + " points",
                LARGEUR/2, sy, 22, c);
  }

  TexteCentre("ESPACE pour rejouer", LARGEUR/2, HAUTEUR - 120, 20, COULEUR_UI_TEXTE);
  TexteCentre("ECHAP pour le menu", LARGEUR/2, HAUTEUR - 80, 18, COULEUR_UI_TEXTE_DIM);
}

color BoostCouleur(String cat) {
  if (cat.equals("boost_vitesse")) return #FF44FF;
  if (cat.equals("boost_defense")) return #4488FF;
  if (cat.equals("boost_cadence")) return #FFAA00;
  if (cat.equals("boost_invisible")) return #8888CC;
  if (cat.equals("boost_degats")) return #FF2200;
  if (cat.equals("boost_aimant")) return #CCCC44;
  if (cat.equals("boost_vampirique")) return #CC0044;
  if (cat.equals("boost_gigantisme")) return #FF8800;
  if (cat.equals("boost_miniature")) return #88CCFF;
  if (cat.equals("boost_fantome")) return #9966FF;
  if (cat.equals("boost_magnetique")) return #44FFAA;
  if (cat.equals("ralenti")) return #4488FF;
  if (cat.equals("herbe_cache")) return #228822;
  return #FFFFFF;
}
