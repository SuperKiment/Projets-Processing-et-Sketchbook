// ============================================
// Menu_UI.pde - Composants UI réutilisables
// ============================================

// --- Bouton ---

class Bouton {
  float x, y, largeur, hauteur;
  String texte;
  boolean survole = false;
  boolean selectionne = false; // pour navigation manette/clavier
  float texteTaille;
  float hoverAnim = 0; // animation hover 0→1

  Bouton(String t, float nx, float ny, float nl, float nh) {
    texte = t;
    x = nx;
    y = ny;
    largeur = nl;
    hauteur = nh;
    texteTaille = nh * 0.4;
  }

  void Affichage() {
    survole = SourisDessus();

    // Animation smooth du hover
    float cible = (survole || selectionne) ? 1.0 : 0.0;
    hoverAnim = lerp(hoverAnim, cible, 0.2);

    push();
    rectMode(CENTER);

    // Scale au hover
    float sc = 1.0 + hoverAnim * 0.05;
    translate(x, y);
    scale(sc);

    // Fond
    color fondCouleur = lerpColor(COULEUR_UI_PANNEAU, COULEUR_UI_ACCENT, hoverAnim);
    fill(fondCouleur);
    color bordCouleur = lerpColor(COULEUR_UI_BORD, COULEUR_UI_ACCENT, hoverAnim * 0.6);
    stroke(bordCouleur);
    strokeWeight(2);
    rect(0, 0, largeur, hauteur, 8);

    // Lueur au hover
    if (hoverAnim > 0.01) {
      noFill();
      stroke(COULEUR_UI_ACCENT, (int)(40 * hoverAnim));
      strokeWeight(4);
      rect(0, 0, largeur + 4, hauteur + 4, 10);
    }

    // Texte
    fill(COULEUR_UI_TEXTE);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(texteTaille);
    text(texte, 0, -2);

    pop();
  }

  boolean SourisDessus() {
    return sourisX > x - largeur/2 && sourisX < x + largeur/2 &&
           sourisY > y - hauteur/2 && sourisY < y + hauteur/2;
  }

  boolean EstClique() {
    return survole && (mousePressed && mouseButton == LEFT);
  }
}

// --- Selecteur Menu (navigation clavier/manette) ---

class SelecteurMenu {
  ArrayList<Bouton> elements = new ArrayList<Bouton>();
  int indexActuel = 0;
  boolean stickActif = false;
  float deadzone = 0.5;
  // Anti-rebond clavier
  boolean toucheBasActif = false;
  boolean toucheHautActif = false;

  void AjouterBouton(Bouton b) {
    elements.add(b);
  }

  void MettreAJour() {
    // Mettre à jour la sélection visuelle
    for (int i = 0; i < elements.size(); i++) {
      Bouton b = elements.get(i);
      b.selectionne = (i == indexActuel);
      // La souris prend le dessus si elle survole un bouton
      if (b.survole) {
        indexActuel = i;
      }
    }
  }

  void Haut() {
    if (elements.size() == 0) return;
    indexActuel = (indexActuel - 1 + elements.size()) % elements.size();
  }

  void Bas() {
    if (elements.size() == 0) return;
    indexActuel = (indexActuel + 1) % elements.size();
  }

  void Gauche() {
    Haut(); // Réutilisé pour grilles
  }

  void Droite() {
    Bas();
  }

  Bouton BoutonActuel() {
    if (elements.size() == 0) return null;
    return elements.get(indexActuel);
  }

  // Navigation via axe analogique (manette)
  void NavigationAnalog(float axeY) {
    if (abs(axeY) < deadzone) {
      stickActif = false;
    } else if (!stickActif) {
      if (axeY < -deadzone) Haut();
      if (axeY > deadzone) Bas();
      stickActif = true;
    }
  }

  void Affichage() {
    for (Bouton b : elements) {
      b.Affichage();
    }
  }
}

// --- Utilitaires texte ---

void TexteCentre(String t, float x, float y, float taille, color c) {
  push();
  fill(c);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(taille);
  text(t, x, y);
  pop();
}

void TexteGauche(String t, float x, float y, float taille, color c) {
  push();
  fill(c);
  noStroke();
  textAlign(LEFT, CENTER);
  textSize(taille);
  text(t, x, y);
  pop();
}
