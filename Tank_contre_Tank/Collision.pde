// ============================================
// Collision.pde - Utilitaires de collision
// ============================================

boolean PointDansRect(float px, float py, float rx, float ry, float rtx, float rty) {
  return (px > rx - rtx/2 && px < rx + rtx/2 &&
          py > ry - rty/2 && py < ry + rty/2);
}

// Détermine de quel côté du rectangle se trouve le point
// Retourne "haut", "bas", "gauche", "droite" ou "dedans"
String CoteRect(float px, float py, float rx, float ry, float rtx, float rty) {
  // Distances aux 4 bords
  float dGauche = abs(px - (rx - rtx/2));
  float dDroite = abs(px - (rx + rtx/2));
  float dHaut   = abs(py - (ry - rty/2));
  float dBas    = abs(py - (ry + rty/2));

  float minDist = min(min(dGauche, dDroite), min(dHaut, dBas));

  if (minDist == dGauche) return "gauche";
  if (minDist == dDroite) return "droite";
  if (minDist == dHaut)   return "haut";
  if (minDist == dBas)    return "bas";

  return "dedans";
}

boolean CollisionCercles(float x1, float y1, float r1, float x2, float y2, float r2) {
  return dist(x1, y1, x2, y2) < r1 + r2;
}

// Réflexion d'angle sur un mur selon le côté touché
float ReflexionAngle(float angle, String cote) {
  if (cote.equals("gauche") || cote.equals("droite")) {
    return PI - angle;
  }
  if (cote.equals("haut") || cote.equals("bas")) {
    return -angle;
  }
  return angle;
}
