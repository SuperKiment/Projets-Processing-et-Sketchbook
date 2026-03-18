// ============================================
// Cartes_Donnees.pde - Définitions des cartes
// Ajouter une nouvelle carte = ajouter une fonction ici
// ============================================

ArrayList<Carte> ToutesLesCartes = new ArrayList<Carte>();

void Setup_Cartes() {
  ToutesLesCartes.add(Carte_Arene());
  ToutesLesCartes.add(Carte_Labyrinthe());
  ToutesLesCartes.add(Carte_Forteresse());
  ToutesLesCartes.add(Carte_QuatreCoins());
  ToutesLesCartes.add(Carte_Couloirs());
  ToutesLesCartes.add(Carte_TestPickups());

  carteSelectionnee = ToutesLesCartes.get(0);
}

// --- Arène : simple avec obstacles centraux ---
Carte Carte_Arene() {
  Carte c = new Carte("Arene", "Arene ouverte avec obstacles centraux", 4);
  c.AjouterBordures(20);

  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 80, 80);
  c.AjouterMurDestructible(LARGEUR/2 - 150, HAUTEUR/2, 40, 120, 3);
  c.AjouterMurDestructible(LARGEUR/2 + 150, HAUTEUR/2, 40, 120, 3);

  c.AjouterSpawn(100, 100, PI/4);
  c.AjouterSpawn(LARGEUR - 100, 100, 3*PI/4);
  c.AjouterSpawn(100, HAUTEUR - 100, -PI/4);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR - 100, -3*PI/4);

  // Pickups
  c.AjouterPickup(LARGEUR/2, 150, "mun_rapide");
  c.AjouterPickup(LARGEUR/2, HAUTEUR - 150, "mun_explosif");
  c.AjouterPickup(LARGEUR/4, HAUTEUR/2, "sante");
  c.AjouterPickup(LARGEUR * 3/4, HAUTEUR/2, "boost_vitesse");

  return c;
}

// --- Labyrinthe : couloirs étroits ---
Carte Carte_Labyrinthe() {
  Carte c = new Carte("Labyrinthe", "Couloirs etroits et angles morts", 4);
  c.AjouterBordures(20);

  c.AjouterMur(200, 180, 300, 20);
  c.AjouterMur(700, 180, 400, 20);
  c.AjouterMur(350, 360, 500, 20);
  c.AjouterMur(750, 540, 300, 20);
  c.AjouterMur(300, 540, 400, 20);

  c.AjouterMurDestructible(400, 270, 20, 200, 3);
  c.AjouterMur(700, 450, 20, 200);
  c.AjouterMurDestructible(200, 450, 20, 200, 3);
  c.AjouterMur(900, 300, 20, 250);

  c.AjouterSpawn(80, 80, 0);
  c.AjouterSpawn(LARGEUR - 80, HAUTEUR - 80, PI);
  c.AjouterSpawn(LARGEUR - 80, 80, PI);
  c.AjouterSpawn(80, HAUTEUR - 80, 0);

  // Pickups dans les intersections
  c.AjouterPickup(550, 270, "mun_bouncy");
  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_explosif");
  c.AjouterPickup(150, 270, "sante");
  c.AjouterPickup(850, 450, "sante");
  c.AjouterPickup(550, 630, "boost_vitesse");

  return c;
}

// --- Forteresse : deux camps retranchés ---
Carte Carte_Forteresse() {
  Carte c = new Carte("Forteresse", "Deux forteresses face a face", 4);
  c.AjouterBordures(20);

  c.AjouterMur(180, HAUTEUR/2, 20, 200);
  c.AjouterMur(100, HAUTEUR/2 - 100, 140, 20);
  c.AjouterMur(100, HAUTEUR/2 + 100, 140, 20);

  c.AjouterMur(LARGEUR - 180, HAUTEUR/2, 20, 200);
  c.AjouterMur(LARGEUR - 100, HAUTEUR/2 - 100, 140, 20);
  c.AjouterMur(LARGEUR - 100, HAUTEUR/2 + 100, 140, 20);

  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2 - 120, 60, 60, 4);
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2 + 120, 60, 60, 4);
  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 30, 30);

  c.AjouterSpawn(100, HAUTEUR/2 - 40, 0);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR/2 + 40, PI);
  c.AjouterSpawn(100, HAUTEUR/2 + 40, 0);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR/2 - 40, PI);

  // Pickups au centre (zone dangereuse = récompense)
  c.AjouterPickup(LARGEUR/2, HAUTEUR/2 - 60, "mun_rapide");
  c.AjouterPickup(LARGEUR/2, HAUTEUR/2 + 60, "mun_explosif");
  c.AjouterPickup(LARGEUR/2 - 250, HAUTEUR/2, "sante");
  c.AjouterPickup(LARGEUR/2 + 250, HAUTEUR/2, "mun_mur");

  return c;
}

