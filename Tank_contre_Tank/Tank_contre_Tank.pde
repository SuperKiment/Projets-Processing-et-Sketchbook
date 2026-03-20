// ============================================
// Tank_contre_Tank.pde - Point d'entrée
// ============================================

void setup() {
  size(1080, 720, P2D);
  surface.setResizable(true);
  noStroke();
  rectMode(CENTER);

  Setup_TypesTanks();
  Setup_TypesMunitions();
  Setup_TypesPickups();
  Setup_Cartes();
  Setup_InputManager();
  Setup_Eclairage();
  Setup_Traces();
  Setup_Sons();
  Setup_MenuPrincipal();
}

void draw() {
  background(0); // Bandes letterbox noires

  push();
  AppliquerEchelle();

  switch(etatActuel) {
    case MENU_PRINCIPAL:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_MenuPrincipal();
      break;
    case MENU_MANETTES:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_MenuManettes();
      break;
    case MENU_CARTES:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_MenuCartes();
      break;
    case MENU_TANKS:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_MenuTanks();
      break;
    case MENU_COMMANDES:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_MenuCommandes();
      break;
    case MENU_PARAMETRES:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_MenuParametres();
      break;
    case EN_JEU:
      FondEcran(CouleurFondJeu());
      Fonctions_Partie();
      break;
    case PAUSE:
      FondEcran(CouleurFondJeu());
      Fonctions_Partie_Gelee();
      Afficher_Pause();
      break;
    case FIN_MANCHE:
      Afficher_FinManche();
      break;
    case FIN_PARTIE:
      FondEcran(COULEUR_FOND_MENU);
      Afficher_FinPartie();
      break;
  }

  pop();
  inputManager.FinFrame();
}

color CouleurFondJeu() {
  if (carteSelectionnee != null) return carteSelectionnee.FondActif();
  return COULEUR_FOND_JEU;
}

void FondEcran(color c) {
  push();
  fill(c);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, LARGEUR, HAUTEUR);
  pop();
}

void Fonctions_Partie_Gelee() {
  Dessiner_Traces();
  Dessiner_Terrains();
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
  Appliquer_PostProcess();
  Afficher_HUD();
  Afficher_LabelPostProcess();
}
/*
Bug : quand j'ajoute une manette, puis la retire et la remets, elle passe de J3 à J4, elle devrait se remettre à J3.
*/
