// ============================================
// Menu_Commandes.pde - Page de commandes
// ============================================

Bouton bRetourCmd;

void Afficher_MenuCommandes() {
  TexteCentre("COMMANDES", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  float colG = LARGEUR * 0.28;
  float colD = LARGEUR * 0.72;

  // === CLAVIER JOUEUR 1 ===
  float y = 90;
  TexteCentre("CLAVIER - Joueur 1", colG, y, 20, COULEURS_JOUEURS[0]);
  y += 30;
  AfficherLigneCommande(colG, y, "Avancer", "Z"); y += 22;
  AfficherLigneCommande(colG, y, "Reculer", "S"); y += 22;
  AfficherLigneCommande(colG, y, "Gauche", "Q"); y += 22;
  AfficherLigneCommande(colG, y, "Droite", "D"); y += 22;
  AfficherLigneCommande(colG, y, "Tir", "C"); y += 22;
  AfficherLigneCommande(colG, y, "Special", "V"); y += 22;

  // === CLAVIER JOUEUR 2 ===
  y += 15;
  TexteCentre("CLAVIER - Joueur 2", colG, y, 20, COULEURS_JOUEURS[1]);
  y += 30;
  AfficherLigneCommande(colG, y, "Avancer", "Fleche Haut"); y += 22;
  AfficherLigneCommande(colG, y, "Reculer", "Fleche Bas"); y += 22;
  AfficherLigneCommande(colG, y, "Gauche", "Fleche Gauche"); y += 22;
  AfficherLigneCommande(colG, y, "Droite", "Fleche Droite"); y += 22;
  AfficherLigneCommande(colG, y, "Tir", "Entree"); y += 22;
  AfficherLigneCommande(colG, y, "Special", "Shift"); y += 22;

  // === MANETTE ===
  y = 90;
  TexteCentre("MANETTE (Xbox)", colD, y, 20, COULEUR_UI_TEXTE);
  y += 30;
  AfficherLigneCommande(colD, y, "Deplacement", "Stick G / D-Pad"); y += 22;
  AfficherLigneCommande(colD, y, "Tir", "A / RB / RT"); y += 22;
  AfficherLigneCommande(colD, y, "Special", "B / LB / LT"); y += 22;
  AfficherLigneCommande(colD, y, "Pause", "Start"); y += 22;

  // === GLOBAL ===
  y += 25;
  TexteCentre("GLOBAL", colD, y, 20, COULEUR_UI_TEXTE);
  y += 30;
  AfficherLigneCommande(colD, y, "Pause", "P"); y += 22;
  AfficherLigneCommande(colD, y, "Filtre visuel", "TAB"); y += 22;
  AfficherLigneCommande(colD, y, "Debug", "F1"); y += 22;

  // === TYPES DE TANKS ===
  y += 25;
  TexteCentre("TANKS & SPECIALS", colD, y, 20, COULEUR_UI_ACCENT);
  y += 28;
  for (String nom : ListeNomsTanks) {
    TypeTank tt = TypesTanks.get(nom);
    TexteGauche(tt.nom, colD - 130, y, 14, COULEUR_UI_TEXTE);
    TexteGauche(tt.specialNom + " - " + tt.specialDesc, colD - 40, y, 12, COULEUR_UI_TEXTE_DIM);
    y += 20;
  }

  // === RETOUR ===
  if (bRetourCmd == null) bRetourCmd = new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 50, 250, 45);
  bRetourCmd.Affichage();
}

void AfficherLigneCommande(float cx, float y, String action, String touche) {
  float demi = 120;
  TexteGauche(action, cx - demi, y, 14, COULEUR_UI_TEXTE_DIM);

  // Touche dans un cadre
  push();
  rectMode(CENTER);
  float tw = textWidth(touche) + 16;
  float th = 18;
  fill(COULEUR_UI_PANNEAU);
  stroke(COULEUR_UI_BORD);
  strokeWeight(1);
  rect(cx + demi - 20, y, max(tw, 40), th, 4);
  fill(COULEUR_UI_TEXTE);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(12);
  text(touche, cx + demi - 20, y - 1);
  pop();
}

void Clavier_MenuCommandes(char k, int kc) {
  if (k == BACKSPACE || kc == 27) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

void Clic_MenuCommandes() {
  if (bRetourCmd == null) bRetourCmd = new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 50, 250, 45);
  if (bRetourCmd.SourisDessus()) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}
