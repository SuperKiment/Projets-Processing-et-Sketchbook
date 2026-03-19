// ============================================
// TypeTank.pde - Définitions des types de tanks
// ============================================

HashMap<String, TypeTank> TypesTanks = new HashMap<String, TypeTank>();
ArrayList<String> ListeNomsTanks = new ArrayList<String>();
String[] tankChoisiParJoueur = new String[4];

class TypeTank {
  String nom;
  String description;
  String specialNom;
  String specialDesc;
  float speedMax;
  float dirSpeed;
  float taille;         // taille visuelle
  float hitboxRayon;    // rayon de collision
  int hpMax;
  String typeMunitionDefaut;
  float cadenceTir;

  float canonLongueur;
  float canonLargeur;

  String forme;         // "carre", "losange", "octogone", "rectangle", "triangle"
  float specialCooldown; // ms

  TypeTank(String n) {
    nom = n;
    description = "";
    specialNom = "";
    specialDesc = "";
    speedMax = 5;
    dirSpeed = PI/50;
    taille = 20;
    hitboxRayon = 10;
    hpMax = 3;
    cadenceTir = 500;
    typeMunitionDefaut = "standard";
    canonLongueur = 40;
    canonLargeur = 10;
    forme = "carre";
    specialCooldown = 8000;
  }
}

void Setup_TypesTanks() {
  TypeTank t;

  // --- Sentinelle : équilibré, radar ---
  t = new TypeTank("Sentinelle");
  t.description = "Tank equilibre et polyvalent";
  t.specialNom = "Radar";
  t.specialDesc = "Revele tous les ennemis";
  t.speedMax = 5; t.dirSpeed = PI/50;
  t.taille = 20; t.hitboxRayon = 11;
  t.hpMax = 3; t.cadenceTir = 500;
  t.canonLongueur = 40; t.canonLargeur = 10;
  t.forme = "carre";
  t.specialCooldown = 10000;
  TypesTanks.put("Sentinelle", t);
  ListeNomsTanks.add("Sentinelle");

  // --- Eclaireur : rapide, dash ---
  t = new TypeTank("Eclaireur");
  t.description = "Ultra rapide mais fragile";
  t.specialNom = "Dash";
  t.specialDesc = "Propulsion instantanee";
  t.speedMax = 7.5; t.dirSpeed = PI/30;
  t.taille = 16; t.hitboxRayon = 9;
  t.hpMax = 2; t.cadenceTir = 400;
  t.typeMunitionDefaut = "standard";
  t.canonLongueur = 28; t.canonLargeur = 7;
  t.forme = "losange";
  t.specialCooldown = 4000;
  TypesTanks.put("Eclaireur", t);
  ListeNomsTanks.add("Eclaireur");

  // --- Titan : lourd, bouclier ---
  t = new TypeTank("Titan");
  t.description = "Lent et resistant, obus explosifs";
  t.specialNom = "Forteresse";
  t.specialDesc = "Invincible 2 secondes";
  t.speedMax = 2.5; t.dirSpeed = PI/70;
  t.taille = 30; t.hitboxRayon = 16;
  t.hpMax = 6; t.cadenceTir = 900;
  t.typeMunitionDefaut = "explosif";
  t.canonLongueur = 50; t.canonLargeur = 14;
  t.forme = "octogone";
  t.specialCooldown = 14000;
  TypesTanks.put("Titan", t);
  ListeNomsTanks.add("Titan");

  // --- Artilleur : sniper, surcharge ---
  t = new TypeTank("Artilleur");
  t.description = "Tir puissant a longue portee";
  t.specialNom = "Surcharge";
  t.specialDesc = "Prochain tir x3 degats";
  t.speedMax = 3; t.dirSpeed = PI/55;
  t.taille = 22; t.hitboxRayon = 12;
  t.hpMax = 2; t.cadenceTir = 1400;
  t.typeMunitionDefaut = "rapide";
  t.canonLongueur = 55; t.canonLargeur = 6;
  t.forme = "rectangle";
  t.specialCooldown = 7000;
  TypesTanks.put("Artilleur", t);
  ListeNomsTanks.add("Artilleur");

  // --- Fantome : furtif, phase ---
  t = new TypeTank("Fantome");
  t.description = "Insaisissable et sournois";
  t.specialNom = "Phase";
  t.specialDesc = "Teleportation + invisibilite";
  t.speedMax = 4.5; t.dirSpeed = PI/42;
  t.taille = 18; t.hitboxRayon = 10;
  t.hpMax = 2; t.cadenceTir = 550;
  t.typeMunitionDefaut = "standard";
  t.canonLongueur = 35; t.canonLargeur = 8;
  t.forme = "triangle";
  t.specialCooldown = 8000;
  TypesTanks.put("Fantome", t);
  ListeNomsTanks.add("Fantome");

  // Init sélections par défaut
  for (int i = 0; i < 4; i++) {
    tankChoisiParJoueur[i] = "Sentinelle";
  }
}