// --- Quatre Coins : action au centre ---
Carte Carte_QuatreCoins() {
  Carte c = new Carte("Quatre Coins", "Abris dans les coins, combat au centre", 4);
  c.AjouterBordures(20);

  float offset = 150;
  float mTaille = 100;
  c.AjouterMur(offset, offset + 40, mTaille, 20);
  c.AjouterMur(offset + 40, offset, 20, mTaille);
  c.AjouterMur(LARGEUR - offset, offset + 40, mTaille, 20);
  c.AjouterMur(LARGEUR - offset - 40, offset, 20, mTaille);
  c.AjouterMur(offset, HAUTEUR - offset - 40, mTaille, 20);
  c.AjouterMur(offset + 40, HAUTEUR - offset, 20, mTaille);
  c.AjouterMur(LARGEUR - offset, HAUTEUR - offset - 40, mTaille, 20);
  c.AjouterMur(LARGEUR - offset - 40, HAUTEUR - offset, 20, mTaille);

  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 50, 50);

  c.AjouterSpawn(100, 100, PI/4);
  c.AjouterSpawn(LARGEUR - 100, 100, 3*PI/4);
  c.AjouterSpawn(100, HAUTEUR - 100, -PI/4);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR - 100, -3*PI/4);

  // Pickup central très convoité
  c.AjouterPickup(LARGEUR/2, HAUTEUR/2 - 80, "mun_explosif");
  c.AjouterPickup(LARGEUR/2 - 200, HAUTEUR/2, "mun_mur");
  c.AjouterPickup(LARGEUR/2 + 200, HAUTEUR/2, "mun_rapide");
  c.AjouterPickup(LARGEUR/2, HAUTEUR/2 + 80, "boost_vitesse");

  return c;
}

// --- Test Pickups : tous les pickups alignés ---
Carte Carte_TestPickups() {
  Carte c = new Carte("Test Pickups", "Tous les pickups et munitions", 4);
  c.AjouterBordures(20);

  c.AjouterSpawn(100, HAUTEUR/2 - 80, 0);
  c.AjouterSpawn(100, HAUTEUR/2 + 80, 0);
  c.AjouterSpawn(100, HAUTEUR/2 - 200, 0);
  c.AjouterSpawn(100, HAUTEUR/2 + 200, 0);

  // Rangée du haut : munitions (y = 150)
  String[] munitions = {
    "mun_rapide", "mun_explosif", "mun_bouncy", "mun_mur", "mun_missile",
    "mun_grenade", "mun_mine", "mun_laser", "mun_shotgun", "mun_cluster",
    "mun_boomerang", "mun_emp", "mun_incendiaire", "mun_ricochet"
  };
  float startX = 200;
  float espacement = (LARGEUR - 250 - startX) / (munitions.length - 1);
  for (int i = 0; i < munitions.length; i++) {
    c.AjouterPickup(startX + i * espacement, 150, munitions[i]);
  }

  // Rangée du bas : boosts + santé (y = 550)
  String[] boosts = {
    "sante", "boost_vitesse", "boost_defense", "boost_cadence",
    "boost_invisible", "boost_degats", "boost_aimant"
  };
  float espacementB = (LARGEUR - 250 - startX) / (boosts.length - 1);
  for (int i = 0; i < boosts.length; i++) {
    c.AjouterPickup(startX + i * espacementB, 550, boosts[i]);
  }

  // Murs destructibles pour tester
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2, 80, 20, 3);
  c.AjouterMurDestructible(LARGEUR/2 - 200, HAUTEUR/2, 40, 80, 2);
  c.AjouterMurDestructible(LARGEUR/2 + 200, HAUTEUR/2, 40, 80, 2);

  return c;
}

// --- Couloirs : lignes parallèles ---
Carte Carte_Couloirs() {
  Carte c = new Carte("Couloirs", "Couloirs paralleles avec ouvertures", 4);
  c.AjouterBordures(20);

  float[] yPositions = { HAUTEUR * 0.25, HAUTEUR * 0.5, HAUTEUR * 0.75 };
  float murLarg = 350;

  for (float yPos : yPositions) {
    c.AjouterMur(murLarg/2 + 20, yPos, murLarg, 20);
    c.AjouterMur(LARGEUR - murLarg/2 - 20, yPos, murLarg, 20);
  }

  c.AjouterMur(LARGEUR/2, HAUTEUR * 0.15, 20, 80);
  c.AjouterMur(LARGEUR/2, HAUTEUR * 0.85, 20, 80);

  c.AjouterSpawn(LARGEUR/2 - 100, 60, PI/2);
  c.AjouterSpawn(LARGEUR/2 + 100, HAUTEUR - 60, -PI/2);
  c.AjouterSpawn(60, HAUTEUR/2, 0);
  c.AjouterSpawn(LARGEUR - 60, HAUTEUR/2, PI);

  // Pickups dans les trous des murs
  c.AjouterPickup(LARGEUR/2, HAUTEUR * 0.25, "mun_rapide");
  c.AjouterPickup(LARGEUR/2, HAUTEUR * 0.5, "mun_explosif");
  c.AjouterPickup(LARGEUR/2, HAUTEUR * 0.75, "mun_bouncy");
  c.AjouterPickup(LARGEUR/4, HAUTEUR * 0.4, "sante");
  c.AjouterPickup(LARGEUR * 3/4, HAUTEUR * 0.6, "boost_vitesse");

  return c;
}
