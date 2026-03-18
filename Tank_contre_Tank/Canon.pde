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
    rect(longueur/2, 0, longueur, largeur);

    if (munsSpecialesRestantes > 0) {
      fill(typeMunActuel.couleur, 180);
      ellipse(longueur * 0.8, 0, 5, 5);
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

      AllMunitions.add(m);
    }

    // Effets de tir
    if (!typeATirer.comportement.equals("mine")) {
      EtincellesDir(spawnX, spawnY, 4, proprietaire.dir, PI/6, 3, typeATirer.couleur);
      FumeeParticules(spawnX, spawnY, 2);
    }

    if (munsSpecialesRestantes > 0) {
      munsSpecialesRestantes--;
      if (munsSpecialesRestantes <= 0) {
        typeMunActuel = typeMunDefaut;
      }
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
