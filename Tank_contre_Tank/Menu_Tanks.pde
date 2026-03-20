// ============================================
// Menu_Tanks.pde - Sélection de tank par joueur
// ============================================

int[] indexTankParJoueur = new int[4];
boolean[] joueurPret = new boolean[4];
boolean[] stickTanksActifParJoueur = new boolean[4];
Bouton bRetourTanks;

void Setup_MenuTanks() {
  int nbJoueurs = CompterJoueursActifs();
  for (int i = 0; i < 4; i++) {
    indexTankParJoueur[i] = 0;
    joueurPret[i] = false;
  }
}

void Afficher_MenuTanks() {
  int nbJoueurs = max(2, CompterJoueursActifs());

  TexteCentre("CHOISIR SON TANK", LARGEUR/2, 35, 36, COULEUR_UI_TEXTE);

  float slotLarg = min(240, (LARGEUR - 60) / nbJoueurs);
  float totalLarg = nbJoueurs * slotLarg;
  float debutX = (LARGEUR - totalLarg) / 2;

  for (int j = 0; j < nbJoueurs; j++) {
    float sx = debutX + j * slotLarg + slotLarg / 2;
    int idx = indexTankParJoueur[j];
    TypeTank tt = TypesTanks.get(ListeNomsTanks.get(idx));
    boolean pret = joueurPret[j];

    // Cadre joueur
    push();
    rectMode(CENTER);
    if (pret) {
      stroke(#66BB6A);
      strokeWeight(3);
    } else {
      stroke(COULEUR_UI_BORD);
      strokeWeight(1);
    }
    fill(COULEUR_UI_PANNEAU);
    rect(sx, 340, slotLarg - 15, 540, 10);
    pop();

    // Bande couleur
    push();
    noStroke();
    fill(COULEURS_JOUEURS[j]);
    rectMode(CORNER);
    rect(sx - (slotLarg - 15)/2, 70, slotLarg - 15, 5);
    pop();

    // Nom joueur
    TexteCentre("J" + (j + 1), sx, 92, 22, COULEURS_JOUEURS[j]);

    // Preview du tank
    float previewY = 185;
    DessinerTankPreview(sx, previewY, PI/4, tt, COULEURS_JOUEURS[j], 2.8);

    // Hitbox circle (debug visuel)
    push();
    noFill();
    stroke(COULEURS_JOUEURS[j], 40);
    strokeWeight(1);
    ellipse(sx, previewY, tt.hitboxRayon * 2 * 2.8, tt.hitboxRayon * 2 * 2.8);
    pop();

    // Nom du tank
    TexteCentre(tt.nom, sx, 265, 20, COULEUR_UI_TEXTE);

    // Description
    TexteCentre(tt.description, sx, 290, 11, COULEUR_UI_TEXTE_DIM);

    // Stats (barres visuelles)
    float statsX = sx - (slotLarg - 50) / 2;
    float statsW = slotLarg - 50;
    float statsY = 320;

    AfficherStatTank(statsX, statsY, statsW, "VIE", tt.hpMax / 6.0, #66BB6A); statsY += 28;
    AfficherStatTank(statsX, statsY, statsW, "VITESSE", tt.speedMax / 8.0, #FF44FF); statsY += 28;
    AfficherStatTank(statsX, statsY, statsW, "CADENCE", 1.0 - (tt.cadenceTir - 300) / 1200.0, #FFAA00); statsY += 28;
    AfficherStatTank(statsX, statsY, statsW, "TAILLE", tt.taille / 32.0, #4488FF); statsY += 28;

    // Spécial
    statsY += 8;
    TexteCentre(tt.specialNom, sx, statsY, 16, COULEUR_UI_ACCENT);
    statsY += 20;
    TexteCentre(tt.specialDesc, sx, statsY, 11, COULEUR_UI_TEXTE_DIM);
    statsY += 18;
    TexteCentre("CD: " + nf(tt.specialCooldown / 1000.0, 1, 0) + "s", sx, statsY, 11, COULEUR_UI_TEXTE_DIM);

    // Flèches de navigation
    if (!pret) {
      TexteCentre("<", sx - slotLarg/2 + 15, 265, 24, COULEUR_UI_TEXTE_DIM);
      TexteCentre(">", sx + slotLarg/2 - 15, 265, 24, COULEUR_UI_TEXTE_DIM);
    }

    // Statut
    if (pret) {
      TexteCentre("PRET!", sx, 570, 18, #66BB6A);
    } else {
      String inputDesc = inputManager.DescriptionJoueur(j);
      if (inputDesc.contains("Clavier")) {
        TexteCentre("Tir = confirmer", sx, 560, 11, COULEUR_UI_TEXTE_DIM);
        TexteCentre("Special = annuler", sx, 575, 11, COULEUR_UI_TEXTE_DIM);
      } else {
        TexteCentre("A = confirmer", sx, 560, 11, COULEUR_UI_TEXTE_DIM);
        TexteCentre("B = annuler", sx, 575, 11, COULEUR_UI_TEXTE_DIM);
      }
    }
  }

  // Instruction en bas
  boolean tousPrets = true;
  for (int j = 0; j < nbJoueurs; j++) {
    if (!joueurPret[j]) tousPrets = false;
  }
  if (tousPrets) {
    TexteCentre("ESPACE ou START pour lancer!", LARGEUR/2, HAUTEUR - 35, 22, COULEUR_UI_ACCENT);
  } else {
    TexteCentre("Chaque joueur choisit son tank", LARGEUR/2, HAUTEUR - 55, 16, COULEUR_UI_TEXTE_DIM);
  }

  // Bouton retour
  if (bRetourTanks == null) bRetourTanks = new Bouton("RETOUR", 100, HAUTEUR - 40, 150, 40);
  bRetourTanks.Affichage();

  // Input par joueur
  MettreAJourInputsTanks(nbJoueurs);
  MettreAJourManettesTanks();
}

void AfficherStatTank(float x, float y, float w, String nom, float valeur, color c) {
  valeur = constrain(valeur, 0, 1);
  push();
  // Label
  fill(COULEUR_UI_TEXTE_DIM);
  noStroke();
  textAlign(LEFT, CENTER);
  textSize(10);
  text(nom, x, y);
  // Barre fond
  fill(#222233);
  rectMode(CORNER);
  rect(x, y + 8, w, 6, 2);
  // Barre valeur
  fill(c);
  rect(x, y + 8, w * valeur, 6, 2);
  pop();
}

void MettreAJourInputsTanks(int nbJoueurs) {
  // Mise à jour des inputs (nécessaire pour la manette)
  inputManager.MettreAJour();
}

void LancerDepuisTanks(int nbJoueurs) {
  for (int j = 0; j < nbJoueurs; j++) {
    tankChoisiParJoueur[j] = ListeNomsTanks.get(indexTankParJoueur[j]);
  }
  ChangerEtat(Etat.EN_JEU);
}

void NaviguerTankJoueur(int joueur, int direction) {
  if (joueurPret[joueur]) return;
  int nbTanks = ListeNomsTanks.size();
  indexTankParJoueur[joueur] = (indexTankParJoueur[joueur] + direction + nbTanks) % nbTanks;
}

void Clavier_MenuTanks(char k, int kc) {
  int nbJoueurs = max(2, CompterJoueursActifs());

  // Joueur 1 (ZQSD)
  if (k == 'q') NaviguerTankJoueur(0, -1);
  if (k == 'd') NaviguerTankJoueur(0, 1);
  if (k == 'c') { // tir = confirmer
    if (!joueurPret[0]) {
      joueurPret[0] = true;
      tankChoisiParJoueur[0] = ListeNomsTanks.get(indexTankParJoueur[0]);
    }
  }
  if (k == 'v') joueurPret[0] = false; // special = annuler

  // Joueur 2 (flèches)
  if (k == CODED && kc == LEFT) NaviguerTankJoueur(1, -1);
  if (k == CODED && kc == RIGHT) NaviguerTankJoueur(1, 1);
  if (k == ENTER || k == RETURN) {
    if (nbJoueurs >= 2 && !joueurPret[1]) {
      joueurPret[1] = true;
      tankChoisiParJoueur[1] = ListeNomsTanks.get(indexTankParJoueur[1]);
    }
  }
  if (k == CODED && kc == SHIFT) joueurPret[1] = false;

  // Espace = lancer si tous prêts
  if (k == ' ') {
    boolean tousPrets = true;
    for (int j = 0; j < nbJoueurs; j++) {
      if (!joueurPret[j]) tousPrets = false;
    }
    if (tousPrets) LancerDepuisTanks(nbJoueurs);
  }

  // Retour
  if (k == BACKSPACE || kc == 27) {
    ChangerEtat(Etat.MENU_CARTES);
  }
}

// Navigation manettes
void MettreAJourManettesTanks() {
  int nbJoueurs = max(2, CompterJoueursActifs());
  for (int j = 0; j < nbJoueurs; j++) {
    PlayerInput pi = inputManager.GetJoueur(j);
    if (pi == null || !pi.utiliseManette || pi.manette == null) continue;
    if (!pi.manette.connectee) continue;

    float axeX = pi.manette.axes[0];
    float dpadX = pi.manette.axes[6];
    float combinedX = (abs(axeX) > abs(dpadX)) ? axeX : dpadX;
    float deadzone = 0.5;

    // Navigation stick avec debounce
    if (abs(combinedX) < deadzone) {
      stickTanksActifParJoueur[j] = false;
    } else if (!stickTanksActifParJoueur[j]) {
      if (combinedX < -deadzone) NaviguerTankJoueur(j, -1);
      if (combinedX > deadzone) NaviguerTankJoueur(j, 1);
      stickTanksActifParJoueur[j] = true;
    }

    // Boutons
    if (pi.manette.boutonsPresses[0]) { // A = confirmer
      if (!joueurPret[j]) {
        joueurPret[j] = true;
        tankChoisiParJoueur[j] = ListeNomsTanks.get(indexTankParJoueur[j]);
      }
    }
    if (pi.manette.boutonsPresses[1]) { // B = annuler
      joueurPret[j] = false;
    }
    if (pi.manette.boutonsPresses[7]) { // Start = lancer
      boolean tousPrets = true;
      for (int jj = 0; jj < nbJoueurs; jj++) {
        if (!joueurPret[jj]) tousPrets = false;
      }
      if (tousPrets) LancerDepuisTanks(nbJoueurs);
    }
  }
}

void Clic_MenuTanks() {
  // Bouton retour
  if (bRetourTanks == null) bRetourTanks = new Bouton("RETOUR", 100, HAUTEUR - 40, 150, 40);
  if (bRetourTanks.SourisDessus()) {
    ChangerEtat(Etat.MENU_CARTES);
    return;
  }

  // Espace via validation menu
  int nbJoueurs = max(2, CompterJoueursActifs());
  boolean tousPrets = true;
  for (int j = 0; j < nbJoueurs; j++) {
    if (!joueurPret[j]) tousPrets = false;
  }
  if (tousPrets) LancerDepuisTanks(nbJoueurs);
}
