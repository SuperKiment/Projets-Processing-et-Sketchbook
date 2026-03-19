// ============================================
// TypeMunition.pde - Définitions des types de munitions
// ============================================

HashMap<String, TypeMunition> TypesMunitions = new HashMap<String, TypeMunition>();

class TypeMunition {
  String nom;
  float vitesse;
  float dureeVie;
  float taille;
  float degats;
  int rebondsMax;
  boolean explose;
  float rayonExplosion;
  color couleur;

  // Comportement spécial
  String comportement = "normal";
  // "normal", "guidee", "mine", "grenade", "cluster",
  // "boomerang", "emp", "laser", "incendiaire", "ricochet"

  // Multi-projectile (shotgun)
  int nbProjectiles = 1;
  float spread = 0;

  // Mur plaçable
  boolean placeMur;
  float murTailleX, murTailleY;
  int murHp;

  // Perce (laser)
  boolean perce = false;

  TypeMunition(String n) {
    nom = n;
    vitesse = 10;
    dureeVie = 3000;
    taille = 10;
    degats = 1;
    rebondsMax = 5;
    explose = false;
    rayonExplosion = 0;
    placeMur = false;
    murTailleX = 50;
    murTailleY = 20;
    murHp = 3;
    couleur = #FFFFFF;
  }
}

