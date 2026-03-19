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

    // Jour/nuit aléatoire
    if (paramJourNuitAleatoire) {
      modeJour = random(1) > 0.5;
    } else {
      modeJour = false; // toujours nuit par défaut
    }

    // Changement de couleurs aléatoire entre manches
    if (paramCouleursAleatoires) {
      int idx = (int)random(PALETTES_COULEURS.length);
      carte.couleurFond = PALETTES_COULEURS[idx][0];
      carte.couleurMur = PALETTES_COULEURS[idx][1];
      carte.couleurFondJour = PALETTES_COULEURS[idx][2];
      carte.couleurMurJour = PALETTES_COULEURS[idx][3];
    } else {
      carte.RestaureTheme();
    }

    carte.Charger(); // recharge murs + pickups fixes
    AllTanks.clear();
    AllMunitions.clear();
    AllParticules.clear();
    AllZonesFeu.clear();
    AllZonesFumee.clear();
    AllTourelles.clear();
    AllTextesFlottants.clear();
    AllFlashs.clear();

    // Terrains (persistent entre manches, placés qu'à la première manche)
    if (manche == 1) {
      AllTerrains.clear();
      SpawnerTerrainsAleatoires(6);
    }

    // 2 pickups aléatoires
    SpawnerPickupsAleatoires(2);

    for (int i = 0; i < nbJoueurs; i++) {
      PointSpawn sp = carte.spawns.get(i % carte.spawns.size());
      String nomTank = tankChoisiParJoueur[i];
      TypeTank type = TypesTanks.get(nomTank);
      if (type == null) type = TypesTanks.get("Sentinelle");
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

    Dessiner_Traces();
    Dessiner_Terrains();
    Dessiner_OmbresMurs();
    Fonctions_Murs();

    for (int i = AllTanks.size() - 1; i >= 0; i--) {
      Tank tank = AllTanks.get(i);
      tank.Fonctions();
    }

    Fonctions_Munitions();
    Fonctions_ZonesFeu();
    Fonctions_ZonesFumee();
    Fonctions_Tourelles();
    Fonctions_Terrains();
    Fonctions_Pickups();
    ParticuleFonctions();
    Fonctions_TextesFlottants();

    Dessiner_Eclairage();
    Appliquer_PostProcess();

    if (DEBUG_MODE) {
      placeMur.Fonctions();
    }

    Afficher_HUD();
    Afficher_LabelPostProcess();
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

  EffacerTraces();
  AllTerrains.clear();
  partieActuelle = new Partie(carteSelectionnee, nbJoueurs);
  partieActuelle.Demarrer();
}

void Fonctions_Partie() {
  if (partieActuelle != null) {
    partieActuelle.Fonctions();
  }
}
