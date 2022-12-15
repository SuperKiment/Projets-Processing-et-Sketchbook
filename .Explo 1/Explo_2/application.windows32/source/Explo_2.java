import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Explo_2 extends PApplet {

Terrain Dim0 = new Terrain(0);
Terrain Dim1 = new Terrain(1);
PImage icone;
PImage loading;
PImage ImageMob1;
boolean jeuActif = false;

String[] ListeBlocs;

public void setup() {
  
  background(0);

  mapDim0.lines = loadStrings(mapDim0.dimension);      //Initialisation des valeurs pour le fichier map.txt

  IniImages();
  
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

  MenuStart.PlacementMenu(width/2, height/2, width*3/4, height*3/4);

  ListeBlocs = RecupFichierListe("Blocs/Blocs_Liste.txt");
}


int compteurFrames = 0;


public void draw() {
  background(0xff90F7FF);


  if (jeuActif) {
    DimensionsAffichage();
    JoueurFonctions();
    MobsFonctions();
    BoutonsConstant();
  } else {
    MenuStart.Affichage();
  }

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

public String[] RecupFichierListe(String location) {
  String Liste[];
  Liste = loadStrings(location);

  for (int i = 0; i<Liste.length; i++) {
    print(Liste[i] + " / ");
  }

  return Liste;
}

public String[] RecupFichierTextures(String location) {
  String Liste[];

  Liste = loadStrings(location);

  return Liste;
}

public PImage RecupTexture(String nom) {
  PImage image;

  image = loadImage("Textures/"+ nom + ".png");

  return image;
}

class Bloc {

  PImage texture;
  String nom;
  boolean collision, degats, ralenti;
  int degatsDelt;
  int ID;

  Bloc(String newnom, int id) {
    nom = newnom;

    ID = id;
  }
}

PImage imEau_claire;
PImage imHerbe;
PImage imSol;
PImage imRoche;
PImage imArbre;
PImage imEau;
PImage imEau_profonde;
PImage imFeuilles;
PImage imMur;
PImage imPiques;

public void IniImages() {
  try {
    imHerbe = RecupTexture("herbe");
    imSol = RecupTexture("sol");
    imRoche = RecupTexture("roche");
    imArbre = RecupTexture("arbre");
    imEau = RecupTexture("eau");
    imEau_claire = RecupTexture("eau claire");
    imEau_profonde = RecupTexture("eau profonde");
    imFeuilles = RecupTexture("feuilles");
    imMur = RecupTexture("mur");
    imPiques = RecupTexture("piques");
    loading = loadImage("Loading.png");
    icone = loadImage("icone.png");
  } 
  catch(Exception e) {
    println("Pas réussi à charger les images");
  }
}

class Bouton {

  int x, y, taille;
  boolean click = false;

  Bouton(int newx, int newy, int newtaille) {
    x = newx;
    y = newy;
    taille = newtaille;
  }

  public void Affichage(int couleur) {
    push();
    fill(couleur);
    rectMode(CORNER);
    rect(x, y, taille, taille);
    pop();
  }

  public void DetectionSourisP() {
    if (mousePressed == true && mouseButton == LEFT) {
      click = true;
    } else click = false;
  }

  public void Curseur() {
    if (mouseX > x && mouseY > y && mouseX < x+taille && mouseY < y+taille) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
}




Bouton bouton1 = new Bouton(200, 200, 50);

public void BoutonsConstant() {
  bouton1.Affichage(color(0, 255, 0));
  bouton1.Curseur();
}

public void BoutonsDetection() {
  bouton1.DetectionSourisP();
}
public void ChangementDim(int dimension) {
  
  joueur1.ResetPos();

  switch (dimension) {

  case 0 :
    dimensionActive = 0;
    break;

  case 1 :
    dimensionActive = 1;
    break;

  case 2 :
    dimensionActive = 2;
    break;

  case 3 :
    dimensionActive = 3;
    break;
  }
  
  
}
/*

Collisions avec tit bloc
deplacement fluide
récup les fichiers des dim et les affiche


*/
public void Debug() {
  push();
  fill(0, 0, 0, 125);
  noStroke();
  rect(0, 0, 200, 500);

  fill(0, 255, 0);
  textSize(10);
  text(joueur1.recupDepl, 0, 10);
  text(joueur1.chronoDepl, 0, 20);
  text(joueur1.stopDepl, 0, 30);
  text(String.valueOf(bouton1.click), 0, 40);
  pop();
}
public void TranslateArPl() {
  translate(-joueur1.xSui+width/2-25, -joueur1.ySui+height/2-25);
}

public void TitePhrases() {
  String[] PhrasesDebut = loadStrings("Random Titres.txt");
  int noRand = PApplet.parseInt(random(0, PhrasesDebut.length-1));

  surface.setTitle(PhrasesDebut[noRand]);
}
class Joueur {
  int x, y, hp = 100;
  float recupDepl, chronoDepl, stopDepl;
  int vitesse = 100;
  boolean haut, bas, droite, gauche, deplacementOk;
  float xSui, ySui, vitesseSui = 10;

  Joueur(int newx, int newy) {
    x = newx;
    y = newy;
    xSui = newx*50;
    ySui = newy*50;
  }

  public void RecupJoueur() {
    stopDepl = millis();
  }

  public void ChronoJoueur() {
    deplacementOk = false;
    chronoDepl = millis() - stopDepl;
    if (chronoDepl >= vitesse) {
      RecupJoueur();
      deplacementOk = true;
    }
  }

  public void LezGoDepl() {
    deplacementOk = true;
  }

  public void DeplacementOn(char depl) {

    switch(depl) {
    case 'z' :
      haut = true;
      break;

    case 'q' :
      gauche = true;
      break;

    case 's' :
      bas = true;
      break;

    case 'd' :
      droite = true;
      break;
    }
  }
  public void DeplacementOff(char depl) {

    switch(depl) {
    case 'z' :
      haut = false;
      break;

    case 'q' :
      gauche = false;
      break;

    case 's' :
      bas = false;
      break;

    case 'd' :
      droite = false;
      break;
    }
  }

  public void DeplacementContinu() {
    if (deplacementOk == true) {
      if (haut   == true && y > 0) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'h')) y--;
      }
      if (bas    == true && y < ValDimensionActuelle("y")-1) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'b')) y++;
      }
      if (gauche == true && x > 0) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'g')) x--;
      }
      if (droite == true && x < ValDimensionActuelle("x")-1) {
        if (VerifCollisionOk(x, y, GrilleDimensionActuelle(), 'd')) x++;
      }
    }
  }

  public void Affichage() {
    push();
    fill(255);
    TranslateJoueur();
    rect(x*50, y*50, 50, 50);
    pop();
  }

  public void Suiveur() {
    push();

    if (x*50>xSui) xSui+=vitesseSui;
    if (x*50<xSui) xSui-=vitesseSui;
    if (y*50>ySui) ySui+=vitesseSui;
    if (y*50<ySui) ySui-=vitesseSui;

    TranslateJoueur();    

    fill(255, 0, 0);
    rect(xSui, ySui, 50, 50);

    pop();
  }

  public void ChangeurDeCouleur() {
    Dim0.Grille[x][y] = "sol";
  }

  public void ResetPos() {
    x = 5;
    y = 5;
    xSui = 500;
    ySui = 500;
  }

  public void TranslateJoueur() {
    translate(-xSui+width/2-25, -ySui+height/2-25);
  }
}

