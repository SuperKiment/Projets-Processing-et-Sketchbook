// ============================================
// Menu_Cartes.pde - Sélection de carte
// ============================================

int carteIndex = 0;
float carteScroll = 0;
float carteScrollCible = 0;
SelecteurMenu menuCartes;

void Setup_MenuCartes() {
  menuCartes = new SelecteurMenu();
  float cx = LARGEUR / 2;
  menuCartes.AjouterBouton(new Bouton("LANCER", cx + 150, HAUTEUR - 60, 200, 50));
  menuCartes.AjouterBouton(new Bouton("RETOUR", cx - 150, HAUTEUR - 60, 200, 50));
}

void Afficher_MenuCartes() {
  // Titre
  TexteCentre("CHOISIR UNE CARTE", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  // Grille de cartes
  int colonnes = 4;
  float carteLarg = 220;
  float carteHaut = 170;
  float espaceX = 20;
  float espaceY = 15;
  float debutX = (LARGEUR - (colonnes * carteLarg + (colonnes-1) * espaceX)) / 2;
  float debutY = 75;

  int nbLignes = (int)ceil((float)ToutesLesCartes.size() / colonnes);
  float hauteurTotale = nbLignes * (carteHaut + espaceY);
  float zoneVisible = HAUTEUR - debutY - 110; // espace entre titre et boutons
  float scrollMax = max(0, hauteurTotale - zoneVisible);

  // Scroll fluide
  carteScroll = lerp(carteScroll, carteScrollCible, 0.2);

  // Auto-scroll pour garder la sélection visible
  int ligSel = carteIndex / colonnes;
  float ySel = ligSel * (carteHaut + espaceY);
  if (ySel - carteScrollCible < 0) {
    carteScrollCible = ySel;
  }
  if (ySel + carteHaut - carteScrollCible > zoneVisible) {
    carteScrollCible = ySel + carteHaut - zoneVisible;
  }
  carteScrollCible = constrain(carteScrollCible, 0, scrollMax);

  // Clip zone
  push();
  // On dessine les cartes décalées par le scroll
  for (int i = 0; i < ToutesLesCartes.size(); i++) {
    Carte carte = ToutesLesCartes.get(i);

    int col = i % colonnes;
    int lig = i / colonnes;
    float cx = debutX + col * (carteLarg + espaceX) + carteLarg/2;
    float cy = debutY + lig * (carteHaut + espaceY) + carteHaut/2 - carteScroll;

    // Ne pas dessiner si hors écran
    if (cy + carteHaut/2 < debutY - 10 || cy - carteHaut/2 > HAUTEUR - 100) continue;

    // Hover détection
    boolean hover = sourisX > cx - carteLarg/2 && sourisX < cx + carteLarg/2 &&
                    sourisY > cy - carteHaut/2 && sourisY < cy + carteHaut/2;
    if (hover) carteIndex = i;
    boolean actif = (i == carteIndex);

    // Cadre de la carte
    push();
    rectMode(CENTER);
    float sc = actif ? 1.04 : 1.0;
    translate(cx, cy);
    scale(sc);

    if (actif) {
      stroke(COULEUR_UI_ACCENT);
      strokeWeight(3);
    } else {
      stroke(COULEUR_UI_BORD);
      strokeWeight(1);
    }
    fill(actif ? lerpColor(COULEUR_UI_PANNEAU, COULEUR_UI_ACCENT, 0.06) : COULEUR_UI_PANNEAU);
    rect(0, 0, carteLarg, carteHaut, 8);

    // Lueur
    if (actif) {
      noFill();
      stroke(COULEUR_UI_ACCENT, 30);
      strokeWeight(4);
      rect(0, 0, carteLarg + 4, carteHaut + 4, 10);
    }
    pop();

    // Miniature
    float miniLarg = carteLarg - 20;
    float miniHaut = carteHaut - 50;
    carte.AfficherMiniature(cx - miniLarg/2, cy - carteHaut/2 + 10, miniLarg, miniHaut);

    // Nom
    TexteCentre(carte.nom, cx, cy + carteHaut/2 - 25, 14, actif ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM);

    // Max joueurs
    TexteCentre(carte.maxJoueurs + "J", cx, cy + carteHaut/2 - 10, 11, COULEUR_UI_TEXTE_DIM);
  }
  pop();

  // Barre de scroll si nécessaire
  if (scrollMax > 0) {
    float barreX = LARGEUR - 15;
    float barreY = debutY;
    float barreH = zoneVisible;
    float poigneeH = max(20, barreH * (zoneVisible / hauteurTotale));
    float poigneeY = barreY + (barreH - poigneeH) * (carteScroll / scrollMax);

    push();
    noStroke();
    fill(#333333, 100);
    rectMode(CORNER);
    rect(barreX, barreY, 8, barreH, 4);
    fill(COULEUR_UI_ACCENT, 150);
    rect(barreX, poigneeY, 8, poigneeH, 4);
    pop();
  }

  // Masquer le haut et le bas pour un effet propre
  push();
  noStroke();
  fill(COULEUR_FOND_MENU);
  rectMode(CORNER);
  rect(0, 0, LARGEUR, debutY - 5);
  rect(0, HAUTEUR - 105, LARGEUR, 105);
  pop();

  // Carte sélectionnée
  carteSelectionnee = ToutesLesCartes.get(carteIndex);

  // Instructions
  TexteCentre("Fleches / molette pour naviguer", LARGEUR/2, HAUTEUR - 100, 13, COULEUR_UI_TEXTE_DIM);

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

void ScrollCartes(float delta) {
  carteScrollCible += delta * 40;
  int nbLignes = (int)ceil((float)ToutesLesCartes.size() / 4);
  float scrollMax = max(0, nbLignes * 185 - (HAUTEUR - 185));
  carteScrollCible = constrain(carteScrollCible, 0, scrollMax);
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

void CarteNaviguerVertical(int dir) {
  int colonnes = 4;
  int newIndex = carteIndex + dir * colonnes;
  carteIndex = constrain(newIndex, 0, ToutesLesCartes.size() - 1);
}

void Clic_MenuCartes() {
  if (menuCartes == null) return;

  Bouton bLancer = menuCartes.elements.get(0);
  Bouton bRetour = menuCartes.elements.get(1);

  if (bLancer.SourisDessus() || menuValiderPresse) {
    carteSelectionnee = ToutesLesCartes.get(carteIndex);
    ChangerEtat(Etat.MENU_TANKS);
  }
  if (bRetour.SourisDessus()) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

void Clavier_MenuCartes(char k, int kc) {
  if (k == 'q' || (k == CODED && kc == LEFT)) CarteNaviguer(-1);
  if (k == 'd' || (k == CODED && kc == RIGHT)) CarteNaviguer(1);
  if (k == 'z' || (k == CODED && kc == UP)) CarteNaviguerVertical(-1);
  if (k == 's' || (k == CODED && kc == DOWN)) CarteNaviguerVertical(1);
  if (k == ENTER || k == RETURN || k == ' ') {
    carteSelectionnee = ToutesLesCartes.get(carteIndex);
    ChangerEtat(Etat.MENU_TANKS);
  }
  if (k == BACKSPACE || kc == 27) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}
