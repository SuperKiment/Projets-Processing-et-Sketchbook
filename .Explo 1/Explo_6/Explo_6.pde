Terrain Dim0 = new Terrain(0);
Terrain Dim1 = new Terrain(1);
PImage icone;
PImage loading;
PImage ImMob1;
boolean jeuActif = true;
boolean cycleJourNuit = true;

PFont fontStart;
PFont Paul;

String[] ListeBlocs;

void setup() {
  println("DEBUT SETUP -----------------------------------------------");
  size(1800, 1000, P3D);
  //fullScreen();
  background(0);

  try {
    loading = loadImage("Loading.png");
    image(loading, 0, 0);
    surface.setIcon(icone);
  }//                                  Image de Loading
  catch(Exception e) {
    println("Pas de loading");
  }

  //hint(ENABLE_DEPTH_SORT);   //Poour faire du transparent

  mapDim0.lines = loadStrings(mapDim0.dimension);      //Initialisation des valeurs pour le fichier map.txt

  IniImages();        //Recupération de toutes les images (Blocs)

  try {
    fontStart = createFont("Fonts/Freedom-10eM.ttf", 50);//Polices de caractères
    Paul = createFont("Fonts/Paul-le1V.ttf", 50);
  }
  catch (Exception e) {
    println("Pas de font");
  }



  TitePhrases();  //                  Paramètres de la fenetre
  surface.setResizable(true);


  Dim0.InitGrille(10, 10);
  //Dim0.Grille[5][7] = "sol";  //Création de la grille de Dim0


  Dim1.InitGrille(17, 12);     //Création de la grille de Dim1
  //Dim1.Grille[1][7] = "sol";
  //Dim1.Grille[3][8] = "sol";


  mapDim0.GrilleRecup();  //Recupération de la map à partir des fichiers
  mapDim1.GrilleRecup();

  Dim0.IniGrille2C();    //Initialisation de la deuxieme couche de la map (feuilles etc

  BarreInventaireIni();   //Initialisation de la barre d'inventaire

  StockageIni();

  MenuStart.PlacementMenu(width/2, height/2, width*3/4, height*3/4);    //Initialisation du menu de départ

  ListeBlocs = RecupFichierListe("Blocs/Blocs_Liste.txt");          //Récupération de la lidte complète des blocs

  MobIni();   //temp - Ini du mob

  println("FIN SETUP -----------------------------------------");
}


int compteurFrames = 0;     //Un compteur pour voir si le prgrm tourne


void draw() {
  background(#90F7FF);
  cursor(ARROW);

  Chrono5s();   //Toutes les 5s, un boolean passe en true pour une frame

  if (chrono5s) UpdatesGrilles();   //Update des grilles toutes les 5s

  if (cycleJourNuit) {
    Soleil.HeureChange();       //Cycle jour-nuit
    Soleil.Lumiere();
    Soleil2.HeureChange();
    Soleil2.Lumiere();
    Lune.HeureChange();
    Lune.Lumiere();
    Lune2.HeureChange();
    Lune2.Lumiere();
  }

  //lights();

  if (jeuActif) {  //Si le jeu est lancé
    DimensionsAffichage();       //Affichage de la map
    ItemsAuSol();
    JoueurFonctions();//Fonctions du joueur
    Loup();//Fonctions du Loup
    MobsFonctions();//Fonctions du mob

    //-------------------------------------------------------INTERFACES

    BoutonsConstant();//Fonctions des boutons
    BarreInventaireAffichage();//Affichage de la barre d'inventaire
    barreInventaire.SelectBarreInv();//Fonction de la barre d'inv
    StockageInterfaces();
  } else {
    noLights();             //Sinon on met le menu - temp
    MenuStart.Affichage();
  }

  push();
  translate(0, 0, 25);         //Au cas où tu veux tester un truc
  pop();

  noLights();  //Et le debug
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
