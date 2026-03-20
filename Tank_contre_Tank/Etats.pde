// ============================================
// Etats.pde - Machine à états du jeu
// ============================================

enum Etat {
  MENU_PRINCIPAL,
  MENU_MODES,
  MENU_MANETTES,
  MENU_CARTES,
  MENU_TANKS,
  MENU_COMMANDES,
  MENU_PARAMETRES,
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
    case MENU_MODES:
      cursor();
      break;
    case MENU_CARTES:
      Setup_MenuCartes();
      break;
    case MENU_MANETTES:
      Setup_MenuManettes();
      break;
    case MENU_TANKS:
      Setup_MenuTanks();
      break;
    case MENU_COMMANDES:
      cursor();
      break;
    case MENU_PARAMETRES:
      cursor();
      break;
    case EN_JEU:
      if (etatPrecedent != Etat.PAUSE && etatPrecedent != Etat.FIN_MANCHE) {
        LancerPartie();
      }
      if (random(0, 10) < 9) {
        JouerSon("manche_debut");
      } else {
        JouerSon("manche_debut_alt");
      }
      noCursor();
      break;
    case PAUSE:
      cursor();
      break;
    case FIN_MANCHE:
      cursor();
      timerFinManche = millis();
      JouerSon("manche_fin");
      break;
    case FIN_PARTIE:
      cursor();
      JouerSon("victoire");
      break;
    default:
      break;
  }
}
