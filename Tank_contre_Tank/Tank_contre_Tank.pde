// ============================================
// Tank_contre_Tank.pde - Point d'entrée
// ============================================

void setup() {
  size(1080, 720, P2D);
  noStroke();
  rectMode(CENTER);

  Setup_TypesTanks();
  Setup_TypesMunitions();
  Setup_TypesPickups();
  Setup_Cartes();
  Setup_InputManager();
  Setup_Eclairage();
  Setup_MenuPrincipal();
}

void draw() {
  switch(etatActuel) {
    case MENU_PRINCIPAL:
      Afficher_MenuPrincipal();
      break;
    case MENU_MANETTES:
      Afficher_MenuManettes();
      break;
    case MENU_CARTES:
      Afficher_MenuCartes();
      break;
    case EN_JEU:
      background(COULEUR_FOND_JEU);
      Fonctions_Partie();
      break;
    case PAUSE:
      background(COULEUR_FOND_JEU);
      Fonctions_Partie_Gelee();
      Afficher_Pause();
      break;
    case FIN_MANCHE:
      Afficher_FinManche();
      break;
    case FIN_PARTIE:
      Afficher_FinPartie();
      break;
  }

  inputManager.FinFrame();
}

void Fonctions_Partie_Gelee() {
  Dessiner_OmbresMurs();
  Fonctions_Murs();
  for (Tank t : AllTanks) {
    t.Affichage();
  }
  for (Munition m : AllMunitions) {
    m.AffichageSeul();
  }
  for (Pickup p : AllPickups) {
    if (p.actif) p.Affichage();
  }
  ParticuleFonctions();
  Fonctions_TextesFlottants();
  Dessiner_Eclairage();
  Appliquer_Vignette();
  Afficher_HUD();
}