void Setup_TypesMunitions() {
  // 1. Standard
  TypeMunition standard = new TypeMunition("standard");
  TypesMunitions.put("standard", standard);

  // 2. Rapide
  TypeMunition rapide = new TypeMunition("rapide");
  rapide.vitesse = 18; rapide.dureeVie = 1500; rapide.taille = 6;
  rapide.rebondsMax = 3; rapide.couleur = #FFFF00;
  TypesMunitions.put("rapide", rapide);

  // 3. Explosif
  TypeMunition explosif = new TypeMunition("explosif");
  explosif.vitesse = 6; explosif.dureeVie = 4000; explosif.taille = 14;
  explosif.degats = 2; explosif.rebondsMax = 2;
  explosif.explose = true; explosif.rayonExplosion = 60;
  explosif.couleur = #FF6600;
  TypesMunitions.put("explosif", explosif);

  // 4. Bouncy
  TypeMunition bouncy = new TypeMunition("bouncy");
  bouncy.vitesse = 12; bouncy.dureeVie = 5000; bouncy.taille = 8;
  bouncy.rebondsMax = 15; bouncy.couleur = #00FFFF;
  TypesMunitions.put("bouncy", bouncy);

  // 5. Mur plaçable
  TypeMunition mur = new TypeMunition("mur");
  mur.vitesse = 8; mur.dureeVie = 600; mur.taille = 12;
  mur.degats = 0; mur.rebondsMax = 0;
  mur.placeMur = true; mur.murTailleX = 50; mur.murTailleY = 20; mur.murHp = 3;
  mur.couleur = #AAAAAA;
  TypesMunitions.put("mur", mur);

  // 6. Missile guidé - suit la direction du tireur
  TypeMunition missile = new TypeMunition("missile");
  missile.vitesse = 7; missile.dureeVie = 4000; missile.taille = 10;
  missile.degats = 2; missile.rebondsMax = 0;
  missile.comportement = "guidee"; missile.couleur = #FF3333;
  TypesMunitions.put("missile", missile);

  // 7. Grenade - décélère puis explose
  TypeMunition grenade = new TypeMunition("grenade");
  grenade.vitesse = 9; grenade.dureeVie = 1800; grenade.taille = 12;
  grenade.degats = 2; grenade.rebondsMax = 1;
  grenade.explose = true; grenade.rayonExplosion = 80;
  grenade.comportement = "grenade"; grenade.couleur = #88AA22;
  TypesMunitions.put("grenade", grenade);

  // 8. Mine - posée au sol, explose à proximité
  TypeMunition mine = new TypeMunition("mine");
  mine.vitesse = 0; mine.dureeVie = 20000; mine.taille = 10;
  mine.degats = 2; mine.rebondsMax = 0;
  mine.explose = true; mine.rayonExplosion = 55;
  mine.comportement = "mine"; mine.couleur = #FF2255;
  TypesMunitions.put("mine", mine);

  // 9. Laser - très rapide, perce les cibles
  TypeMunition laser = new TypeMunition("laser");
  laser.vitesse = 45; laser.dureeVie = 180; laser.taille = 4;
  laser.degats = 1; laser.rebondsMax = 0;
  laser.perce = true;
  laser.comportement = "laser"; laser.couleur = #FF00FF;
  TypesMunitions.put("laser", laser);

  // 10. Chevrotine - 5 projectiles en éventail
  TypeMunition shotgun = new TypeMunition("shotgun");
  shotgun.vitesse = 14; shotgun.dureeVie = 400; shotgun.taille = 5;
  shotgun.degats = 1; shotgun.rebondsMax = 1;
  shotgun.nbProjectiles = 5; shotgun.spread = PI/8;
  shotgun.couleur = #FFAA44;
  TypesMunitions.put("shotgun", shotgun);

  // 11. Cluster - se divise en éclats à la mort
  TypeMunition cluster = new TypeMunition("cluster");
  cluster.vitesse = 8; cluster.dureeVie = 1500; cluster.taille = 12;
  cluster.degats = 1; cluster.rebondsMax = 2;
  cluster.comportement = "cluster"; cluster.couleur = #AA44FF;
  TypesMunitions.put("cluster", cluster);

  // 12. Boomerang - fait demi-tour
  TypeMunition boomerang = new TypeMunition("boomerang");
  boomerang.vitesse = 11; boomerang.dureeVie = 2500; boomerang.taille = 9;
  boomerang.degats = 1; boomerang.rebondsMax = 0;
  boomerang.comportement = "boomerang"; boomerang.couleur = #44DDAA;
  TypesMunitions.put("boomerang", boomerang);

  // 13. EMP - ralentit l'ennemi touché
  TypeMunition emp = new TypeMunition("emp");
  emp.vitesse = 9; emp.dureeVie = 2500; emp.taille = 12;
  emp.degats = 0; emp.rebondsMax = 3;
  emp.comportement = "emp"; emp.couleur = #4488FF;
  TypesMunitions.put("emp", emp);

  // 14. Incendiaire - laisse des flammes
  TypeMunition incendiaire = new TypeMunition("incendiaire");
  incendiaire.vitesse = 7; incendiaire.dureeVie = 3000; incendiaire.taille = 10;
  incendiaire.degats = 1; incendiaire.rebondsMax = 3;
  incendiaire.comportement = "incendiaire"; incendiaire.couleur = #FF8800;
  TypesMunitions.put("incendiaire", incendiaire);

  // 15. Ricochet - accélère à chaque rebond
  TypeMunition ricochet = new TypeMunition("ricochet");
  ricochet.vitesse = 7; ricochet.dureeVie = 6000; ricochet.taille = 6;
  ricochet.degats = 1; ricochet.rebondsMax = 25;
  ricochet.comportement = "ricochet"; ricochet.couleur = #EEDD33;
  TypesMunitions.put("ricochet", ricochet);

  // 16. Plasma - traverse les murs (pas les bords)
  TypeMunition plasma = new TypeMunition("plasma");
  plasma.vitesse = 12; plasma.dureeVie = 2000; plasma.taille = 10;
  plasma.degats = 2; plasma.rebondsMax = 0;
  plasma.perce = true;
  plasma.comportement = "plasma"; plasma.couleur = #00FFCC;
  TypesMunitions.put("plasma", plasma);

  // 17. Téléporteur - téléporte l'ennemi touché
  TypeMunition teleporteur = new TypeMunition("teleporteur");
  teleporteur.vitesse = 9; teleporteur.dureeVie = 3000; teleporteur.taille = 8;
  teleporteur.degats = 0; teleporteur.rebondsMax = 2;
  teleporteur.comportement = "teleporteur"; teleporteur.couleur = #CC44FF;
  TypesMunitions.put("teleporteur", teleporteur);

  // 18. Aspirante - suit l'ennemi le plus proche
  TypeMunition aspirante = new TypeMunition("aspirante");
  aspirante.vitesse = 8; aspirante.dureeVie = 4000; aspirante.taille = 9;
  aspirante.degats = 1; aspirante.rebondsMax = 1;
  aspirante.comportement = "aspirante"; aspirante.couleur = #FF66AA;
  TypesMunitions.put("aspirante", aspirante);

  // 19. Météore - très lent, explosion massive
  TypeMunition meteore = new TypeMunition("meteore");
  meteore.vitesse = 4; meteore.dureeVie = 5000; meteore.taille = 18;
  meteore.degats = 3; meteore.rebondsMax = 0;
  meteore.explose = true; meteore.rayonExplosion = 120;
  meteore.comportement = "meteore"; meteore.couleur = #FF4400;
  TypesMunitions.put("meteore", meteore);

  // 20. Chaîne - saute à l'ennemi suivant après impact
  TypeMunition chaine = new TypeMunition("chaine");
  chaine.vitesse = 11; chaine.dureeVie = 3000; chaine.taille = 7;
  chaine.degats = 1; chaine.rebondsMax = 0;
  chaine.comportement = "chaine"; chaine.couleur = #AAFFFF;
  TypesMunitions.put("chaine", chaine);

  // 21. Forage - détruit tous les murs au contact
  TypeMunition forage = new TypeMunition("forage");
  forage.vitesse = 4; forage.dureeVie = 6000; forage.taille = 14;
  forage.degats = 1; forage.rebondsMax = 0;
  forage.comportement = "forage"; forage.couleur = #BB8844;
  TypesMunitions.put("forage", forage);

  // 22. Miroir - rebondit sur les tanks et inverse leur direction
  TypeMunition miroir = new TypeMunition("miroir");
  miroir.vitesse = 10; miroir.dureeVie = 4000; miroir.taille = 8;
  miroir.degats = 0; miroir.rebondsMax = 5;
  miroir.comportement = "miroir"; miroir.couleur = #DDDDFF;
  TypesMunitions.put("miroir", miroir);

  // 23. Fumigène - crée un nuage de fumée opaque à l'impact
  TypeMunition fumigene = new TypeMunition("fumigene");
  fumigene.vitesse = 7; fumigene.dureeVie = 2000; fumigene.taille = 12;
  fumigene.degats = 0; fumigene.rebondsMax = 0;
  fumigene.comportement = "fumigene"; fumigene.couleur = #888888;
  TypesMunitions.put("fumigene", fumigene);
}
