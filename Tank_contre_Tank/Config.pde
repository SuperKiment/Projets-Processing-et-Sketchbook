// ============================================
// Config.pde - Constantes globales et réglages
// ============================================

// --- Ecran ---
final int LARGEUR = 1080;
final int HAUTEUR = 720;

// --- Debug ---
boolean DEBUG_MODE = false;
   
// --- Couleurs Menu ---
color COULEUR_FOND_MENU = #0F0F23;
color COULEUR_UI_PANNEAU = #1A1A2E;
color COULEUR_UI_ACCENT = #E94560;
color COULEUR_UI_TEXTE = #FFFFFF;
color COULEUR_UI_TEXTE_DIM = #888888;
color COULEUR_UI_SURVOL = #16213E;
color COULEUR_UI_BORD = #333355;

// --- Couleurs Jeu ---
color COULEUR_FOND_JEU = #000000;
color COULEUR_MUR = #969696;

// --- Couleurs Joueurs ---
color[] COULEURS_JOUEURS = { #4FC3F7, #EF5350, #66BB6A, #FFA726 };

// --- Gameplay ---
final int MAX_JOUEURS = 4;
int SCORE_VICTOIRE = 5;
float DELAI_FIN_MANCHE = 5000; // ms avant prochaine manche

// --- Paramètres visuels ---
boolean paramJourNuitAleatoire = true;   // alternance jour/nuit aléatoire chaque manche
boolean paramCouleursAleatoires = true; // changement de palette entre les manches
boolean modeJour = false;               // état actuel de la manche (jour = pas d'assombrissement)

// --- Taille de map ---
int paramTailleMap = 100; // pourcentage (50-200), 100 = normal

float echelleMap() {
  return 100.0 / paramTailleMap;
}

// Palettes de couleurs pour variation entre manches
// { fondNuit, murNuit, fondJour, murJour }
color[][] PALETTES_COULEURS = {
  { #0A0A14, #707088, #B8B0A0, #5A5A6E },  // Urbaine
  { #0D1117, #3B5998, #A0A8B0, #4A5A7A },  // Bunker
  { #0B1A0B, #556B2F, #7A9A5A, #4A5A30 },  // Militaire
  { #1A1408, #A0522D, #D4C4A0, #8B5E3C },  // Désert
  { #120A18, #8B668B, #C0B0C8, #6A5A7A },  // Néon
  { #000000, #969696, #C0C0C0, #606060 },  // Classique
  { #1A0A0A, #CC4444, #C8A090, #994444 },  // Volcan
  { #0A1A1A, #44AAAA, #B0D0D0, #448888 },  // Arctique
  { #141400, #AAAA44, #D8D0A0, #888844 },  // Sable
  { #0F0505, #BB6633, #C4A888, #885533 },  // Rouille
};
