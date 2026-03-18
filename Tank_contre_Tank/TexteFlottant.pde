// ============================================
// TexteFlottant.pde - Textes qui flottent et disparaissent
// ============================================

ArrayList<TexteFlottant> AllTextesFlottants = new ArrayList<TexteFlottant>();

class TexteFlottant {
  float x, y;
  String ligne1, ligne2;
  color couleur;
  float timer;
  float duree = 1800;

  TexteFlottant(float nx, float ny, String l1, String l2, color c) {
    x = nx; y = ny;
    ligne1 = l1; ligne2 = l2;
    couleur = c;
    timer = millis();
  }

  void Affichage() {
    float vie = 1.0 - (millis() - timer) / duree;
    vie = constrain(vie, 0, 1);
    float offsetY = (1 - vie) * 60;
    // Ease out
    float alpha = vie * vie;

    push();
    textAlign(CENTER, CENTER);

    // Fond semi-transparent pour lisibilité
    float boxW = max(textWidth(ligne1), ligne2.length() > 0 ? textWidth(ligne2) : 0) + 30;
    float boxH = ligne2.length() > 0 ? 48 : 30;
    fill(0, alpha * 180);
    noStroke();
    rectMode(CENTER);
    rect(x, y - offsetY + (ligne2.length() > 0 ? 10 : 0), max(boxW, 120), boxH, 6);

    // Ombre texte
    fill(0, alpha * 200);
    textSize(18);
    text(ligne1, x + 1, y - offsetY + 1);

    // Nom (plus gros, plus lumineux)
    fill(couleur, alpha * 255);
    textSize(18);
    text(ligne1, x, y - offsetY);

    // Description
    if (ligne2.length() > 0) {
      fill(255, alpha * 200);
      textSize(13);
      text(ligne2, x, y - offsetY + 22);
    }
    pop();
  }

  boolean Mort() {
    return millis() - timer >= duree;
  }
}

void CreerTexteFlottant(float x, float y, String l1, String l2, color c) {
  AllTextesFlottants.add(new TexteFlottant(x, y, l1, l2, c));
}

void Fonctions_TextesFlottants() {
  for (int i = AllTextesFlottants.size() - 1; i >= 0; i--) {
    TexteFlottant t = AllTextesFlottants.get(i);
    t.Affichage();
    if (t.Mort()) AllTextesFlottants.remove(i);
  }
}
