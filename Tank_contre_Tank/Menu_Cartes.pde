// ============================================
// Menu_Cartes.pde - Sélection de carte
// ============================================

int carteIndex = 0;
SelecteurMenu menuCartes;

void Setup_MenuCartes() {
  menuCartes = new SelecteurMenu();
  float cx = LARGEUR / 2;
  menuCartes.AjouterBouton(new Bouton("LANCER", cx + 150, HAUTEUR - 60, 200, 50));
  menuCartes.AjouterBouton(new Bouton("RETOUR", cx - 150, HAUTEUR - 60, 200, 50));
}

void Afficher_MenuCartes() {
  background(COULEUR_FOND_MENU);

  // Titre
  TexteCentre("CHOISIR UNE CARTE", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  // Grille de cartes
  int colonnes = 3;
  float carteLarg = 280;
  float carteHaut = 220;
  float espaceX = 30;
  float espaceY = 20;
  float debutX = (LARGEUR - (colonnes * carteLarg + (colonnes-1) * espaceX)) / 2;
  float debutY = 80;

  for (int i = 0; i < ToutesLesCartes.size(); i++) {
    Carte carte = ToutesLesCartes.get(i);

    int col = i % colonnes;
    int lig = i / colonnes;
    float cx = debutX + col * (carteLarg + espaceX) + carteLarg/2;
    float cy = debutY + lig * (carteHaut + espaceY) + carteHaut/2;

    // Cadre de la carte
    push();
    rectMode(CENTER);
    if (i == carteIndex) {
      stroke(COULEUR_UI_ACCENT);
      strokeWeight(3);
    } else {
      stroke(COULEUR_UI_BORD);
      strokeWeight(1);
    }
    fill(COULEUR_UI_PANNEAU);
    rect(cx, cy, carteLarg, carteHaut, 8);
    pop();

    // Miniature
    float miniLarg = carteLarg - 30;
    float miniHaut = carteHaut - 60;
    carte.AfficherMiniature(cx - miniLarg/2, cy - carteHaut/2 + 15, miniLarg, miniHaut);

    // Nom
    TexteCentre(carte.nom, cx, cy + carteHaut/2 - 30, 18, COULEUR_UI_TEXTE);

    // Max joueurs
    TexteCentre(carte.maxJoueurs + "J", cx, cy + carteHaut/2 - 12, 13, COULEUR_UI_TEXTE_DIM);

    // Détection clic sur la carte
    if (mouseX > cx - carteLarg/2 && mouseX < cx + carteLarg/2 &&
        mouseY > cy - carteHaut/2 && mouseY < cy + carteHaut/2) {
      if (mousePressed && mouseButton == LEFT) {
        carteIndex = i;
      }
    }
  }

  // Carte sélectionnée
  carteSelectionnee = ToutesLesCartes.get(carteIndex);

  // Instructions
  TexteCentre("< Q/D ou fleches pour naviguer >", LARGEUR/2, HAUTEUR - 110, 14, COULEUR_UI_TEXTE_DIM);

  // Boutons bas
  menuCartes.MettreAJour();
  menuCartes.Affichage();

  // Navigation manettes
  for (ManetteNative m : manettesDetectees) {
    if (m.connectee) {
      float axeX = m.axes[0];
      NavigationCartesAnalog(axeX);
    }
  }
}

boolean stickCartesActif = false;

void NavigationCartesAnalog(float axeX) {
  float deadzone = 0.5;
  if (abs(axeX) < deadzone) {
    stickCartesActif = false;
  } else if (!stickCartesActif) {
    if (axeX < -deadzone) CarteNaviguer(-1);
    if (axeX > deadzone) CarteNaviguer(1);
    stickCartesActif = true;
  }
}

void CarteNaviguer(int dir) {
  carteIndex = constrain(carteIndex + dir, 0, ToutesLesCartes.size() - 1);
}

void Clic_MenuCartes() {
  if (menuCartes == null) return;

  Bouton bLancer = menuCartes.elements.get(0);
  Bouton bRetour = menuCartes.elements.get(1);

  if (bLancer.SourisDessus() || menuValiderPresse) {
    carteSelectionnee = ToutesLesCartes.get(carteIndex);
    ChangerEtat(Etat.EN_JEU);
  }
  if (bRetour.SourisDessus()) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

void Clavier_MenuCartes(char k, int kc) {
  if (k == 'q' || (k == CODED && kc == LEFT)) CarteNaviguer(-1);
  if (k == 'd' || (k == CODED && kc == RIGHT)) CarteNaviguer(1);
  if (k == ENTER || k == RETURN || k == ' ') {
    carteSelectionnee = ToutesLesCartes.get(carteIndex);
    ChangerEtat(Etat.EN_JEU);
  }
  if (k == BACKSPACE || k == ESC) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}
