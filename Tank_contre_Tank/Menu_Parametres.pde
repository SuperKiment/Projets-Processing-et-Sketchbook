// ============================================
// Menu_Parametres.pde - Page de paramètres
// ============================================

int paramSelection = 0;
int NB_PARAMS = 5;

void Afficher_MenuParametres() {
  TexteCentre("PARAMETRES", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  float cx = LARGEUR / 2;
  float startY = 130;
  float hauteurParam = 70;
  float largeurParam = 600;

  // === Paramètre 0 : Jour/Nuit aléatoire ===
  AfficherToggle(cx, startY, largeurParam, hauteurParam, 0,
    "Jour / Nuit aleatoire",
    "Chaque manche a une chance d'etre en mode jour (pas d'assombrissement)",
    paramJourNuitAleatoire);

  // === Paramètre 1 : Couleurs aléatoires entre manches ===
  AfficherToggle(cx, startY + hauteurParam + 15, largeurParam, hauteurParam, 1,
    "Couleurs aleatoires entre manches",
    "La palette de couleurs (fond + murs) change aleatoirement a chaque manche",
    paramCouleursAleatoires);

  // === Paramètre 2 : Score de victoire ===
  AfficherValeur(cx, startY + (hauteurParam + 15) * 2, largeurParam, hauteurParam, 2,
    "Score de victoire",
    "Nombre de manches a gagner pour remporter la partie",
    SCORE_VICTOIRE, 1, 20);

  // === Paramètre 3 : Delai fin de manche ===
  AfficherValeur(cx, startY + (hauteurParam + 15) * 3, largeurParam, hauteurParam, 3,
    "Delai fin de manche",
    "Temps avant passage automatique a la manche suivante",
    (int)(DELAI_FIN_MANCHE / 1000), 1, 10);

  // === Paramètre 4 : Taille de la map ===
  AfficherValeur(cx, startY + (hauteurParam + 15) * 4, largeurParam, hauteurParam, 4,
    "Taille de la map",
    "Rend les tanks plus petits et lents pour simuler une plus grande map",
    paramTailleMap, 50, 200);
  // Unité % affichée via le bloc ci-dessous

  // === Preview jour/nuit ===
  float previewY = startY + (hauteurParam + 15) * 5 + 20;
  float previewW = 200;
  float previewH = 100;

  // Preview nuit
  // Couleurs de la carte sélectionnée (ou défaut)
  color prevFondN = (carteSelectionnee != null) ? carteSelectionnee.couleurFondOriginal : #0A0A14;
  color prevMurN  = (carteSelectionnee != null) ? carteSelectionnee.couleurMurOriginal  : #707088;
  color prevFondJ = (carteSelectionnee != null) ? carteSelectionnee.couleurFondJour : #B8B0A0;
  color prevMurJ  = (carteSelectionnee != null) ? carteSelectionnee.couleurMurJour  : #5A5A6E;

  // Preview nuit
  push();
  rectMode(CORNER);
  fill(prevFondN);
  noStroke();
  rect(cx - previewW - 20, previewY, previewW, previewH);
  fill(prevMurN);
  rectMode(CENTER);
  rect(cx - previewW - 20 + previewW/2, previewY + previewH/2, 40, 40);
  rect(cx - previewW - 20 + previewW/4, previewY + previewH/2, 15, 50);
  // Overlay sombre (simule éclairage nuit)
  rectMode(CORNER);
  fill(0, 0, 0, 120);
  rect(cx - previewW - 20, previewY, previewW, previewH);
  // Petites lueurs pour simuler les lumières des tanks
  noStroke();
  fill(#4FC3F7, 60);
  ellipse(cx - previewW - 20 + previewW * 0.3, previewY + previewH * 0.6, 40, 40);
  fill(#EF5350, 60);
  ellipse(cx - previewW - 20 + previewW * 0.7, previewY + previewH * 0.4, 40, 40);
  pop();
  TexteCentre("NUIT", cx - previewW/2 - 20, previewY + previewH + 18, 14, COULEUR_UI_TEXTE_DIM);

  // Preview jour
  push();
  rectMode(CORNER);
  fill(prevFondJ);
  noStroke();
  rect(cx + 20, previewY, previewW, previewH);
  fill(prevMurJ);
  rectMode(CENTER);
  rect(cx + 20 + previewW/2, previewY + previewH/2, 40, 40);
  rect(cx + 20 + previewW/4, previewY + previewH/2, 15, 50);
  // Ombres portées (jour)
  noStroke();
  fill(0, 50);
  rect(cx + 20 + previewW/2 + 4, previewY + previewH/2 + 4, 40, 40);
  rect(cx + 20 + previewW/4 + 4, previewY + previewH/2 + 4, 15, 50);
  // Traces de chenilles (simulées)
  fill(40, 30, 20, 70);
  rectMode(CORNER);
  rect(cx + 25, previewY + previewH * 0.5, 60, 3);
  rect(cx + 25, previewY + previewH * 0.55, 60, 3);
  pop();
  TexteCentre("JOUR", cx + previewW/2 + 20, previewY + previewH + 18, 14, COULEUR_UI_TEXTE_DIM);

  // === Retour ===
  Bouton bRetourParam = new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 50, 250, 45);
  bRetourParam.Affichage();
}

void AfficherToggle(float cx, float y, float w, float h, int index,
                     String nom, String desc, boolean valeur) {
  push();
  rectMode(CENTER);

  // Cadre
  boolean sel = (index == paramSelection);
  if (sel) {
    stroke(COULEUR_UI_ACCENT);
    strokeWeight(2);
  } else {
    stroke(COULEUR_UI_BORD);
    strokeWeight(1);
  }
  fill(COULEUR_UI_PANNEAU);
  rect(cx, y, w, h, 8);

  // Nom
  TexteGauche(nom, cx - w/2 + 20, y - 12, 18, sel ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM);
  // Description
  TexteGauche(desc, cx - w/2 + 20, y + 14, 12, COULEUR_UI_TEXTE_DIM);

  // Toggle visuel
  float toggleX = cx + w/2 - 60;
  float toggleW = 50;
  float toggleH = 24;
  noStroke();
  fill(valeur ? #66BB6A : #555555);
  rect(toggleX, y, toggleW, toggleH, 12);
  // Pastille
  fill(255);
  float pastilleX = valeur ? toggleX + 13 : toggleX - 13;
  ellipse(pastilleX, y, 18, 18);

  // Texte statut
  String statut = valeur ? "OUI" : "NON";
  color cStatut = valeur ? #66BB6A : #EF5350;
  TexteCentre(statut, toggleX, y + toggleH/2 + 10, 11, cStatut);

  pop();
}

void AfficherValeur(float cx, float y, float w, float h, int index,
                     String nom, String desc, int valeur, int vMin, int vMax) {
  push();
  rectMode(CENTER);

  boolean sel = (index == paramSelection);
  if (sel) {
    stroke(COULEUR_UI_ACCENT);
    strokeWeight(2);
  } else {
    stroke(COULEUR_UI_BORD);
    strokeWeight(1);
  }
  fill(COULEUR_UI_PANNEAU);
  rect(cx, y, w, h, 8);

  // Nom
  TexteGauche(nom, cx - w/2 + 20, y - 12, 18, sel ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM);
  // Description
  TexteGauche(desc, cx - w/2 + 20, y + 14, 12, COULEUR_UI_TEXTE_DIM);

  // Flèches et valeur
  float valX = cx + w/2 - 60;
  TexteCentre("<", valX - 30, y, 22, sel ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM);
  TexteCentre("" + valeur, valX, y, 22, COULEUR_UI_ACCENT);
  TexteCentre(">", valX + 30, y, 22, sel ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM);

  // Unité pour le délai
  if (index == 3) {
    TexteCentre("sec", valX, y + 18, 11, COULEUR_UI_TEXTE_DIM);
  }
  // Unité pour la taille map
  if (index == 4) {
    TexteCentre("%", valX + 20, y, 16, COULEUR_UI_TEXTE_DIM);
  }

  pop();
}

void Clavier_MenuParametres(char k, int kc) {
  // Navigation haut/bas
  if (k == 'z' || (k == CODED && kc == UP)) {
    paramSelection = (paramSelection - 1 + NB_PARAMS) % NB_PARAMS;
  }
  if (k == 's' || (k == CODED && kc == DOWN)) {
    paramSelection = (paramSelection + 1) % NB_PARAMS;
  }

  // Toggle / modifier valeur
  boolean gauche = (k == 'q' || (k == CODED && kc == LEFT));
  boolean droite = (k == 'd' || (k == CODED && kc == RIGHT));
  boolean valider = (k == ENTER || k == RETURN || k == ' ');

  if (paramSelection == 0 && (valider || gauche || droite)) {
    paramJourNuitAleatoire = !paramJourNuitAleatoire;
  }
  if (paramSelection == 1 && (valider || gauche || droite)) {
    paramCouleursAleatoires = !paramCouleursAleatoires;
  }
  if (paramSelection == 2) {
    if (gauche) SCORE_VICTOIRE = max(1, SCORE_VICTOIRE - 1);
    if (droite) SCORE_VICTOIRE = min(20, SCORE_VICTOIRE + 1);
  }
  if (paramSelection == 3) {
    if (gauche) DELAI_FIN_MANCHE = max(1000, DELAI_FIN_MANCHE - 1000);
    if (droite) DELAI_FIN_MANCHE = min(10000, DELAI_FIN_MANCHE + 1000);
  }
  if (paramSelection == 4) {
    if (gauche) paramTailleMap = max(50, paramTailleMap - 25);
    if (droite) paramTailleMap = min(200, paramTailleMap + 25);
  }

  // Retour
  if (k == BACKSPACE || kc == 27) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

void Clic_MenuParametres() {
  float cx = LARGEUR / 2;
  float startY = 130;
  float hauteurParam = 70;
  float largeurParam = 600;

  for (int i = 0; i < NB_PARAMS; i++) {
    float y = startY + i * (hauteurParam + 15);
    if (sourisX > cx - largeurParam/2 && sourisX < cx + largeurParam/2 &&
        sourisY > y - hauteurParam/2 && sourisY < y + hauteurParam/2) {
      paramSelection = i;

      // Zone de toggle/valeur (partie droite)
      float valX = cx + largeurParam/2 - 60;
      if (i == 0 || i == 1) {
        // Toggle
        if (i == 0) paramJourNuitAleatoire = !paramJourNuitAleatoire;
        if (i == 1) paramCouleursAleatoires = !paramCouleursAleatoires;
      } else {
        // Valeur : clic gauche/droite
        if (sourisX < valX) {
          if (i == 2) SCORE_VICTOIRE = max(1, SCORE_VICTOIRE - 1);
          if (i == 3) DELAI_FIN_MANCHE = max(1000, DELAI_FIN_MANCHE - 1000);
          if (i == 4) paramTailleMap = max(50, paramTailleMap - 25);
        } else {
          if (i == 2) SCORE_VICTOIRE = min(20, SCORE_VICTOIRE + 1);
          if (i == 3) DELAI_FIN_MANCHE = min(10000, DELAI_FIN_MANCHE + 1000);
          if (i == 4) paramTailleMap = min(200, paramTailleMap + 25);
        }
      }
    }
  }

  // Bouton retour
  Bouton bRetourParam = new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 50, 250, 45);
  if (bRetourParam.SourisDessus()) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}
