// ============================================
// Etats.pde - Machine à états du jeu
// ============================================

enum Etat {
  MENU_PRINCIPAL,
  MENU_MANETTES,
  MENU_CARTES,
  EN_JEU,
  PAUSE,
  FIN_MANCHE,
  FIN_PARTIE
}

Etat etatActuel = Etat.MENU_PRINCIPAL;
Etat etatPrecedent = Etat.MENU_PRINCIPAL;

void ChangerEtat(Etat nouvel) {
  etatPrecedent = etatActuel;
  etatActuel = nouvel;
  SurEntreeEtat(nouvel);
}

void SurEntreeEtat(Etat e) {
  switch(e) {
    case MENU_PRINCIPAL:
      cursor();
      break;
    case MENU_CARTES:
      Setup_MenuCartes();
      break;
    case MENU_MANETTES:
      Setup_MenuManettes();
      break;
    case EN_JEU:
      if (etatPrecedent != Etat.PAUSE) {
        LancerPartie();
      }
      noCursor();
      break;
    case PAUSE:
      cursor();
      break;
    case FIN_MANCHE:
      cursor();
      timerFinManche = millis();
      break;
    case FIN_PARTIE:
      cursor();
      break;
    default:
      break;
  }
}
