// ============================================
// Menu.pde - Menu principal
// ============================================

SelecteurMenu menuPrincipal;
boolean menuSetup = false;

void Setup_MenuPrincipal() {
  menuPrincipal = new SelecteurMenu();

  float cx = LARGEUR / 2;
  menuPrincipal.AjouterBouton(new Bouton("JOUER", cx, 300, 300, 55));
  menuPrincipal.AjouterBouton(new Bouton("MANETTES", cx, 370, 300, 55));
  menuPrincipal.AjouterBouton(new Bouton("COMMANDES", cx, 440, 300, 55));
  menuPrincipal.AjouterBouton(new Bouton("PARAMETRES", cx, 510, 300, 55));

  menuSetup = true;
}

void Afficher_MenuPrincipal() {
  if (!menuSetup) Setup_MenuPrincipal();

  // Titre
  TexteCentre("TANK CONTRE TANK", LARGEUR/2, 130, 52, COULEUR_UI_TEXTE);
  TexteCentre("Combat local multijoueur", LARGEUR/2, 190, 18, COULEUR_UI_TEXTE_DIM);

  // Dessin décoratif
  push();
  translate(LARGEUR/2, 250);
  fill(COULEUR_UI_ACCENT);
  noStroke();
  rectMode(CENTER);
  rect(0, 0, 30, 30);
  rect(22, 0, 30, 10);
  pop();

  // Boutons
  menuPrincipal.MettreAJour();
  menuPrincipal.Affichage();

  // Info en bas
  TexteCentre("Joueurs connectes: " + CompterJoueursActifs(), LARGEUR/2, HAUTEUR - 80, 16, COULEUR_UI_TEXTE_DIM);
  TexteCentre("F1 = Debug", LARGEUR/2, HAUTEUR - 50, 14, COULEUR_UI_TEXTE_DIM);

  // Navigation manettes dans le menu
  for (ManetteNative m : manettesDetectees) {
    if (m.connectee) {
      menuPrincipal.NavigationAnalog(m.axes[1]);
    }
  }
}

void Clic_MenuPrincipal() {
  if (menuPrincipal == null) return;

  for (int i = 0; i < menuPrincipal.elements.size(); i++) {
    Bouton b = menuPrincipal.elements.get(i);
    if (b.SourisDessus() || (b.selectionne && menuValiderPresse)) {
      if (i == 0) ChangerEtat(Etat.MENU_MODES);
      if (i == 1) ChangerEtat(Etat.MENU_MANETTES);
      if (i == 2) ChangerEtat(Etat.MENU_COMMANDES);
      if (i == 3) ChangerEtat(Etat.MENU_PARAMETRES);
    }
  }
}

boolean menuValiderPresse = false;

void Valider_MenuActuel() {
  menuValiderPresse = true;
  switch(etatActuel) {
    case MENU_PRINCIPAL:
      Clic_MenuPrincipal();
      break;
    case MENU_MODES:
      Clic_MenuModes();
      break;
    case MENU_CARTES:
      Clic_MenuCartes();
      break;
    case MENU_MANETTES:
      Clic_MenuManettes();
      break;
    case MENU_TANKS:
      Clic_MenuTanks();
      break;
    default:
      break;
  }
  menuValiderPresse = false;
}

int CompterJoueursActifs() {
  int count = 0;
  for (int i = 0; i < MAX_JOUEURS; i++) {
    if (inputManager.JoueurActif(i)) count++;
  }
  return count;
}
