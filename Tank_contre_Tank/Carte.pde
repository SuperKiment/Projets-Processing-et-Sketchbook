// ============================================
// Carte.pde - Système de cartes/maps
// ============================================

Carte carteSelectionnee;

class DonneesMur {
  float x, y, tailleX, tailleY;
  String type;
  int hp; // -1 = indestructible

  DonneesMur(float nx, float ny, float ntx, float nty) {
    x = nx; y = ny; tailleX = ntx; tailleY = nty;
    type = "normal"; hp = -1;
  }

  DonneesMur(float nx, float ny, float ntx, float nty, String t) {
    x = nx; y = ny; tailleX = ntx; tailleY = nty;
    type = t; hp = -1;
  }

  DonneesMur(float nx, float ny, float ntx, float nty, String t, int nhp) {
    x = nx; y = ny; tailleX = ntx; tailleY = nty;
    type = t; hp = nhp;
  }
}

class PointSpawn {
  float x, y, dir;

  PointSpawn(float nx, float ny, float nd) {
    x = nx; y = ny; dir = nd;
  }
}

class DonneesPickup {
  float x, y;
  String typePickup;
  DonneesPickup(float nx, float ny, String tp) { x = nx; y = ny; typePickup = tp; }
}

class Carte {
  String nom;
  String description;
  int maxJoueurs;
  color couleurFond;

  ArrayList<DonneesMur> murs = new ArrayList<DonneesMur>();
  ArrayList<PointSpawn> spawns = new ArrayList<PointSpawn>();
  ArrayList<DonneesPickup> pickups = new ArrayList<DonneesPickup>();

  Carte(String n, String desc, int mj) {
    nom = n;
    description = desc;
    maxJoueurs = mj;
    couleurFond = COULEUR_FOND_JEU;
  }

  void AjouterMur(float x, float y, float tx, float ty) {
    murs.add(new DonneesMur(x, y, tx, ty));
  }

  void AjouterMurType(float x, float y, float tx, float ty, String type) {
    murs.add(new DonneesMur(x, y, tx, ty, type));
  }

  void AjouterMurDestructible(float x, float y, float tx, float ty, int hp) {
    murs.add(new DonneesMur(x, y, tx, ty, "destructible", hp));
  }

  void AjouterSpawn(float x, float y, float dir) {
    spawns.add(new PointSpawn(x, y, dir));
  }

  void AjouterPickup(float x, float y, String typePickup) {
    pickups.add(new DonneesPickup(x, y, typePickup));
  }

  // Bordures automatiques
  void AjouterBordures(float epaisseur) {
    AjouterMur(LARGEUR/2, epaisseur/2, LARGEUR, epaisseur);                  // haut
    AjouterMur(LARGEUR/2, HAUTEUR - epaisseur/2, LARGEUR, epaisseur);        // bas
    AjouterMur(epaisseur/2, HAUTEUR/2, epaisseur, HAUTEUR);                  // gauche
    AjouterMur(LARGEUR - epaisseur/2, HAUTEUR/2, epaisseur, HAUTEUR);        // droite
  }

  // Charger la carte dans le monde de jeu
  void Charger() {
    AllMurs.clear();
    for (DonneesMur dm : murs) {
      Mur m = new Mur(dm.x, dm.y, dm.tailleX, dm.tailleY);
      m.type = dm.type;
      if (dm.type.equals("destructible") && dm.hp > 0) {
        m.RendreDestructible(dm.hp);
      }
      AllMurs.add(m);
    }
    AllPickups.clear();
    for (DonneesPickup dp : pickups) {
      TypePickup tp = TypesPickups.get(dp.typePickup);
      if (tp != null) {
        Pickup p = new Pickup(dp.x, dp.y, tp);
        p.aleatoire = true; // type aléatoire au respawn
        AllPickups.add(p);
      }
    }
  }

  // Dessiner une prévisualisation miniature
  void AfficherMiniature(float px, float py, float largeur, float hauteur) {
    push();
    float echelleX = largeur / LARGEUR;
    float echelleY = hauteur / HAUTEUR;
    float echelle = min(echelleX, echelleY);

    // Fond
    fill(couleurFond);
    noStroke();
    rectMode(CORNER);
    rect(px, py, LARGEUR * echelle, HAUTEUR * echelle);

    // Murs
    fill(COULEUR_MUR, 200);
    rectMode(CENTER);
    for (DonneesMur dm : murs) {
      rect(px + dm.x * echelle, py + dm.y * echelle,
           dm.tailleX * echelle, dm.tailleY * echelle);
    }

    // Spawns
    for (int i = 0; i < spawns.size(); i++) {
      PointSpawn sp = spawns.get(i);
      if (i < COULEURS_JOUEURS.length) {
        fill(COULEURS_JOUEURS[i]);
      } else {
        fill(255);
      }
      ellipse(px + sp.x * echelle, py + sp.y * echelle, 6, 6);
    }

    pop();
  }
}
