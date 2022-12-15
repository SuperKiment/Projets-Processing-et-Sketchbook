import java.net.*;
import java.io.*;
import java.nio.*;

color backgroundColor = #6FE8FF;
int deux = 2;
int zero = 0;
int un = 1;
int trois = 3;

Inventaire inventaire;

ArrayList<Grille> ToutesGrilles = new ArrayList<Grille>();
ArrayList<Joueur> TousJoueurs = new ArrayList<Joueur>();
ArrayList<Bloc> TousBlocs = new ArrayList<Bloc>();
ArrayList<Explosion> AllExplosions = new ArrayList<Explosion>();
ArrayList<Pantin> AllPantins = new ArrayList<Pantin>();

int noGrilleActive = 0;
Grille grilleActive;

Joueur joueur = new Joueur(5, 1);

float translateX, translateY;

void setup() {
  size(1000, 1000);
  
  inventaire = new Inventaire();

  CreationGrilles();
  AjouterBloc(3, 4, 100);
  AjouterPantin(5.5, 5, 40);
}


void draw() {
  grilleActive = ToutesGrilles.get(noGrilleActive);
  background(backgroundColor);

  push();

  translateX = width/deux-(grilleActive.taillex*grilleActive.tailleRect)/deux;
  translateY = height/deux-(grilleActive.taillex*grilleActive.tailleRect)/deux; 
  translate(translateX, translateY);  //Translate pour tout avoir au milieu de l'écran

  GrilleFonctions();
  JoueurFonctions();
  PantinFonctions();   //Fonctions perm des objets
  BlocFonctions();
  Explosions();
  pointeurDev.PointeurDevFonctions();

  pop();

  Interface();
  /*
  DebugBloc();
   joueur.Debug();
   pointeurDev.Debug();
   println("Fin frame --------------------------------------------------------");*/
}

//----------------------------------------------------------------------------------------------

float ConvPixelGrille(float x) {
  x = x/grilleActive.tailleRect;  //Convertisseur Pixel -> Grille
  return x;
}
float ConvGrillePixel(float x) {
  x = x*grilleActive.tailleRect;  //Convertisseur Grille -> Pixel
  return x;
}

int Arrondir(float x1) {
  int posx;

  if (x1 < int(x1)+un/deux)           //Arrondisseur made by Kiment
    posx = int(x1);               //Utilisé pour trouver une valeur de grille
  else posx = ceil(x1);

  return posx;
}
