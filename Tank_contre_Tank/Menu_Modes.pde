// ============================================
// Menu_Modes.pde - Sélection du mode de jeu
// ============================================

// --- Définition d'un mode de jeu ---

class ModeDeJeu {
  String nom;
  String description;
  String categorie; // "pvp" ou "pve"
  color couleur;
  boolean disponible; // false = grisé "Bientot"

  ModeDeJeu(String n, String d, String cat, color c, boolean dispo) {
    nom = n; description = d; categorie = cat; couleur = c; disponible = dispo;
  }
}

ArrayList<ModeDeJeu> tousLesModes = new ArrayList<ModeDeJeu>();
int modeSelectionne = 0;
ModeDeJeu modeActuel;
float modeScroll = 0;
float modeScrollCible = 0;
Bouton bRetourModes;

void Setup_Modes() {
  tousLesModes.clear();

  // === PVP ===
  tousLesModes.add(new ModeDeJeu(
    "Deathmatch",
    "Dernier tank en vie remporte la manche",
    "pvp", #E94560, true
  ));
  tousLesModes.add(new ModeDeJeu(
    "Roi de la colline",
    "Restez dans la zone pour marquer des points",
    "pvp", #FFA726, true
  ));
  tousLesModes.add(new ModeDeJeu(
    "Capture du drapeau",
    "Volez le drapeau ennemi et ramenez-le a votre base",
    "pvp", #4FC3F7, false
  ));
  tousLesModes.add(new ModeDeJeu(
    "Chasseur",
    "Chaque joueur a une cible assignee a eliminer",
    "pvp", #AB47BC, false
  ));
  tousLesModes.add(new ModeDeJeu(
    "Demolition",
    "Detruisez la base ennemie avant la votre",
    "pvp", #FF7043, false
  ));

  // === PVE ===
  tousLesModes.add(new ModeDeJeu(
    "Survie",
    "Survivez aux vagues d'ennemis en cooperation",
    "pve", #66BB6A, false
  ));
  tousLesModes.add(new ModeDeJeu(
    "Boss Rush",
    "Affrontez des boss de plus en plus redoutables",
    "pve", #EF5350, false
  ));
  tousLesModes.add(new ModeDeJeu(
    "Defense de base",
    "Protegez votre base contre les assauts ennemis",
    "pve", #29B6F6, false
  ));
  tousLesModes.add(new ModeDeJeu(
    "Exploration",
    "Explorez une map generee et trouvez la sortie",
    "pve", #9CCC65, false
  ));
  tousLesModes.add(new ModeDeJeu(
    "Convoi",
    "Escortez un convoi a travers un territoire hostile",
    "pve", #FFCA28, false
  ));

  modeActuel = tousLesModes.get(0);
}

// --- Listes d'indices par catégorie ---

ArrayList<Integer> getIndicesPvp() {
  ArrayList<Integer> list = new ArrayList<Integer>();
  for (int i = 0; i < tousLesModes.size(); i++) {
    if (tousLesModes.get(i).categorie.equals("pvp")) list.add(i);
  }
  return list;
}

ArrayList<Integer> getIndicesPve() {
  ArrayList<Integer> list = new ArrayList<Integer>();
  for (int i = 0; i < tousLesModes.size(); i++) {
    if (tousLesModes.get(i).categorie.equals("pve")) list.add(i);
  }
  return list;
}

// --- Constantes layout ---

float modeCardW() { return 460; }
float modeCardH() { return 60; }
float modeGap() { return 12; }
float modeZoneTop() { return 130; }
float modeZoneBot() { return HAUTEUR - 110; }
float modeColGauche() { return LARGEUR * 0.27; }
float modeColDroite() { return LARGEUR * 0.73; }

// --- Affichage ---

