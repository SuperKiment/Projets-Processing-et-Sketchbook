// ============================================
// Canon.pde - Classe Canon
// ============================================

class Canon {
  Tank proprietaire;
  TypeMunition typeMunDefaut;
  TypeMunition typeMunActuel;
  int munsSpecialesRestantes = 0;
  float dernierTir = 0;

  Canon(Tank prop) {
    proprietaire = prop;
    typeMunDefaut = TypesMunitions.get(prop.type.typeMunitionDefaut);
    if (typeMunDefaut == null) typeMunDefaut = TypesMunitions.get("standard");
    typeMunActuel = typeMunDefaut;
  }

  void Affichage() {
    fill(lerpColor(proprietaire.couleur, #000000, 0.4));
    noStroke();
    float longueur = proprietaire.type.canonLongueur;
    float largeur = proprietaire.type.canonLargeur;

    if (proprietaire.type.forme.equals("double_canon")) {
      // Double canon espacé
      float ecart = largeur * 1.2;
      rect(longueur/2, -ecart, longueur, largeur);
      rect(longueur/2, ecart, longueur, largeur);
      if (munsSpecialesRestantes > 0) {
        fill(typeMunActuel.couleur, 180);
        ellipse(longueur * 0.8, -ecart, 4, 4);
        ellipse(longueur * 0.8, ecart, 4, 4);
      }
    } else {
      rect(longueur/2, 0, longueur, largeur);
      if (munsSpecialesRestantes > 0) {
        fill(typeMunActuel.couleur, 180);
        ellipse(longueur * 0.8, 0, 5, 5);
      }
    }
  }

  float CadenceEffective() {
    float cadence = proprietaire.type.cadenceTir;
    if (proprietaire.ABoost("boost_cadence")) cadence *= 0.4;
    return cadence;
  }

  boolean PeutTirer() {
    return millis() - dernierTir >= CadenceEffective();
  }

  void Tir() {
    if (!PeutTirer()) return;
    dernierTir = millis();

    TypeMunition typeATirer = (munsSpecialesRestantes > 0) ? typeMunActuel : typeMunDefaut;

    float taille = proprietaire.type.taille;
    float spawnX = proprietaire.x + cos(proprietaire.dir) * (taille/2 + 5);
    float spawnY = proprietaire.y + sin(proprietaire.dir) * (taille/2 + 5);

    // Mine : spawn au pied du tank
    if (typeATirer.comportement.equals("mine")) {
      spawnX = proprietaire.x - cos(proprietaire.dir) * (taille/2 + 5);
      spawnY = proprietaire.y - sin(proprietaire.dir) * (taille/2 + 5);
    }

    // Multi-projectile (shotgun)
    int nb = typeATirer.nbProjectiles;
    float spreadAngle = typeATirer.spread;

    for (int i = 0; i < nb; i++) {
      float angle = proprietaire.dir;
      if (nb > 1) {
        angle += map(i, 0, nb - 1, -spreadAngle, spreadAngle);
      }
      Munition m = new Munition(spawnX, spawnY, angle, typeATirer, proprietaire.joueurId);

      // Boost dégâts
      if (proprietaire.ABoost("boost_degats")) {
        m.multDegats = 2.0;
      }

      // Surcharge (Artilleur)
      if (proprietaire.surchargeActive) {
        m.multDegats *= 3.0;
      }

      AllMunitions.add(m);
    }

    // Effets de tir
    if (!typeATirer.comportement.equals("mine")) {
      EtincellesDir(spawnX, spawnY, 4, proprietaire.dir, PI/6, 3, typeATirer.couleur);
      FumeeParticules(spawnX, spawnY, 2);
      FlashTir(spawnX, spawnY, typeATirer.couleur);
      // Son selon le type
      String comp = typeATirer.comportement;
      if (comp.equals("laser")) JouerSon("tir_laser");
      else if (typeATirer.nom.equals("shotgun")) JouerSon("tir_shotgun");
      else if (comp.equals("guidee")) JouerSon("tir_missile");
      else if (comp.equals("grenade")) JouerSon("tir_grenade");
      else if (comp.equals("plasma")) JouerSon("tir_plasma");
      else if (comp.equals("fumigene")) JouerSon("tir_fumigene");
      else if (typeATirer.explose) JouerSon("tir_explosif");
      else JouerSon("tir");
    } else {
      JouerSon("tir_mine");
    }

    if (munsSpecialesRestantes > 0) {
      munsSpecialesRestantes--;
      if (munsSpecialesRestantes <= 0) {
        typeMunActuel = typeMunDefaut;
      }
    }

    // Consommer la surcharge après un tir
    if (proprietaire.surchargeActive) {
      proprietaire.surchargeActive = false;
      FlashExplosion(spawnX, spawnY, 30);
    }
  }

  void ChangerMunition(String typeName, int nb) {
    TypeMunition tm = TypesMunitions.get(typeName);
    if (tm != null) {
      typeMunActuel = tm;
      munsSpecialesRestantes = nb;
    }
  }

  String NomMunitionActuelle() {
    if (munsSpecialesRestantes > 0) return typeMunActuel.nom + " (" + munsSpecialesRestantes + ")";
    return typeMunDefaut.nom;
  }
}
