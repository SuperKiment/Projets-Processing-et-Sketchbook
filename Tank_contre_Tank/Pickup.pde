// ============================================
// Pickup.pde - Système de pickups scalable
// ============================================

ArrayList<Pickup> AllPickups = new ArrayList<Pickup>();
HashMap<String, TypePickup> TypesPickups = new HashMap<String, TypePickup>();
ArrayList<String> ClesPickupsAleatoires = new ArrayList<String>();

class TypePickup {
  String nom;
  String description;
  String categorie;
  color couleur;
  float respawnDelai = 8000;

  String typeMunition = "";
  int nbTirs = 5;

  float multiplicateur = 1.5;
  float dureeEffet = 5000;
  int soin = 1;

  String icone = "losange";

  TypePickup(String n, String desc, String cat) {
    nom = n; description = desc; categorie = cat;
    couleur = #FFFFFF;
  }
}

class BoostActif {
  String categorie;
  float multiplicateur;
  float fin;
  BoostActif(String cat, float mult, float duree) {
    categorie = cat; multiplicateur = mult; fin = millis() + duree;
  }
  boolean Expire() { return millis() >= fin; }
}

class Pickup {
  float x, y;
  TypePickup type;
  boolean actif = true;
  boolean aleatoire = false;
  boolean positionAleatoire = false;
  float timerRespawn = 0;
  float animTimer;

  Pickup(float nx, float ny, TypePickup t) {
    x = nx; y = ny; type = t;
    animTimer = random(TWO_PI);
  }

  void Fonctions() {
    if (!actif) {
      if (millis() - timerRespawn >= type.respawnDelai) actif = true;
      return;
    }

    float rayonDetection = 25;
    // Aimant : rayon étendu
    for (int i = 0; i < AllTanks.size(); i++) {
      Tank tank = AllTanks.get(i);
      if (!tank.vivant) continue;
      float rayon = tank.RayonPickup();
      if (dist(x, y, tank.x, tank.y) < rayon) {
        AppliquerPickup(tank, type);
        Ramasser();
        break;
      }
    }

    if (actif) Affichage();
  }

  void Ramasser() {
    // Texte flottant
    CreerTexteFlottant(x, y - 20, type.nom, type.description, type.couleur);
    BoumParticulesCouleur(x, y, 12, 25, 4, type.couleur);
    actif = false;
    timerRespawn = millis();

    if (aleatoire) {
      type = TypePickupAleatoire();
      if (positionAleatoire) PosAleatoireValide();
      animTimer = random(TWO_PI);
    }
  }

  void PosAleatoireValide() {
    float marge = 60;
    for (int t = 0; t < 50; t++) {
      float nx = random(marge, LARGEUR - marge);
      float ny = random(marge, HAUTEUR - marge);
      boolean valide = true;
      for (Mur m : AllMurs) {
        if (PointDansRect(nx, ny, m.x, m.y, m.tailleX + 40, m.tailleY + 40)) { valide = false; break; }
      }
      if (partieActuelle != null) {
        for (PointSpawn sp : partieActuelle.carte.spawns) {
          if (dist(nx, ny, sp.x, sp.y) < 80) { valide = false; break; }
        }
      }
      for (Pickup p : AllPickups) {
        if (p != this && dist(nx, ny, p.x, p.y) < 60) { valide = false; break; }
      }
      if (valide) { x = nx; y = ny; return; }
    }
    x = random(marge, LARGEUR - marge);
    y = random(marge, HAUTEUR - marge);
  }

  void Affichage() {
    float t = millis() * 0.003 + animTimer;
    float flottement = sin(t) * 4;
    float pulse = 0.9 + sin(t * 2) * 0.1;

    AuraParticules(x, y + flottement, type.couleur);

    push();
    translate(x, y + flottement);
    rotate(t * 0.5);
    scale(pulse);
    noStroke();
    fill(type.couleur, 40);
    ellipse(0, 0, 35, 35);
    fill(type.couleur);
    DessinerIcone(type.icone, 0, 0, 14);
    if (aleatoire) {
      noFill();
      stroke(type.couleur, sin(t * 4) * 100 + 150);
      strokeWeight(1.5);
      ellipse(0, 0, 28, 28);
    }
    pop();
  }
}