void Afficher_MenuModes() {
  if (tousLesModes.size() == 0) Setup_Modes();

  TexteCentre("MODE DE JEU", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  // Smooth scroll
  modeScroll = lerp(modeScroll, modeScrollCible, 0.15);

  float cardW = modeCardW();
  float cardH = modeCardH();
  float gap = modeGap();
  float zoneTop = modeZoneTop();
  float zoneBot = modeZoneBot();
  float colG = modeColGauche();
  float colD = modeColDroite();

  ArrayList<Integer> pveIdx = getIndicesPve();
  ArrayList<Integer> pvpIdx = getIndicesPvp();

  // === Titres colonnes ===
  TexteCentre("COOP / PVE", colG, 80, 22, #66BB6A);
  TexteCentre("PVP", colD, 80, 22, COULEUR_UI_ACCENT);

  // Séparateur vertical
  push();
  stroke(COULEUR_UI_BORD);
  strokeWeight(1);
  line(LARGEUR/2, zoneTop - 10, LARGEUR/2, zoneBot + 10);
  pop();

  // === Colonne PVE (gauche) ===
  float startY = zoneTop + cardH/2 - modeScroll;
  for (int j = 0; j < pveIdx.size(); j++) {
    int idx = pveIdx.get(j);
    float y = startY + j * (cardH + gap);
    if (y + cardH/2 > zoneTop - 10 && y - cardH/2 < zoneBot + 10) {
      AfficherCartMode(colG, y, cardW, cardH, idx);
    }
  }

  // === Colonne PVP (droite) ===
  for (int j = 0; j < pvpIdx.size(); j++) {
    int idx = pvpIdx.get(j);
    float y = startY + j * (cardH + gap);
    if (y + cardH/2 > zoneTop - 10 && y - cardH/2 < zoneBot + 10) {
      AfficherCartMode(colD, y, cardW, cardH, idx);
    }
  }

  // === Masques haut/bas pour clipping ===
  push();
  noStroke();
  fill(COULEUR_FOND_MENU);
  rectMode(CORNER);
  rect(0, 0, LARGEUR, zoneTop - 15);
  rect(0, zoneBot + 15, LARGEUR, HAUTEUR - zoneBot);
  pop();

  // Redessiner titres par-dessus le masque
  TexteCentre("COOP / PVE", colG, 80, 22, #66BB6A);
  TexteCentre("PVP", colD, 80, 22, COULEUR_UI_ACCENT);
  TexteCentre("MODE DE JEU", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  // === Scrollbar ===
  int maxItems = max(pveIdx.size(), pvpIdx.size());
  float contentH = maxItems * (cardH + gap);
  float zoneH = zoneBot - zoneTop;
  if (contentH > zoneH) {
    float scrollRatio = modeScroll / (contentH - zoneH);
    float barH = max(30, zoneH * (zoneH / contentH));
    float barY = zoneTop + scrollRatio * (zoneH - barH);
    push();
    noStroke();
    fill(COULEUR_UI_BORD, 100);
    rectMode(CORNER);
    rect(LARGEUR - 12, zoneTop, 6, zoneH, 3);
    fill(COULEUR_UI_TEXTE_DIM, 150);
    rect(LARGEUR - 12, barY, 6, barH, 3);
    pop();
  }

  // === Bouton retour ===
  if (bRetourModes == null) bRetourModes = new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 50, 250, 45);
  bRetourModes.Affichage();

  // === Navigation manettes ===
  for (ManetteNative m : manettesDetectees) {
    if (m.connectee) {
      float axe = m.axes[1];
      if (abs(axe) > 0.5) {
        NaviguerModes(axe > 0 ? 1 : -1);
      } else {
        modeStickActif = false;
      }
      if (m.boutonsPresses[0]) ValiderMode();
    }
  }
}

void AfficherCartMode(float cx, float y, float w, float h, int idx) {
  ModeDeJeu mode = tousLesModes.get(idx);
  boolean sel = (idx == modeSelectionne);
  boolean hover = mode.disponible && sourisX > cx - w/2 && sourisX < cx + w/2 &&
                  sourisY > y - h/2 && sourisY < y + h/2;

  // Sélectionner au hover souris
  if (hover) modeSelectionne = idx;

  boolean actif = sel || hover;

  push();
  rectMode(CENTER);

  // Scale au hover
  float sc = actif ? 1.03 : 1.0;
  translate(cx, y);
  scale(sc);

  // Fond
  if (!mode.disponible) {
    fill(COULEUR_UI_PANNEAU, 120);
    stroke(COULEUR_UI_BORD, 80);
  } else if (actif) {
    fill(lerpColor(COULEUR_UI_PANNEAU, mode.couleur, 0.15));
    stroke(mode.couleur);
  } else {
    fill(COULEUR_UI_PANNEAU);
    stroke(COULEUR_UI_BORD);
  }
  strokeWeight(actif ? 2 : 1);
  rect(0, 0, w, h, 8);

  // Lueur au hover
  if (actif && mode.disponible) {
    noFill();
    stroke(mode.couleur, 30);
    strokeWeight(4);
    rect(0, 0, w + 4, h + 4, 10);
  }

  // Bande couleur gauche
  noStroke();
  fill(mode.disponible ? mode.couleur : #444444);
  rectMode(CORNER);
  rect(-w/2 + 2, -h/2 + 2, 6, h - 4, 4, 0, 0, 4);

  // Nom
  color cNom = mode.disponible ? (actif ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM) : #555555;
  TexteGauche(mode.nom, -w/2 + 20, -10, 18, cNom);

  // Description
  color cDesc = mode.disponible ? COULEUR_UI_TEXTE_DIM : #444444;
  TexteGauche(mode.description, -w/2 + 20, 12, 12, cDesc);

  // Badge "Bientot"
  if (!mode.disponible) {
    float badgeX = w/2 - 55;
    fill(#333355);
    rectMode(CENTER);
    rect(badgeX, 0, 70, 22, 4);
    TexteCentre("BIENTOT", badgeX, 0, 11, COULEUR_UI_TEXTE_DIM);
  }

  // Flèche de sélection
  if (actif && mode.disponible) {
    fill(mode.couleur);
    noStroke();
    float ax = w/2 - 25;
    triangle(ax, -8, ax, 8, ax + 10, 0);
  }

  pop();
}

// --- Navigation ---

boolean modeStickActif = false;

void NaviguerModes(int dir) {
  if (modeStickActif) return;
  modeStickActif = true;
  modeSelectionne = constrain(modeSelectionne + dir, 0, tousLesModes.size() - 1);
  AutoScrollModes();
}

void AutoScrollModes() {
  // Garder la sélection visible
  float cardH = modeCardH();
  float gap = modeGap();
  float zoneTop = modeZoneTop();
  float zoneBot = modeZoneBot();

  // Trouver la position Y du mode sélectionné dans sa colonne
  ModeDeJeu sel = tousLesModes.get(modeSelectionne);
  ArrayList<Integer> colIdx = sel.categorie.equals("pvp") ? getIndicesPvp() : getIndicesPve();
  int posInCol = 0;
  for (int i = 0; i < colIdx.size(); i++) {
    if (colIdx.get(i) == modeSelectionne) { posInCol = i; break; }
  }

  float cardY = posInCol * (cardH + gap);
  float zoneH = zoneBot - zoneTop;

  if (cardY - modeScrollCible < 0) {
    modeScrollCible = cardY;
  }
  if (cardY + cardH - modeScrollCible > zoneH) {
    modeScrollCible = cardY + cardH - zoneH;
  }
  modeScrollCible = max(0, modeScrollCible);
}

void ValiderMode() {
  ModeDeJeu mode = tousLesModes.get(modeSelectionne);
  if (!mode.disponible) return;
  modeActuel = mode;
  ChangerEtat(Etat.MENU_CARTES);
}

void ScrollModes(float delta) {
  ArrayList<Integer> pveIdx = getIndicesPve();
  ArrayList<Integer> pvpIdx = getIndicesPvp();
  int maxItems = max(pveIdx.size(), pvpIdx.size());
  float contentH = maxItems * (modeCardH() + modeGap());
  float zoneH = modeZoneBot() - modeZoneTop();
  float maxScroll = max(0, contentH - zoneH);
  modeScrollCible = constrain(modeScrollCible + delta * 30, 0, maxScroll);
}

// --- Input ---

void Clavier_MenuModes(char k, int kc) {
  if (k == 'z' || (k == CODED && kc == UP)) {
    modeSelectionne = max(0, modeSelectionne - 1);
    AutoScrollModes();
  }
  if (k == 's' || (k == CODED && kc == DOWN)) {
    modeSelectionne = min(tousLesModes.size() - 1, modeSelectionne + 1);
    AutoScrollModes();
  }
  // Gauche/Droite : basculer entre colonnes PVE et PVP
  if (k == 'q' || (k == CODED && kc == LEFT)) {
    BasculerColonne("pve");
  }
  if (k == 'd' || (k == CODED && kc == RIGHT)) {
    BasculerColonne("pvp");
  }
  if (k == ENTER || k == RETURN || k == ' ') {
    ValiderMode();
  }
  if (k == BACKSPACE || kc == 27) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

void BasculerColonne(String cible) {
  ModeDeJeu actuel = tousLesModes.get(modeSelectionne);
  if (actuel.categorie.equals(cible)) return;

  // Trouver la position dans la colonne actuelle
  ArrayList<Integer> colActuelle = actuel.categorie.equals("pvp") ? getIndicesPvp() : getIndicesPve();
  int posInCol = 0;
  for (int i = 0; i < colActuelle.size(); i++) {
    if (colActuelle.get(i) == modeSelectionne) { posInCol = i; break; }
  }

  // Aller à la même position (ou la dernière) dans la colonne cible
  ArrayList<Integer> colCible = cible.equals("pvp") ? getIndicesPvp() : getIndicesPve();
  if (colCible.size() == 0) return;
  int pos = min(posInCol, colCible.size() - 1);
  modeSelectionne = colCible.get(pos);
  AutoScrollModes();
}

void Clic_MenuModes() {
  // Le hover dans AfficherCartMode met déjà à jour modeSelectionne
  // On vérifie si le clic est sur une carte (via les mêmes coordonnées que l'affichage)
  float cardW = modeCardW();
  float cardH = modeCardH();
  float gap = modeGap();
  float zoneTop = modeZoneTop();
  float colG = modeColGauche();
  float colD = modeColDroite();
  float startY = zoneTop + cardH/2 - modeScroll;

  ArrayList<Integer> pveIdx = getIndicesPve();
  ArrayList<Integer> pvpIdx = getIndicesPvp();

  // Vérifier clic sur carte PVE ou PVP
  for (int j = 0; j < pveIdx.size(); j++) {
    float y = startY + j * (cardH + gap);
    if (EstDansRect(colG, y, cardW, cardH)) { ValiderMode(); return; }
  }
  for (int j = 0; j < pvpIdx.size(); j++) {
    float y = startY + j * (cardH + gap);
    if (EstDansRect(colD, y, cardW, cardH)) { ValiderMode(); return; }
  }

  // Bouton retour
  if (bRetourModes == null) bRetourModes = new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 50, 250, 45);
  if (bRetourModes.SourisDessus()) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

boolean EstDansRect(float cx, float cy, float w, float h) {
  return sourisX > cx - w/2 && sourisX < cx + w/2 &&
         sourisY > cy - h/2 && sourisY < cy + h/2;
}
