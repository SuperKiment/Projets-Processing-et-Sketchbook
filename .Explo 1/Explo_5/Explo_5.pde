Terrain Dim0 = new Terrain(0);
Terrain Dim1 = new Terrain(1);
PImage icone;
PImage loading;
PImage ImMob1;
boolean jeuActif = true;
boolean cycleJourNuit = false;

PFont fontStart;
PFont Paul;

String[] ListeBlocs;

void setup() {
  size(1800, 1000, P3D);
  //fullScreen();
  background(0);
  try {
    image(loading, 0, 0);
    surface.setIcon(icone);
  }
  catch(Exception e) {
    println("Pas de loading");
  }

  hint(ENABLE_DEPTH_SORT);

  mapDim0.lines = loadStrings(mapDim0.dimension);      //Initialisation des valeurs pour le fichier map.txt

  IniImages();

  fontStart = createFont("Fonts/Freedom-10eM.ttf", 50);
  Paul = createFont("Fonts/Paul-le1V.ttf", 50);



  TitePhrases();
  surface.setResizable(true);


  Dim0.InitGrille(10, 10);
  Dim0.Grille[5][7] = "sol";


  Dim1.InitGrille(17, 12);
  Dim1.Grille[1][7] = "sol";
  Dim1.Grille[3][8] = "sol";


  mapDim0.GrilleRecup();
  mapDim1.GrilleRecup();

  Dim0.IniGrille2C();

  BarreInventaireIni();

  MenuStart.PlacementMenu(width/2, height/2, width*3/4, height*3/4);

  ListeBlocs = RecupFichierListe("Blocs/Blocs_Liste.txt");

  MobIni();
}


int compteurFrames = 0;


void draw() {
  background(#90F7FF);
  cursor(ARROW);

  if (cycleJourNuit) {
    Soleil.HeureChange();
    Soleil.Lumiere();
    Soleil2.HeureChange();
    Soleil2.Lumiere();
    Lune.HeureChange();
    Lune.Lumiere();
    Lune2.HeureChange();
    Lune2.Lumiere();
  }

  //lights();

  if (jeuActif) {
    DimensionsAffichage();
    JoueurFonctions();
    Loup();
    MobsFonctions();
    BoutonsConstant();
    BarreInventaireAffichage();
    barreInventaire.SelectBarreInv();
  } else {
    noLights();
    MenuStart.Affichage();
  }

  push();
  translate(0, 0, 25);
  pop();

  noLights();
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
