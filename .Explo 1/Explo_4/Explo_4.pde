Terrain Dim0 = new Terrain(0);
Terrain Dim1 = new Terrain(1);
PImage icone;
PImage loading;
PImage ImMob1;
boolean jeuActif = false;

PFont fontStart;

String[] ListeBlocs;

void setup() {
  size(1800, 1000, P3D);
  //fullScreen();
  background(0);

  mapDim0.lines = loadStrings(mapDim0.dimension);      //Initialisation des valeurs pour le fichier map.txt

  IniImages();

  fontStart = createFont("Fonts/Freedom-10eM.ttf", 50);

  try {
    image(loading, 0, 0);
    surface.setIcon(icone);
  }
  catch(Exception e) {
    println("Pas de loading");
  }

  TitePhrases();
  surface.setResizable(true);


  Dim0.InitGrille(10, 10);
  Dim0.Grille[5][7] = "sol";

  Dim1.InitGrille(17, 12);
  Dim1.Grille[1][7] = "sol";
  Dim1.Grille[3][8] = "sol";


  mapDim0.GrilleRecup();
  mapDim1.GrilleRecup();

  BarreInventaireIni();

  MenuStart.PlacementMenu(width/2, height/2, width*3/4, height*3/4);

  ListeBlocs = RecupFichierListe("Blocs/Blocs_Liste.txt");

  MobIni();
}


int compteurFrames = 0;


void draw() {
  background(#90F7FF);
  cursor(ARROW);

  if (jeuActif) {
    DimensionsAffichage();
    JoueurFonctions();
    Loup();
    MobsFonctions();
    BoutonsConstant();
    BarreInventaireAffichage();
    barreInventaire.SelectBarreInv();
  } else {
    MenuStart.Affichage();
  }

Bam3D(3, 3);

  Debug();


  //compteurFrames++;
  //println(compteurFrames);

  /*
  push();
   color backPasOufTuVois = color(0, 0, 0, 5);
   fill(backPasOufTuVois);
   rect(-1000, -1000, 20000, 20000);
   pop();*/
}


void Bam3D(int x, int y) {
  push();
  TranslateArPl();
  translate(x*50, y*50);
  fill(255, 0, 0);
  box(50);
  pop();
}