void DessinerIcone(String icone, float x, float y, float taille) {
  if (icone.equals("losange")) {
    push(); translate(x, y); rotate(PI/4);
    rectMode(CENTER); rect(0, 0, taille, taille); pop();
  } else if (icone.equals("cercle")) {
    ellipse(x, y, taille, taille);
  } else if (icone.equals("carre")) {
    rectMode(CENTER); rect(x, y, taille, taille);
  } else if (icone.equals("triangle")) {
    triangle(x, y - taille/2, x - taille/2, y + taille/2, x + taille/2, y + taille/2);
  } else if (icone.equals("croix")) {
    rectMode(CENTER);
    rect(x, y, taille, taille * 0.3);
    rect(x, y, taille * 0.3, taille);
  } else if (icone.equals("etoile")) {
    push(); translate(x, y);
    for (int i = 0; i < 4; i++) {
      rotate(PI/4);
      rectMode(CENTER);
      rect(0, 0, taille, taille * 0.25);
    }
    pop();
  }
}

void AppliquerPickup(Tank tank, TypePickup tp) {
  if (tp.categorie.equals("munition")) {
    tank.canon.ChangerMunition(tp.typeMunition, tp.nbTirs);
  } else if (tp.categorie.equals("sante")) {
    tank.hp = min(tank.hp + tp.soin, tank.type.hpMax);
  } else {
    // Tous les boosts passent par ici
    tank.boosts.add(new BoostActif(tp.categorie, tp.multiplicateur, tp.dureeEffet));
  }
}

TypePickup TypePickupAleatoire() {
  if (ClesPickupsAleatoires.size() == 0) return TypesPickups.values().iterator().next();
  return TypesPickups.get(ClesPickupsAleatoires.get((int)random(ClesPickupsAleatoires.size())));
}

void SpawnerPickupsAleatoires(int nb) {
  for (int i = 0; i < nb; i++) {
    Pickup p = new Pickup(0, 0, TypePickupAleatoire());
    p.aleatoire = true;
    p.positionAleatoire = true;
    p.PosAleatoireValide();
    AllPickups.add(p);
  }
}