//---------------------------------------------------------------------------------

public void JoueurFonctions() {
  //joueur1.Affichage();
  joueur1.ChronoJoueur();
  joueur1.DeplacementContinu();
  joueur1.Suiveur();
  //joueur1.ChangeurDeCouleur();
}

Joueur joueur1 = new Joueur(5, 5);

public boolean VerifCollisionOk(int x, int y, String Tabl[][], char direction) {
  boolean ok = true;


  switch (direction) {

  case 'd' :
    x++;
    break;

  case 'g' :
    x--;
    break;

  case 'b' :
    y++;
    break;

  case 'h' :
    y--;
    break;
  }

  switch(Tabl[x][y]) {
  case "herbe":
    ok = true;
    break;
  case "sol":
    ok = true;
    break;
  case "roche":
    ok = false;
    break;
  case "arbre":
    ok = false;
    break;
  case "eau":
    ok = true;
    break;
  case "eau claire":
    ok = true;
    break;
  case "eau profonde":
    ok = false;
    break;
  case "feuilles":
    ok = false;
    break;
  case "mur":
    ok = false;
    break;
  case "piques":
    ok = false;
    break;
  }

  return ok;
}

MapDimension mapDim0 = new MapDimension("Plan_Dimension0.txt", Dim0);
MapDimension mapDim1 = new MapDimension("Plan_Dimension1.txt", Dim1);

