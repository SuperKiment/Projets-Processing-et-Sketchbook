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
float DELAI_FIN_MANCHE = 2000; // ms avant prochaine manche
