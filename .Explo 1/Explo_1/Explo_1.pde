Terrain Dim0 = new Terrain();
PImage icone;
PImage loading;

void setup() {
  size(1000, 1000);
  background(0);
  icone = loadImage("icone.png");
  loading = loadImage("Loading.png");

  image(loading, 0, 0);

  surface.setTitle("Explorer n°1 !");
  surface.setResizable(true);
  surface.setIcon(icone);

  Dim0.InitGrille(10, 10);
  Dim0.Grille[5][7] = "sol";

  /*
  lines = loadStrings(fichier);      //Initialisation des valeurs pour le fichier map.txt
   linesZero = lines[0];
   println(linesZero.length()/2);
   println(lines.length);
   */
}


int compteurFrames = 0;


void draw() {
  background(#90F7FF);

  Dim0.Affichage();

  JoueurFonctions();
  BoutonsConstant();

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