class MapDimension {

  MapDimension(String newdimension, Terrain newdimensionBase) {
    dimension = newdimension;
    dimensionBase = newdimensionBase;
  }


  String dimension;
  String[] lines;
  String linesZero;
  Terrain dimensionBase;

  public void GrilleRecup() {        //Load la map

    lines = loadStrings(dimension);     //dimension0 dans lines
    linesZero = lines[0];               //linesZero est la 1ere ligne de lines
    println("LineZero : " + linesZero.length()/2);               //Print la taille du doc X
    println(lines.length);                       //Print la taille du doc Y

    dimensionBase.x = linesZero.length()/2; //Rentre les tailles du doc dans le programme
    dimensionBase.y = lines.length;

    dimensionBase.InitGrille(linesZero.length()/2, lines.length);


    println("Plan_Dimension"+dimensionBase.noDim+".txt :");

    //for (int i = 0; i < lines.length; i++) {  //Affiche dans la console le Plan_Dimension0.txt
    //  println(lines[i]);
    //}
    println("there are " + lines.length + " lines");
    println("Lu !  :  " + PApplet.parseInt(random(0, 500)));



    for (int y = 0; y<dimensionBase.y; y++) {
      String[] ligneSimple = split(lines[y], " ");         //Split la ligne y dans ligneSimple pour passer par toutes les cases individuellement

      for (int x = 0; x<dimensionBase.x; x++) {

        //println(ligneSimple[x]);

        if (PApplet.parseInt(ligneSimple[x]) == 0) dimensionBase.Grille[x][y] = "herbe";
        if (PApplet.parseInt(ligneSimple[x]) == 1) dimensionBase.Grille[x][y] = "sol";
        if (PApplet.parseInt(ligneSimple[x]) == 2) dimensionBase.Grille[x][y] = "roche";       //Change les cases par rapport à Plan_Dimension0.txt
        if (PApplet.parseInt(ligneSimple[x]) == 3) dimensionBase.Grille[x][y] = "arbre";
        if (PApplet.parseInt(ligneSimple[x]) == 4) dimensionBase.Grille[x][y] = "eau";
      }
    }
  }
}
/*
void GrilleSave() {
 
 String ajouter[] = new String[nbCasesX];         //Tableau de ligneX-s
 String ligneX = "10000000200000000003";           //Valeur par défaut
 
 for (int y = 0; y<nbCasesY; y++) {
 ligneX = "";                        //Reset de ligneX
 for (int x = 0; x<nbCasesX; x++) {
 
 
 if (Grille[x][y] == "herbe") ligneX += "0 "; 
 if (Grille[x][y] == "terre") ligneX += "1 ";     //Passe par toutes les cases et les ajoute en chaine dans ligneX
 if (Grille[x][y] == "roche") ligneX += "2 ";
 if (Grille[x][y] == "arbre") ligneX += "3 ";
 if (Grille[x][y] == "eau") ligneX += "4 ";
 }
 
 ajouter[y] = ligneX;   //Ajoute ligneX à la case suivante de ajouter
 ligneX = "";           //Reset au cas où
 }
 
 
 saveStrings(fichier, ajouter);        //remplacement de map.txt par ajouter
 
 String[] lines = loadStrings(fichier);     //recupere le fichier remplacé
 
 for (int i = 0; i < lines.length; i++) {
 println(lines[i]);                                  //Affiche dans la console le fichier remplcé pour verif
 }
 
 println("there are " + lines.length + " lines");
 println("Sauvegardé !  :  " + int(random(0, 500)));
 }*/
class Menu {
  
  int x, y, tx, ty;
  
  Menu() {
    
  }
  
  public void Affichage() {
    push();
    strokeWeight(5);
    stroke(190);
    fill(100);
    rectMode(CENTER);
    rect(x, y, tx, ty, 30);
    
    pop();
  }
  
  public void PlacementMenu(int newx, int newy, int newtaillex, int newtailley) {
    x = newx;
    y = newy;
    tx = newtaillex;
    ty = newtailley;
  }
}



