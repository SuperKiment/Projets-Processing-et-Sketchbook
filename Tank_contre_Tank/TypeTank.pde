// ============================================
// TypeTank.pde - Définitions des types de tanks
// ============================================

HashMap<String, TypeTank> TypesTanks = new HashMap<String, TypeTank>();

class TypeTank {
  String nom;
  float speedMax;
  float dirSpeed;
  float taille;
  int hpMax;
  String typeMunitionDefaut;
  float cadenceTir; // ms entre chaque tir

  // Visuel canon
  float canonLongueur;
  float canonLargeur;

  TypeTank(String n) {
    nom = n;
    // Valeurs par défaut
    speedMax = 5;
    dirSpeed = PI/50;
    taille = 20;
    hpMax = 3;
    cadenceTir = 500;
    typeMunitionDefaut = "standard";
    canonLongueur = 40;
    canonLargeur = 10;
  }
}

void Setup_TypesTanks() {
  // --- Normal ---
  TypeTank normal = new TypeTank("Normal");
  TypesTanks.put("Normal", normal);

  // --- Rapide ---
  TypeTank rapide = new TypeTank("Rapide");
  rapide.speedMax = 7;
  rapide.dirSpeed = PI/35;
  rapide.taille = 16;
  rapide.hpMax = 2;
  rapide.cadenceTir = 400;
  rapide.typeMunitionDefaut = "standard";
  rapide.canonLongueur = 30;
  rapide.canonLargeur = 8;
  TypesTanks.put("Rapide", rapide);

  // --- Lourd ---
  TypeTank lourd = new TypeTank("Lourd");
  lourd.speedMax = 2.5;
  lourd.dirSpeed = PI/70;
  lourd.taille = 28;
  lourd.hpMax = 5;
  lourd.cadenceTir = 800;
  lourd.typeMunitionDefaut = "explosif";
  lourd.canonLongueur = 50;
  lourd.canonLargeur = 14;
  TypesTanks.put("Lourd", lourd);

  // --- Sniper ---
  TypeTank sniper = new TypeTank("Sniper");
  sniper.speedMax = 3;
  sniper.dirSpeed = PI/55;
  sniper.taille = 18;
  sniper.hpMax = 2;
  sniper.cadenceTir = 1500;
  sniper.typeMunitionDefaut = "rapide";
  sniper.canonLongueur = 55;
  sniper.canonLargeur = 6;
  TypesTanks.put("Sniper", sniper);
}