void Setup_TypesPickups() {
  // === MUNITIONS ===
  TypePickup r;

  r = new TypePickup("Balle Rapide", "Tirs rapides et precis", "munition");
  r.couleur = #FFFF00; r.typeMunition = "rapide"; r.nbTirs = 5; r.icone = "losange";
  TypesPickups.put("mun_rapide", r);

  r = new TypePickup("Obus Explosif", "Explosion de zone", "munition");
  r.couleur = #FF6600; r.typeMunition = "explosif"; r.nbTirs = 3; r.icone = "cercle";
  TypesPickups.put("mun_explosif", r);

  r = new TypePickup("Balle Rebond", "Rebondit partout", "munition");
  r.couleur = #00FFFF; r.typeMunition = "bouncy"; r.nbTirs = 4; r.icone = "losange";
  TypesPickups.put("mun_bouncy", r);

  r = new TypePickup("Barricade", "Tire des murs", "munition");
  r.couleur = #AAAAAA; r.typeMunition = "mur"; r.nbTirs = 3; r.icone = "carre";
  TypesPickups.put("mun_mur", r);

  r = new TypePickup("Missile Guide", "Suit votre direction", "munition");
  r.couleur = #FF3333; r.typeMunition = "missile"; r.nbTirs = 2; r.icone = "triangle";
  TypesPickups.put("mun_missile", r);

  r = new TypePickup("Grenade", "Explose apres un delai", "munition");
  r.couleur = #88AA22; r.typeMunition = "grenade"; r.nbTirs = 3; r.icone = "cercle";
  TypesPickups.put("mun_grenade", r);

  r = new TypePickup("Mine", "Piege invisible", "munition");
  r.couleur = #FF2255; r.typeMunition = "mine"; r.nbTirs = 3; r.icone = "losange";
  TypesPickups.put("mun_mine", r);

  r = new TypePickup("Laser", "Tir percant instantane", "munition");
  r.couleur = #FF00FF; r.typeMunition = "laser"; r.nbTirs = 4; r.icone = "etoile";
  TypesPickups.put("mun_laser", r);

  r = new TypePickup("Chevrotine", "Tir en eventail", "munition");
  r.couleur = #FFAA44; r.typeMunition = "shotgun"; r.nbTirs = 4; r.icone = "triangle";
  TypesPickups.put("mun_shotgun", r);

  r = new TypePickup("Fragmentation", "Se divise en eclats", "munition");
  r.couleur = #AA44FF; r.typeMunition = "cluster"; r.nbTirs = 3; r.icone = "etoile";
  TypesPickups.put("mun_cluster", r);

  r = new TypePickup("Boomerang", "Revient vers vous", "munition");
  r.couleur = #44DDAA; r.typeMunition = "boomerang"; r.nbTirs = 3; r.icone = "losange";
  TypesPickups.put("mun_boomerang", r);

  r = new TypePickup("EMP", "Ralentit l'ennemi", "munition");
  r.couleur = #4488FF; r.typeMunition = "emp"; r.nbTirs = 3; r.icone = "cercle";
  TypesPickups.put("mun_emp", r);

  r = new TypePickup("Incendiaire", "Laisse des flammes", "munition");
  r.couleur = #FF8800; r.typeMunition = "incendiaire"; r.nbTirs = 3; r.icone = "triangle";
  TypesPickups.put("mun_incendiaire", r);

  r = new TypePickup("Ricochet", "Accelere a chaque rebond", "munition");
  r.couleur = #EEDD33; r.typeMunition = "ricochet"; r.nbTirs = 3; r.icone = "losange";
  TypesPickups.put("mun_ricochet", r);

  // === SANTE ===
  r = new TypePickup("Reparation", "+1 HP", "sante");
  r.couleur = #66FF66; r.soin = 1; r.icone = "croix"; r.respawnDelai = 12000;
  TypesPickups.put("sante", r);

  // === BOOSTS ===
  r = new TypePickup("Turbo", "Vitesse augmentee", "boost_vitesse");
  r.couleur = #FF44FF; r.multiplicateur = 1.8; r.dureeEffet = 5000;
  r.icone = "triangle"; r.respawnDelai = 10000;
  TypesPickups.put("boost_vitesse", r);

  r = new TypePickup("Bouclier", "Degats reduits", "boost_defense");
  r.couleur = #4488FF; r.multiplicateur = 2.0; r.dureeEffet = 6000;
  r.icone = "cercle"; r.respawnDelai = 12000;
  TypesPickups.put("boost_defense", r);

  r = new TypePickup("Cadence", "Tir plus rapide", "boost_cadence");
  r.couleur = #FFAA00; r.multiplicateur = 1; r.dureeEffet = 6000;
  r.icone = "etoile"; r.respawnDelai = 10000;
  TypesPickups.put("boost_cadence", r);

  r = new TypePickup("Furtif", "Quasi invisible", "boost_invisible");
  r.couleur = #8888CC; r.multiplicateur = 1; r.dureeEffet = 5000;
  r.icone = "losange"; r.respawnDelai = 15000;
  TypesPickups.put("boost_invisible", r);

  r = new TypePickup("Surcharge", "Degats doubles", "boost_degats");
  r.couleur = #FF2200; r.multiplicateur = 1; r.dureeEffet = 5000;
  r.icone = "triangle"; r.respawnDelai = 12000;
  TypesPickups.put("boost_degats", r);

  r = new TypePickup("Aimant", "Recuperation etendue", "boost_aimant");
  r.couleur = #CCCC44; r.multiplicateur = 1; r.dureeEffet = 8000;
  r.icone = "cercle"; r.respawnDelai = 10000;
  TypesPickups.put("boost_aimant", r);

  // === CLES POUR ALEATOIRE ===
  for (String cle : TypesPickups.keySet()) {
    ClesPickupsAleatoires.add(cle);
  }
}

void Fonctions_Pickups() {
  for (Pickup p : AllPickups) {
    p.Fonctions();
  }
}