Menu MenuStart = new Menu();
Mob mob1 = new Mob(12, 15, "Textures/Mob1.png", 0);

class Mob {

  int x, y, hp = 100, vitesse = 10;
  PImage texture = ImageMob1;
  int dimension = 0;

  Mob(int newx, int newy, String image, int newdimension) {
    x = newx;
    y = newy;
    texture = ImageMob1;
    dimension = newdimension;
  }

  public void Affichage() {
    if (dimensionActive == dimension) {
      push();
      fill(255);
      TranslateArPl();
      try {
        image(ImageMob1, x*50, y*50);
      }
      catch(Exception e) {
        rect(x*50, y*50, 50, 50);
      }
      pop();
    }
  }
}

public void MobsFonctions() {
  mob1.Affichage();
}

int dimensionActive = 0;

class Terrain {

  int x, y;
  String terre, herbe, roche;
  String[][] Grille;
  int compteurGrille = 0;
  int noDim;
  int distAffichage = 20;

  Terrain(int nnodim) {
    noDim = nnodim;
  }

  public void InitGrille(int newx, int newy) {
    x = newx;
    y = newy;
    Grille = new String [newx][newy];

    for (int x1 = 0; x1<x; x1++) {
      for (int y1 = 0; y1 < y; y1++) {
        Grille[x1][y1] = "herbe";
        //println("herbe");

        //compteurGrille++;
        //println(compteurGrille);
      }
    }
  }

  public void Affichage() { 
    for (int x1 = joueur1.x-distAffichage; x1 < joueur1.x+distAffichage; x1++) {
      for (int y1 = joueur1.y-distAffichage; y1 < joueur1.y+distAffichage; y1++) {
        push();

        fill(125);
        TranslateArPl();  

        if (x1 >=0 && y1 >=0 && x1 < x && y1 < y) {

          try {

            switch(Grille[x1][y1]) {
            case "herbe":
              image(imHerbe, x1*50, y1*50);
              break;
            case "sol":
              image(imSol, x1*50, y1*50);
              break;
            case "roche":
              image(imRoche, x1*50, y1*50);
              break;
            case "arbre":
              image(imArbre, x1*50, y1*50);
              break;
            case "eau":
              image(imEau, x1*50, y1*50);
              break;
            }
          }
          catch(Exception e) {
            switch(Grille[x1][y1]) {
            case "herbe":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "sol":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "roche":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "arbre":
              rect(x1*50, y1*50, 50, 50);
              break;
            case "eau":
              rect(x1*50, y1*50, 50, 50);
              break;
            }
          }
        }
        pop();
      }
    }
  }
}

//---------------------------------------------------------------------------------

public Terrain DimensionActuelle() {
  Terrain dimension = Dim1;

  switch (dimensionActive) {
  case 0 :
    dimension = Dim0;
    break;

  case 1 :
    dimension = Dim1;
    break;
  }

  return dimension;
}

public String[][] GrilleDimensionActuelle() {
  Terrain dimension = Dim1;

  switch (dimensionActive) {
  case 0 :
    dimension = Dim0;
    break;

  case 1 :
    dimension = Dim1;
    break;
  }

  return dimension.Grille;
}

public float ValDimensionActuelle(String val) {
  Terrain dimension = Dim1;

  switch (dimensionActive) {
  case 0 :
    dimension = Dim0;
    break;

  case 1 :
    dimension = Dim1;
    break;
  }

  switch (val) {
  case "x" :
    return dimension.x;

  case "y" :
    return dimension.y;
  }

  return 0;
}

public void DimensionsAffichage() {
  switch (dimensionActive) {
  case 0 :
    Dim0.Affichage();
    break;

  case 1 :
    Dim1.Affichage();
    break;
  }
}

public void keyPressed() {
  joueur1.LezGoDepl();
  joueur1.DeplacementOn(key);


  if (key == 'g' && dimensionActive == 0) ChangementDim(1);
  if (key == 't' && dimensionActive == 1) ChangementDim(0);

  if (key == ' ') jeuActif = true;
}

public void keyReleased() {
  joueur1.DeplacementOff(key);
}

public void mousePressed() {
  BoutonsDetection();
}

public void mouseReleased() {
  BoutonsDetection();
}

  public void settings() {  size(1800, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Explo_2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
