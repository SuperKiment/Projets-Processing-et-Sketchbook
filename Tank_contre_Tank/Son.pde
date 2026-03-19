// ============================================
// Son.pde - Système de sons
// ============================================

import processing.sound.*;

HashMap<String, SoundFile> sons = new HashMap<String, SoundFile>();
boolean sonSystemeActif = false;

void Setup_Sons() {
  try {
    String[] fichiers = {
      // Tirs
      "tir",
      "tir_explosif",
      "tir_laser",
      "tir_shotgun",
      "tir_missile",
      "tir_mine",
      "tir_grenade",
      "tir_plasma",
      "tir_fumigene",
      // Impacts
      "impact",
      "impact_mur",
      "rebond",
      // Explosions
      "explosion",
      "explosion_grosse",
      // Tank
      "tank_mort",
      "tank_degats",
      "tank_dash",
      "tank_teleport",
      // Spéciaux
      "special_radar",
      "special_forteresse",
      "special_surcharge",
      "special_phase",
      "special_tourelle",
      "special_rage",
      "special_impulsion",
      "special_napalm",
      "special_salve",
      // Boosts & pickups
      "pickup",
      "pickup_sante",
      "boost_actif",
      "boost_fin",
      // Terrain
      "trampoline",
      "portail",
      "plaque_pression",
      "lave",
      // UI / Partie
      "menu_naviguer",
      "menu_valider",
      "menu_retour",
      "manche_debut",
      "manche_fin",
      "victoire",
    };

    for (String nom : fichiers) {
      ChargerSon(nom);
    }
    sonSystemeActif = true;
    println("[Son] Systeme de sons initialise - " + sons.size() + " sons charges");
  } catch (Exception e) {
    println("[Son] Bibliotheque sound non disponible - jeu muet");
    sonSystemeActif = false;
  }
}

void ChargerSon(String nom) {
  String[] extensions = { ".wav", ".mp3", ".ogg" };
  for (String ext : extensions) {
    String chemin = "sons/" + nom + ext;
    try {
      File f = new File(dataPath(chemin));
      if (f.exists()) {
        SoundFile sf = new SoundFile(this, chemin);
        sons.put(nom, sf);
        return;
      }
    } catch (Exception e) {
      // Fichier non trouvé ou erreur de chargement
    }
  }
}

void JouerSon(String nom) {
  if (!sonSystemeActif) return;
  SoundFile sf = sons.get(nom);
  if (sf != null) {
    try { sf.play(); } catch (Exception e) {}
  }
}

void JouerSon(String nom, float volume) {
  if (!sonSystemeActif) return;
  SoundFile sf = sons.get(nom);
  if (sf != null) {
    try { sf.amp(volume); sf.play(); } catch (Exception e) {}
  }
}

void JouerSon(String nom, float volume, float rate) {
  if (!sonSystemeActif) return;
  SoundFile sf = sons.get(nom);
  if (sf != null) {
    try { sf.amp(volume); sf.rate(rate); sf.play(); } catch (Exception e) {}
  }
}
