// ============================================
// Menu_Manettes.pde - Configuration des manettes
// ============================================

SelecteurMenu menuManettes;
float dernierScan = 0;

void Setup_MenuManettes() {
  menuManettes = new SelecteurMenu();
  menuManettes.AjouterBouton(new Bouton("SCANNER", LARGEUR/2, HAUTEUR - 120, 250, 45));
  menuManettes.AjouterBouton(new Bouton("RETOUR", LARGEUR/2, HAUTEUR - 60, 250, 45));

  // Re-scanner les manettes à chaque entrée dans le menu
  ScannerManettes();
}

void Afficher_MenuManettes() {
  // Titre
  TexteCentre("MANETTES", LARGEUR/2, 40, 36, COULEUR_UI_TEXTE);

  // Slots joueurs
  float slotLarg = 700;
  float slotHaut = 80;
  float debutY = 100;

  for (int i = 0; i < MAX_JOUEURS; i++) {
    float sy = debutY + i * (slotHaut + 15);
    float sx = LARGEUR/2;

    push();
    rectMode(CENTER);

    // Fond du slot
    fill(COULEUR_UI_PANNEAU);
    stroke(COULEUR_UI_BORD);
    strokeWeight(1);
    rect(sx, sy, slotLarg, slotHaut, 6);

    // Bande couleur joueur
    noStroke();
    fill(COULEURS_JOUEURS[i]);
    rectMode(CORNER);
    rect(sx - slotLarg/2 + 2, sy - slotHaut/2 + 2, 8, slotHaut - 4, 4, 0, 0, 4);
    pop();

    // Numéro joueur
    TexteGauche("Joueur " + (i+1), sx - slotLarg/2 + 25, sy - 15, 20, COULEURS_JOUEURS[i]);

    // Description input
    String desc = inputManager.DescriptionJoueur(i);
    boolean actif = inputManager.JoueurActif(i);
    TexteGauche(desc, sx - slotLarg/2 + 25, sy + 15, 16,
                actif ? COULEUR_UI_TEXTE : COULEUR_UI_TEXTE_DIM);

    // Indicateur statut
    push();
    noStroke();
    fill(actif ? #66BB6A : #555555);
    ellipse(sx + slotLarg/2 - 30, sy, 16, 16);
    pop();

    // Bouton retirer manette
    if (actif && inputManager.joueurs[i].utiliseManette) {
      Bouton bRetirer = new Bouton("X", sx + slotLarg/2 - 70, sy, 30, 30);
      bRetirer.texteTaille = 14;
      bRetirer.Affichage();
      if (bRetirer.SourisDessus() && mousePressed) {
        inputManager.joueurs[i].RetirerManette();
      }
    }
    // Bouton retirer/réassigner clavier
    if (inputManager.joueurs[i].clavier != null) {
      Bouton bRetirerClav = new Bouton("- Clavier", sx + slotLarg/2 - 150, sy, 90, 28);
      bRetirerClav.texteTaille = 12;
      bRetirerClav.Affichage();
      if (bRetirerClav.SourisDessus() && mousePressed) {
        inputManager.joueurs[i].RetirerClavier();
      }
    } else if (!inputManager.joueurs[i].utiliseManette && (i == 0 || i == 1)) {
      Bouton bAjouterClav = new Bouton("+ Clavier", sx + slotLarg/2 - 150, sy, 90, 28);
      bAjouterClav.texteTaille = 12;
      bAjouterClav.Affichage();
      if (bAjouterClav.SourisDessus() && mousePressed) {
        if (i == 0) {
          inputManager.joueurs[0].AssignerClavier(
            new ToucheClavier('z'), new ToucheClavier('s'),
            new ToucheClavier('q'), new ToucheClavier('d'),
            new ToucheClavier('c'), new ToucheClavier('v'));
        } else {
          inputManager.joueurs[1].AssignerClavier(
            new ToucheClavier(UP), new ToucheClavier(DOWN),
            new ToucheClavier(LEFT), new ToucheClavier(RIGHT),
            new ToucheClavier(ENTER), new ToucheClavier(SHIFT));
        }
      }
    }
  }

  // Section manettes détectées
  float sectionY = debutY + MAX_JOUEURS * (slotHaut + 15) + 20;
  TexteCentre("Manettes detectees: " + manettesDetectees.size(), LARGEUR/2, sectionY, 18, COULEUR_UI_TEXTE);

  if (manettesDetectees.size() == 0) {
    TexteCentre("Aucune manette detectee", LARGEUR/2, sectionY + 30, 14, COULEUR_UI_TEXTE_DIM);
    TexteCentre("Branchez une manette USB puis cliquez SCANNER", LARGEUR/2, sectionY + 50, 14, COULEUR_UI_TEXTE_DIM);
  } else {
    for (int i = 0; i < manettesDetectees.size(); i++) {
      ManetteNative m = manettesDetectees.get(i);
      String status = m.connectee ? "[Connectee]" : "[Deconnectee]";
      TexteCentre(m.nom + " " + status, LARGEUR/2, sectionY + 25 + i * 22, 14,
                  m.connectee ? #66BB6A : #EF5350);

      // Auto-assignation : si la manette n'est pas assignée, afficher "Appuyez un bouton..."
      if (m.connectee && !ManetteEstAssignee(m)) {
        if (m.UnBoutonPresse()) {
          AssignerManetteAuProchainSlot(m);
        }
      }
    }
  }

  // Boutons
  menuManettes.MettreAJour();
  menuManettes.Affichage();
}

boolean ManetteEstAssignee(ManetteNative m) {
  for (int i = 0; i < MAX_JOUEURS; i++) {
    if (inputManager.joueurs[i].manette == m) return true;
  }
  return false;
}

void AssignerManetteAuProchainSlot(ManetteNative m) {
  // D'abord un slot complètement vide (pas de clavier, pas de manette)
  for (int i = 0; i < MAX_JOUEURS; i++) {
    PlayerInput pi = inputManager.joueurs[i];
    if (!pi.utiliseManette && pi.clavier == null) {
      pi.AssignerManette(m);
      return;
    }
  }
  // Sinon, premier slot sans manette (même avec clavier)
  for (int i = 0; i < MAX_JOUEURS; i++) {
    PlayerInput pi = inputManager.joueurs[i];
    if (!pi.utiliseManette) {
      pi.AssignerManette(m);
      return;
    }
  }
}

void Clic_MenuManettes() {
  if (menuManettes == null) return;

  Bouton bScanner = menuManettes.elements.get(0);
  Bouton bRetour = menuManettes.elements.get(1);

  if (bScanner.SourisDessus()) {
    ScannerManettes();
  }
  if (bRetour.SourisDessus()) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}

void Clavier_MenuManettes(char k, int kc) {
  if (k == BACKSPACE || k == ESC) {
    ChangerEtat(Etat.MENU_PRINCIPAL);
  }
}
