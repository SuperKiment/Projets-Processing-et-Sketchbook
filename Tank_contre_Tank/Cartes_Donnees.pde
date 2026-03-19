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
  ToutesLesCartes.add(Carte_Spirale());
  ToutesLesCartes.add(Carte_Colisee());
  ToutesLesCartes.add(Carte_Damier());
  ToutesLesCartes.add(Carte_Pont());
  ToutesLesCartes.add(Carte_Bunker());
  ToutesLesCartes.add(Carte_Croix());
  ToutesLesCartes.add(Carte_Archipel());
  ToutesLesCartes.add(Carte_Usine());
  ToutesLesCartes.add(Carte_Temple());
  ToutesLesCartes.add(Carte_Chaos());

  carteSelectionnee = ToutesLesCartes.get(0);
}

// --- Arène : simple avec obstacles centraux ---
Carte Carte_Arene() {
  Carte c = new Carte("Arene", "Arene ouverte avec obstacles centraux", 4);
  c.SetTheme(#0A0A14, #707088); // Nuit urbaine : fond sombre bleuté, murs gris-bleu
  c.SetThemeJour(#B8B0A0, #5A5A6E); // Jour : béton clair, murs gris foncé
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
  c.SetTheme(#0D1117, #3B5998); // Bunker : fond noir profond, murs bleu acier
  c.SetThemeJour(#A0A8B0, #4A5A7A); // Jour : sol béton bleuté, murs acier
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
  c.SetTheme(#0B1A0B, #556B2F); // Militaire : fond vert très sombre, murs olive
  c.SetThemeJour(#7A9A5A, #4A5A30); // Jour : herbe verte, murs kaki
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
  c.SetTheme(#1A1408, #A0522D); // Désert : fond sable sombre, murs terre rouge
  c.SetThemeJour(#D4C4A0, #8B5E3C); // Jour : sable chaud, murs terre cuite
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
  c.SetTheme(#000000, #969696); // Classique : noir et gris
  c.SetThemeJour(#C0C0C0, #606060); // Jour : gris clair, murs gris foncé
  c.AjouterBordures(20);

  c.AjouterSpawn(100, HAUTEUR/2 - 80, 0);
  c.AjouterSpawn(100, HAUTEUR/2 + 80, 0);
  c.AjouterSpawn(100, HAUTEUR/2 - 200, 0);
  c.AjouterSpawn(100, HAUTEUR/2 + 200, 0);

  // Rangée du haut : munitions (y = 150)
  String[] munitions = {
    "mun_rapide", "mun_explosif", "mun_bouncy", "mun_mur", "mun_missile",
    "mun_grenade", "mun_mine", "mun_laser", "mun_shotgun", "mun_cluster",
    "mun_boomerang", "mun_emp", "mun_incendiaire", "mun_ricochet",
    "mun_plasma", "mun_teleporteur", "mun_aspirante", "mun_meteore",
    "mun_chaine", "mun_forage", "mun_miroir", "mun_fumigene"
  };
  float startX = 200;
  float espacement = (LARGEUR - 250 - startX) / (munitions.length - 1);
  for (int i = 0; i < munitions.length; i++) {
    c.AjouterPickup(startX + i * espacement, 150, munitions[i]);
  }

  // Rangée du bas : boosts + santé (y = 550)
  String[] boosts = {
    "sante", "boost_vitesse", "boost_defense", "boost_cadence",
    "boost_invisible", "boost_degats", "boost_aimant",
    "boost_vampirique", "boost_gigantisme", "boost_miniature",
    "boost_fantome", "boost_magnetique"
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
  c.SetTheme(#120A18, #8B668B); // Néon : fond violet sombre, murs lavande
  c.SetThemeJour(#C0B0C8, #6A5A7A); // Jour : sol lavande clair, murs violet
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

// --- Spirale : murs en spirale vers le centre ---
Carte Carte_Spirale() {
  Carte c = new Carte("Spirale", "Spirale vers le centre", 4);
  c.SetTheme(#0A0A1A, #6666AA);
  c.SetThemeJour(#B0B0D0, #5555AA);
  c.AjouterBordures(20);

  // Bras de spirale
  c.AjouterMur(300, 180, 400, 20);
  c.AjouterMur(780, 180, 20, 200);
  c.AjouterMur(600, 360, 380, 20);
  c.AjouterMur(300, 360, 20, 200);
  c.AjouterMur(480, 540, 380, 20);
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2, 60, 20, 3);

  c.AjouterSpawn(80, 80, PI/4);
  c.AjouterSpawn(LARGEUR - 80, 80, 3*PI/4);
  c.AjouterSpawn(80, HAUTEUR - 80, -PI/4);
  c.AjouterSpawn(LARGEUR - 80, HAUTEUR - 80, -3*PI/4);

  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_plasma");
  c.AjouterPickup(200, 270, "mun_aspirante");
  c.AjouterPickup(LARGEUR - 200, 450, "sante");
  c.AjouterPickup(LARGEUR/2, 270, "boost_vitesse");

  return c;
}

// --- Colisée : arène circulaire avec piliers ---
Carte Carte_Colisee() {
  Carte c = new Carte("Colisee", "Arene ronde avec piliers", 4);
  c.SetTheme(#1A1000, #C8A060);
  c.SetThemeJour(#D8C8A0, #A08050);
  c.AjouterBordures(20);

  // Piliers circulaires (simulés par petits carrés)
  float cx = LARGEUR / 2;
  float cy = HAUTEUR / 2;
  float rayon = 220;
  for (int i = 0; i < 8; i++) {
    float a = TWO_PI * i / 8;
    c.AjouterMur(cx + cos(a) * rayon, cy + sin(a) * rayon, 30, 30);
  }
  // Pilier central
  c.AjouterMurDestructible(cx, cy, 40, 40, 4);
  // Petits piliers internes
  for (int i = 0; i < 4; i++) {
    float a = TWO_PI * i / 4 + PI/4;
    c.AjouterMurDestructible(cx + cos(a) * 120, cy + sin(a) * 120, 25, 25, 2);
  }

  c.AjouterSpawn(100, 100, PI/4);
  c.AjouterSpawn(LARGEUR - 100, 100, 3*PI/4);
  c.AjouterSpawn(100, HAUTEUR - 100, -PI/4);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR - 100, -3*PI/4);

  c.AjouterPickup(cx, cy - 150, "mun_shotgun");
  c.AjouterPickup(cx, cy + 150, "mun_meteore");
  c.AjouterPickup(cx - 250, cy, "sante");
  c.AjouterPickup(cx + 250, cy, "boost_degats");

  return c;
}

// --- Damier : grille de petits murs ---
Carte Carte_Damier() {
  Carte c = new Carte("Damier", "Grille de piliers reguliers", 4);
  c.SetTheme(#101010, #808080);
  c.SetThemeJour(#C0C0B0, #606050);
  c.AjouterBordures(20);

  // Grille 5x3 de piliers
  for (int gx = 0; gx < 5; gx++) {
    for (int gy = 0; gy < 3; gy++) {
      float mx = 180 + gx * 180;
      float my = 180 + gy * 180;
      if ((gx + gy) % 2 == 0) {
        c.AjouterMur(mx, my, 40, 40);
      } else {
        c.AjouterMurDestructible(mx, my, 35, 35, 2);
      }
    }
  }

  c.AjouterSpawn(80, 80, PI/4);
  c.AjouterSpawn(LARGEUR - 80, 80, 3*PI/4);
  c.AjouterSpawn(80, HAUTEUR - 80, -PI/4);
  c.AjouterSpawn(LARGEUR - 80, HAUTEUR - 80, -3*PI/4);

  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_ricochet");
  c.AjouterPickup(LARGEUR/4, HAUTEUR/4, "mun_bouncy");
  c.AjouterPickup(LARGEUR*3/4, HAUTEUR*3/4, "boost_fantome");
  c.AjouterPickup(LARGEUR*3/4, HAUTEUR/4, "sante");

  return c;
}

// --- Pont : deux zones reliées par un passage étroit ---
Carte Carte_Pont() {
  Carte c = new Carte("Pont", "Deux zones reliees par un pont etroit", 4);
  c.SetTheme(#0A1A0A, #446644);
  c.SetThemeJour(#90B080, #4A6A3A);
  c.AjouterBordures(20);

  // Mur horizontal avec ouverture au centre
  c.AjouterMur(250, HAUTEUR/2, 400, 20);
  c.AjouterMur(LARGEUR - 250, HAUTEUR/2, 400, 20);
  // Pont = ouverture de ~80px au centre

  // Barricades autour du pont
  c.AjouterMurDestructible(LARGEUR/2 - 60, HAUTEUR/2 - 60, 30, 30, 2);
  c.AjouterMurDestructible(LARGEUR/2 + 60, HAUTEUR/2 - 60, 30, 30, 2);
  c.AjouterMurDestructible(LARGEUR/2 - 60, HAUTEUR/2 + 60, 30, 30, 2);
  c.AjouterMurDestructible(LARGEUR/2 + 60, HAUTEUR/2 + 60, 30, 30, 2);

  // Abris dans chaque zone
  c.AjouterMur(250, 200, 20, 120);
  c.AjouterMur(LARGEUR - 250, HAUTEUR - 200, 20, 120);

  c.AjouterSpawn(150, 200, 0);
  c.AjouterSpawn(LARGEUR - 150, HAUTEUR - 200, PI);
  c.AjouterSpawn(150, HAUTEUR - 200, 0);
  c.AjouterSpawn(LARGEUR - 150, 200, PI);

  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_explosif");
  c.AjouterPickup(LARGEUR/4, HAUTEUR/4, "mun_missile");
  c.AjouterPickup(LARGEUR*3/4, HAUTEUR*3/4, "boost_defense");
  c.AjouterPickup(LARGEUR/2, 100, "sante");

  return c;
}

// --- Bunker : petites salles connectées ---
Carte Carte_Bunker() {
  Carte c = new Carte("Bunker", "Petites salles blindees", 4);
  c.SetTheme(#0D0D11, #556677);
  c.SetThemeJour(#A0A8B8, #445566);
  c.AjouterBordures(20);

  // 4 salles dans les coins avec ouvertures
  // Salle haut-gauche
  c.AjouterMur(200, 180, 20, 300);
  c.AjouterMur(100, 180, 160, 20);
  // Salle haut-droite
  c.AjouterMur(LARGEUR - 200, 180, 20, 300);
  c.AjouterMur(LARGEUR - 100, 180, 160, 20);
  // Salle bas-gauche
  c.AjouterMur(200, HAUTEUR - 180, 20, 300);
  c.AjouterMur(100, HAUTEUR - 180, 160, 20);
  // Salle bas-droite
  c.AjouterMur(LARGEUR - 200, HAUTEUR - 180, 20, 300);
  c.AjouterMur(LARGEUR - 100, HAUTEUR - 180, 160, 20);

  // Murs destructibles aux ouvertures
  c.AjouterMurDestructible(200, 80, 20, 60, 2);
  c.AjouterMurDestructible(LARGEUR - 200, 80, 20, 60, 2);
  c.AjouterMurDestructible(200, HAUTEUR - 80, 20, 60, 2);
  c.AjouterMurDestructible(LARGEUR - 200, HAUTEUR - 80, 20, 60, 2);

  // Pilier central
  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 50, 50);

  c.AjouterSpawn(100, 80, PI/4);
  c.AjouterSpawn(LARGEUR - 100, 80, 3*PI/4);
  c.AjouterSpawn(100, HAUTEUR - 80, -PI/4);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR - 80, -3*PI/4);

  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_forage");
  c.AjouterPickup(200, HAUTEUR/2, "mun_grenade");
  c.AjouterPickup(LARGEUR - 200, HAUTEUR/2, "sante");
  c.AjouterPickup(LARGEUR/2, 100, "boost_cadence");

  return c;
}

// --- Croix : grande croix de murs au centre ---
Carte Carte_Croix() {
  Carte c = new Carte("Croix", "Croix massive au centre", 4);
  c.SetTheme(#1A0A0A, #AA4444);
  c.SetThemeJour(#C8A090, #884444);
  c.AjouterBordures(20);

  // Grande croix
  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 40, 400);
  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 500, 40);

  // Ouvertures dans la croix (murs destructibles qui bloquent les passages)
  c.AjouterMurDestructible(LARGEUR/2, 180, 40, 40, 3);
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR - 180, 40, 40, 3);
  c.AjouterMurDestructible(300, HAUTEUR/2, 40, 40, 3);
  c.AjouterMurDestructible(LARGEUR - 300, HAUTEUR/2, 40, 40, 3);

  c.AjouterSpawn(100, 100, PI/4);
  c.AjouterSpawn(LARGEUR - 100, 100, 3*PI/4);
  c.AjouterSpawn(100, HAUTEUR - 100, -PI/4);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR - 100, -3*PI/4);

  c.AjouterPickup(200, 200, "mun_plasma");
  c.AjouterPickup(LARGEUR - 200, HAUTEUR - 200, "mun_teleporteur");
  c.AjouterPickup(200, HAUTEUR - 200, "sante");
  c.AjouterPickup(LARGEUR - 200, 200, "boost_gigantisme");

  return c;
}

// --- Archipel : îlots dispersés ---
Carte Carte_Archipel() {
  Carte c = new Carte("Archipel", "Ilots disperses dans le vide", 4);
  c.SetTheme(#0A1A2A, #44AACC);
  c.SetThemeJour(#A0D0E0, #3388AA);
  c.AjouterBordures(20);

  // Îlots (groupes de petits murs)
  c.AjouterMur(200, 150, 60, 40);
  c.AjouterMur(230, 180, 40, 30);

  c.AjouterMur(700, 200, 50, 60);
  c.AjouterMur(750, 180, 30, 40);

  c.AjouterMur(400, 400, 70, 50);
  c.AjouterMurDestructible(430, 430, 30, 30, 2);

  c.AjouterMur(800, 500, 60, 40);
  c.AjouterMur(830, 530, 40, 30);

  c.AjouterMur(150, 550, 50, 50);

  c.AjouterMur(LARGEUR/2, HAUTEUR/2, 40, 40);

  c.AjouterSpawn(80, 360, 0);
  c.AjouterSpawn(LARGEUR - 80, 360, PI);
  c.AjouterSpawn(LARGEUR/2, 60, PI/2);
  c.AjouterSpawn(LARGEUR/2, HAUTEUR - 60, -PI/2);

  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_chaine");
  c.AjouterPickup(300, 300, "mun_miroir");
  c.AjouterPickup(700, 400, "sante");
  c.AjouterPickup(500, 200, "boost_magnetique");

  return c;
}

// --- Usine : convoyeurs et machines ---
Carte Carte_Usine() {
  Carte c = new Carte("Usine", "Machinerie et tapis roulants", 4);
  c.SetTheme(#0F0805, #BB6633);
  c.SetThemeJour(#C4A888, #885533);
  c.AjouterBordures(20);

  // Machines (gros blocs)
  c.AjouterMur(250, 200, 100, 60);
  c.AjouterMur(LARGEUR - 250, 200, 100, 60);
  c.AjouterMur(250, HAUTEUR - 200, 100, 60);
  c.AjouterMur(LARGEUR - 250, HAUTEUR - 200, 100, 60);

  // Corridor central
  c.AjouterMur(LARGEUR/2, 250, 20, 200);
  c.AjouterMur(LARGEUR/2, HAUTEUR - 250, 20, 200);

  // Murs destructibles
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2 - 80, 60, 20, 3);
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2 + 80, 60, 20, 3);

  c.AjouterSpawn(100, 100, PI/4);
  c.AjouterSpawn(LARGEUR - 100, 100, 3*PI/4);
  c.AjouterSpawn(100, HAUTEUR - 100, -PI/4);
  c.AjouterSpawn(LARGEUR - 100, HAUTEUR - 100, -3*PI/4);

  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "mun_forage");
  c.AjouterPickup(400, HAUTEUR/2, "mun_fumigene");
  c.AjouterPickup(LARGEUR - 400, HAUTEUR/2, "boost_vitesse");
  c.AjouterPickup(LARGEUR/2, 100, "sante");

  return c;
}

// --- Temple : structure symétrique sacrée ---
Carte Carte_Temple() {
  Carte c = new Carte("Temple", "Structure sacree symetrique", 4);
  c.SetTheme(#141400, #AAAA44);
  c.SetThemeJour(#D8D0A0, #888844);
  c.AjouterBordures(20);

  float cx = LARGEUR / 2;
  float cy = HAUTEUR / 2;

  // Murs symétriques formant un temple
  c.AjouterMur(cx, cy - 120, 200, 20);
  c.AjouterMur(cx, cy + 120, 200, 20);
  c.AjouterMur(cx - 100, cy, 20, 220);
  c.AjouterMur(cx + 100, cy, 20, 220);

  // Entrées (ouvertures dans les murs)
  // Les murs ci-dessus laissent des ouvertures aux coins

  // Autel central
  c.AjouterMurDestructible(cx, cy, 30, 30, 5);

  // Colonnes externes
  c.AjouterMur(cx - 250, cy - 150, 25, 25);
  c.AjouterMur(cx + 250, cy - 150, 25, 25);
  c.AjouterMur(cx - 250, cy + 150, 25, 25);
  c.AjouterMur(cx + 250, cy + 150, 25, 25);

  c.AjouterSpawn(80, 80, PI/4);
  c.AjouterSpawn(LARGEUR - 80, 80, 3*PI/4);
  c.AjouterSpawn(80, HAUTEUR - 80, -PI/4);
  c.AjouterSpawn(LARGEUR - 80, HAUTEUR - 80, -3*PI/4);

  c.AjouterPickup(cx, cy, "mun_meteore");
  c.AjouterPickup(cx - 200, cy, "mun_laser");
  c.AjouterPickup(cx + 200, cy, "boost_miniature");
  c.AjouterPickup(cx, cy - 200, "sante");

  return c;
}

// --- Chaos : aléatoire, beaucoup de pickups ---
Carte Carte_Chaos() {
  Carte c = new Carte("Chaos", "Terrain imprevisible et charge", 4);
  c.SetTheme(#1A0A18, #CC44AA);
  c.SetThemeJour(#D0B0C8, #AA4488);
  c.AjouterBordures(20);

  // Murs dispersés aléatoirement (mais fixes pour la map)
  c.AjouterMur(200, 150, 80, 30);
  c.AjouterMur(500, 100, 30, 80);
  c.AjouterMur(800, 200, 60, 40);
  c.AjouterMur(350, 300, 40, 60);
  c.AjouterMur(650, 350, 50, 50);
  c.AjouterMur(150, 450, 70, 30);
  c.AjouterMur(900, 400, 40, 70);
  c.AjouterMur(400, 550, 60, 30);
  c.AjouterMur(700, 600, 30, 60);
  c.AjouterMurDestructible(LARGEUR/2, HAUTEUR/2, 50, 50, 2);
  c.AjouterMurDestructible(300, 500, 40, 40, 2);
  c.AjouterMurDestructible(750, 150, 40, 40, 2);

  c.AjouterSpawn(80, HAUTEUR/2, 0);
  c.AjouterSpawn(LARGEUR - 80, HAUTEUR/2, PI);
  c.AjouterSpawn(LARGEUR/2, 60, PI/2);
  c.AjouterSpawn(LARGEUR/2, HAUTEUR - 60, -PI/2);

  // Beaucoup de pickups variés
  c.AjouterPickup(200, 250, "mun_cluster");
  c.AjouterPickup(600, 200, "mun_incendiaire");
  c.AjouterPickup(400, 400, "mun_teleporteur");
  c.AjouterPickup(800, 300, "mun_aspirante");
  c.AjouterPickup(300, 600, "boost_vampirique");
  c.AjouterPickup(700, 500, "boost_fantome");
  c.AjouterPickup(LARGEUR/2, HAUTEUR/2, "sante");
  c.AjouterPickup(150, 150, "mun_fumigene");

  return c;
}
