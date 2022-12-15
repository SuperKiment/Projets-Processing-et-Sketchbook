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
  CreationGrilles();
  AjouterBloc(3, 4, 100, false);
  AjouterPantin(5.5, 5, 40, false);
}


void draw() {
  grilleActive = ToutesGrilles.get(noGrilleActive);
  background(#6FE8FF);

  Interface();

  translateX = width/2-(grilleActive.taillex*grilleActive.tailleRect)/2;
  translateY = height/2-(grilleActive.taillex*grilleActive.tailleRect)/2;
  translate(translateX, translateY);

  grilleActive.Affichage();
  JoueurFonctions();
  PantinFonctions();
  BlocFonctions();
  Explosions();

  pointeurDev.PointeurDevFonctions();

  /*
  DebugBloc();
   joueur.Debug();
   pointeurDev.Debug();
   println("Fin frame --------------------------------------------------------");*/
}

//----------------------------------------------------------------------------------------------

float ConvPixelGrille(float x) {
  x = x/grilleActive.tailleRect;
  return x;
}
float ConvGrillePixel(float x) {
  x = x*grilleActive.tailleRect;
  return x;
}

int Arrondir(float x1) {
  int posx;

  if (x1 < int(x1)+0.5) 
    posx = int(x1);
  else posx = ceil(x1);

  return posx;
}
