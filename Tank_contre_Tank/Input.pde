// ============================================
// Input.pde - Événements clavier/souris
// ============================================

void keyPressed() {
  // Empêcher ESC de fermer le sketch
  if (key == ESC) key = 0;

  // Toggle debug
  if (keyCode == 112) DEBUG_MODE = !DEBUG_MODE; // F1

  // Déléguer à l'InputManager
  inputManager.OnKeyPressed(key, keyCode);

  // Actions selon l'état
  switch(etatActuel) {
    case MENU_PRINCIPAL:
      if (key == ENTER || key == RETURN || key == ' ') Valider_MenuActuel();
      if (key == CODED) {
        if (keyCode == UP) menuPrincipal.Haut();
        if (keyCode == DOWN) menuPrincipal.Bas();
      }
      if (key == 'z') menuPrincipal.Haut();
      if (key == 's') menuPrincipal.Bas();
      break;

    case MENU_CARTES:
      Clavier_MenuCartes(key, keyCode);
      break;

    case MENU_MANETTES:
      Clavier_MenuManettes(key, keyCode);
      break;

    case EN_JEU:
      if (key == 'p' || key == 'P') ChangerEtat(Etat.PAUSE);
      break;

    case PAUSE:
      if (key == 'p' || key == 'P') ChangerEtat(Etat.EN_JEU);
      if (keyCode == 27 || key == BACKSPACE) ChangerEtat(Etat.MENU_PRINCIPAL); // ESC
      break;

    case FIN_MANCHE:
      if (key == ' ' || key == ENTER) {
        partieActuelle.NouvelleManche();
        ChangerEtat(Etat.EN_JEU);
      }
      break;

    case FIN_PARTIE:
      if (key == ' ' || key == ENTER) {
        ChangerEtat(Etat.EN_JEU); // Rejouer
      }
      if (keyCode == 27 || key == BACKSPACE) {
        ChangerEtat(Etat.MENU_PRINCIPAL);
      }
      break;

    default:
      break;
  }
}

void keyReleased() {
  inputManager.OnKeyReleased(key, keyCode);
}

void mousePressed() {
  switch(etatActuel) {
    case MENU_PRINCIPAL:
      Clic_MenuPrincipal();
      break;
    case MENU_CARTES:
      Clic_MenuCartes();
      break;
    case MENU_MANETTES:
      Clic_MenuManettes();
      break;
    case EN_JEU:
      if (DEBUG_MODE) {
        placeMur.Reset();
        placeMur.lock = true;
      }
      break;
    default:
      break;
  }
}

void mouseReleased() {
  if (etatActuel == Etat.EN_JEU && DEBUG_MODE) {
    placeMur.Place();
    placeMur.lock = false;
  }
}
