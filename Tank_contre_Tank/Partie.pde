// ============================================
// Partie.pde - Gestion de la partie en cours
// ============================================

Partie partieActuelle;
float timerFinManche = 0;

class Partie {
  Carte carte;
  int nbJoueurs;
  int[] scores;
  int manche = 0;
  int dernierGagnant = -1;
  boolean partieTerminee = false;

  Partie(Carte c, int nj) {
    carte = c;
    nbJoueurs = nj;
    scores = new int[nj];
  }

  void Demarrer() {
    NouvelleManche();
  }

  void NouvelleManche() {
    manche++;
    carte.Charger(); // recharge murs + pickups fixes
    AllTanks.clear();
    AllMunitions.clear();
    AllParticules.clear();
    AllZonesFeu.clear();
    AllTextesFlottants.clear();

    // 2 pickups aléatoires
    SpawnerPickupsAleatoires(2);

    for (int i = 0; i < nbJoueurs; i++) {
      PointSpawn sp = carte.spawns.get(i % carte.spawns.size());
      TypeTank type = TypesTanks.get("Normal");
      PlayerInput pi = inputManager.GetJoueur(i);

      Tank t = new Tank(i, type, sp.x, sp.y, sp.dir, pi);
      t.couleur = COULEURS_JOUEURS[i];
      AllTanks.add(t);
    }
  }

  void Fonctions() {
    inputManager.MettreAJour();

    // Pause manette (Start)
    for (int i = 0; i < nbJoueurs; i++) {
      if (inputManager.GetJoueur(i).pause) {
        ChangerEtat(Etat.PAUSE);
        return;
      }
    }

    Dessiner_OmbresMurs();
    Fonctions_Murs();

    for (int i = AllTanks.size() - 1; i >= 0; i--) {
      Tank tank = AllTanks.get(i);
      tank.Fonctions();
    }

    Fonctions_Munitions();
    Fonctions_ZonesFeu();
    Fonctions_Pickups();
    ParticuleFonctions();
    Fonctions_TextesFlottants();

    Dessiner_Eclairage();
    Appliquer_Vignette();

    if (DEBUG_MODE) {
      placeMur.Fonctions();
    }

    Afficher_HUD();
    VerifierFinManche();
  }

  void VerifierFinManche() {
    int vivantsCount = 0;
    int dernierVivant = -1;

    for (int i = 0; i < AllTanks.size(); i++) {
      if (AllTanks.get(i).vivant) {
        vivantsCount++;
        dernierVivant = i;
      }
    }

    if (vivantsCount <= 1 && AllTanks.size() > 1) {
      if (dernierVivant >= 0) {
        scores[dernierVivant]++;
        dernierGagnant = dernierVivant;
      } else {
        dernierGagnant = -1; // égalité
      }

      // Vérifier victoire totale
      for (int i = 0; i < nbJoueurs; i++) {
        if (scores[i] >= SCORE_VICTOIRE) {
          partieTerminee = true;
          ChangerEtat(Etat.FIN_PARTIE);
          return;
        }
      }

      ChangerEtat(Etat.FIN_MANCHE);
    }
  }
}

void LancerPartie() {
  int nbJoueurs = CompterJoueursActifs();
  if (nbJoueurs < 2) nbJoueurs = 2; // Minimum 2 joueurs

  partieActuelle = new Partie(carteSelectionnee, nbJoueurs);
  partieActuelle.Demarrer();
}

void Fonctions_Partie() {
  if (partieActuelle != null) {
    partieActuelle.Fonctions();
  }
}
