import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Paper_mdr extends PApplet {

boolean start = false;
boolean gagne = false;

public void setup() {
  frameRate(300);
  
  background(0);
  rectMode(CENTER);
  //InitGrille();
  
  server = new Server(this, 5204);
  surface.setTitle("Paper de Kiment Server");
}

public void draw() {
  Serv();
  if (start == false) {
    background(0);
    Interface();
    push();
    textSize(30);
    fill(255);
    text("'ESPACE' POUR DEMARRER", width/2-180, height/3);
    pop();
  }
  //AffichageGrille();

  Affichage_Joueurs();
  joueur.Affichage();



  if (start == true) {
    Chrono();
    joueur.Deplacement();

    if (ID1 != 0) joueur2.Deplacement();
    if (ID2 != 0) joueur3.Deplacement();
  }

  //if (start == true) text("true", 10, 10);
  //if (start == false) text("false", 10, 10);
  if (gagne == true) Gagne();




  //if (start == false) Debug();
}
class Bot {

  float x;
  float y;
  int vitesse = 1;
  char orientation = 'd';
  int couleur;
  int couleurligne;

  float coorPt1 = 100;
  float coorPt2 = 200;

  Bot(int newcouleur, float newx, float newy) {
    couleur = newcouleur;
    x = newx;
    y = newy;
  }

  public void Affichage() {
    push();

    translate(x, y);
    float orientation2 = 0;
    if (orientation == 'd') orientation2 = 0;
    if (orientation == 'g') orientation2 = PI;
    if (orientation == 'h') orientation2 = PI/2;
    if (orientation == 'b') orientation2 = 3*PI/2;
    rotate(-orientation2);
    noStroke();
    fill(couleurligne - 100);
    rect(20, 0, 20, 60);

    pop();

    push();

    strokeWeight(3);
    fill(couleur);
    stroke(couleurligne);

    rect(x, y, 50, 50);

    pop();
  }

  public void D() {
    if (orientation != 'g') orientation = 'd';
  }
  public void G() {
    if (orientation != 'd') orientation = 'g';
  }
  public void H() {
    if (orientation != 'b') orientation = 'h';
  }
  public void B() {
    if (orientation != 'h') orientation = 'b';
  }

  public void Deplacement() {
    if (orientation == 'd') x += vitesse;
    if (orientation == 'g') x -= vitesse;
    if (orientation == 'h') y -= vitesse;
    if (orientation == 'b') y += vitesse;

    if (x < 0) x++;
    if (x > 1000) x--;
    if (y < 0) y++;
    if (y > 1000) y--;
  }
}
int tempsgo = 0;
int compteur = 10;
int secondes = 0;

int triche = 0;



public void Chrono() {

  //int postsecondes = secondes;
  int limite = 180;

  secondes = PApplet.parseInt((millis() - tempsgo)/1000) + triche;

  push();
  noStroke();
  fill(255);
  rect(500, 50, 200, 50, 20);

  fill(2);
  textSize(40);
  text(secondes, 480, 64);
  pop();

  if (secondes >= limite) {
    start = false;
    gagne = true;
  }

  /*
  if (compteur == 200) {
   Verif(1000000);
   println("Verifié !");
   }
   
   if (compteur == 210) {
   println("Remis !");
   //Remise();
   compteur = 0;
   }
   
   if (postsecondes != secondes) {
   compteur++;
   println("compteur : " + compteur);
   postsecondes = secondes;
   }
   
   postsecondes = secondes;*/
}
public void keyPressed() {
  if (key == 'd') joueur.D();
  if (key == 'q') joueur.G();
  if (key == 'z') joueur.H();
  if (key == 's') joueur.B();

  /*
  if (key == 't') Verif(joueur.couleur, color(1), color(2), color(3));
   if (key == 'y') Verif(joueur.couleur, color(1), color(2), color(3));*/
  if (key == 'g') background(0, 255, 0);

  if (key == ' ' && start == false) {
    start = true;
    tempsgo = millis();
  }

  if (key == 'h') triche += 10;
  if (key == 'k') gagne = true;
}
public void Debug() {
  push();

  fill(50, 50, 50, 50);
  noStroke();
  rect(0, 0, 1000, 300);

  fill(0, 255, 0);
  textSize(10);

  text("ID1 " + ID1, 10, 20); 
  text("ID2 " + ID2, 10, 30); 
  text("dataIn " + dataIn, 10, 40);

  if (DataIn[1] != null) {
    if (PApplet.parseFloat(DataIn[1]) == ID1) text("DataIn[0] ID1 : " + DataIn[0], 10, 50);
    if (PApplet.parseFloat(DataIn[1]) == ID2) text("DataIn[0] ID2 : " + DataIn[0], 10, 60);
  }

  text("dataIn1 " + dataIn1, 10, 70);
  text("dataIn2 " + dataIn2, 10, 80);
  
  text("dataOut " + dataOut, 10, 90);

  pop();
}
/*
color[][] Grille = new color [1000][1000];
 
 void InitGrille() {
 for (int x = 0; x<1000; x++) {
 for (int y = 0; y<1000; y++) {
 Grille[x][y] = color(0, 0, 0);
 }
 }
 }
 
 void AffichageGrille() {
 for (int x = 0; x<1000; x++) {
 for (int y = 0; y<1000; y++) {
 push();
 fill(Grille[x][y]);
 noStroke();      
 square(x, y, 1);
 pop();
 }
 }
 }
 */

int coulVerif = color(255, 0, 0);


public int[] Verif (int coulJ1, int coulJ2, int coulJ3, int coulJ4) {
  int compteurVerif = 0;
  int [] Resultats = new int[5];

  for (int x = 0; x<1000; x++) {
    for (int y = 0; y<1000; y++) {
      int couleurloc = get(x, y);
      if (couleurloc == coulJ1) {
        Resultats[0] ++;
      }
      if (couleurloc == coulJ2) {
        Resultats[1] ++;
      }
      if (couleurloc == coulJ3) {
        Resultats[2] ++;
      }
      if (couleurloc == coulJ4) {
        Resultats[3] ++;
      }
    }
  }
  println("compteurVerif : " + compteurVerif); 
  //if (compteurVerif == 0) start = false;

  for (int i = 0; i<4; i++) {
    println("Pixels J" + (i+1) + " : " + Resultats[i]);
  }

  Resultats[4] = compteurVerif;
  return Resultats;
}

//-------------------------------------------------------------------------------------------

//Gagne

boolean verifie = false;

int[] ResultatsFin = new int [5];
int[] Proportion = new int [4];

public void Gagne() {

  if (verifie == false) {
    verifie = true;
    ResultatsFin = Verif(joueur.couleurligne, joueur2.couleurligne, joueur3.couleurligne, color(30));
  }

  push();

  fill(50);
  noStroke();

  rect(500, 500, 530, 200, 50);

  fill(255);
  textSize(23);

  text("Nombre de pixels remplis : " + ResultatsFin[4], 341, 431);

  for (int i = 0; i<4; i++) {
    text("Joueur " + (i+1)  + " : " + ResultatsFin[i], 408, 470+i*20);
  }

  pop();
}




/*
void Remise() {
 for (int x = 0; x<1000; x++) {
 for (int y = 0; y<1000; y++) {
 color couleurloc = get(x, y);
 if (couleurloc == color(coulVerif)) { 
 push();
 noStroke();
 fill(0, 0, 0);
 square(x, y, 1);
 println("Remis sûr mdr");
 pop();
 }
 }
 }
 }
 */
public void Interface() {

  push();

  stroke(200, 200, 200, 125);
  textSize(12);

  if (ID1 != 0) fill(0, 255, 0, 255);
  else fill(255, 0, 0, 125);
  text("Joueur 1 : ", 906, 24);
  ellipse(980, 20, 20, 20);
  
  if (ID2 != 0) fill(0, 255, 0, 255);
  else fill(255, 0, 0, 125);
  text("Joueur 2 : ", 906, 24+27);
  ellipse(980, 020+30, 20, 20);

  pop();
}
Joueur joueur = new Joueur(color(PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255))), 500, 500);

class Joueur {

  float x, y;
  float xspawn, yspawn;
  int vitesse = 1;
  char orientation = 'd';
  int couleur;
  int couleurligne;
  int couleurVerif;

  float coorPt1 = 100;
  float coorPt2 = 200;

  Joueur(int newcouleur, float newx, float newy) {
    couleur = newcouleur;
    couleurligne = couleur-125;
    couleurVerif = couleurligne-100;
    x = newx;
    y = newy;
    xspawn = newx;
    yspawn = newy;
  }

  public void Affichage() {
    push();

    translate(x, y);
    float orientation2 = 0;
    if (orientation == 'd') orientation2 = 0;
    if (orientation == 'g') orientation2 = PI;
    if (orientation == 'h') orientation2 = PI/2;
    if (orientation == 'b') orientation2 = 3*PI/2;
    rotate(-orientation2);
    noStroke();
    fill(couleurVerif);
    rect(20, 0, 20, 60);

    pop();

    push();

    strokeWeight(3);
    fill(couleur);
    stroke(couleurligne);

    rect(x, y, 50, 50);

    pop();

    if (start == false) {
      x = xspawn;
      y = yspawn;
    }
  }

  public void D() {
    if (orientation != 'g') orientation = 'd';
  }
  public void G() {
    if (orientation != 'd') orientation = 'g';
  }
  public void H() {
    if (orientation != 'b') orientation = 'h';
  }
  public void B() {
    if (orientation != 'h') orientation = 'b';
  }

  public void Deplacement() {
    if (orientation == 'd') x += vitesse;
    if (orientation == 'g') x -= vitesse;
    if (orientation == 'h') y -= vitesse;
    if (orientation == 'b') y += vitesse;

    if (x < 0) x++;
    if (x > 1000) x--;
    if (y < 0) y++;
    if (y > 1000) y--;
  }

  public void Lignes() {
  }
}

//---------------------------------------------------------------------------------------------

AJoueur joueur2 = new AJoueur(color(PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255))), 200, 200);
AJoueur joueur3 = new AJoueur(color(PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255))), 700, 700);

class AJoueur {

  float x;
  float y;
  int vitesse = 1;
  char orientation = 'd';
  int couleur;
  int couleurligne;
  int couleurVerif;

  float coorPt1 = 100;
  float coorPt2 = 200;

  AJoueur(int newcouleur, float newx, float newy) {
    couleur = newcouleur;
    couleurligne = couleur-125;
    couleurVerif = couleurligne-100;
    x = newx;
    y = newy;
  }

  public void Affichage() {
    push();

    translate(x, y);
    float orientation2 = 0;
    if (orientation == 'd') orientation2 = 0;
    if (orientation == 'g') orientation2 = PI;
    if (orientation == 'h') orientation2 = PI/2;
    if (orientation == 'b') orientation2 = 3*PI/2;
    rotate(-orientation2);
    noStroke();
    fill(couleurVerif);
    rect(20, 0, 20, 60);

    pop();

    push();

    strokeWeight(3);
    fill(couleur);
    stroke(couleurligne);

    rect(x, y, 50, 50);

    pop();
  }

  public void D() {
    if (orientation != 'g') orientation = 'd';
  }
  public void G() {
    if (orientation != 'd') orientation = 'g';
  }
  public void H() {
    if (orientation != 'b') orientation = 'h';
  }
  public void B() {
    if (orientation != 'h') orientation = 'b';
  }

  public void Deplacement() {
    if (orientation == 'd') x += vitesse;
    if (orientation == 'g') x -= vitesse;
    if (orientation == 'h') y -= vitesse;
    if (orientation == 'b') y += vitesse;

    if (x < 0) x++;
    if (x > 1000) x--;
    if (y < 0) y++;
    if (y > 1000) y--;
  }

  public void Lignes() {
  }
}

//---------------------------------------------------------------------------

public void Affichage_Joueurs() {
  if (ID1 != 0) {

    float[] xyJoueur2 = new float[3];

    joueur2.Affichage();

    xyJoueur2 = PApplet.parseFloat(split(dataIn1, "!"));

    if (xyJoueur2[0] !=0 || xyJoueur2[1] != 0) {

      joueur2.x = xyJoueur2[0];
      joueur2.y = xyJoueur2[1];
    }

    joueur2.orientation = Switch_Joueur_Ori_char(PApplet.parseInt(xyJoueur2[2]));
  }

  if (ID2 != 0 && ID1 !=0) {

    float[] xyJoueur3 = new float[3];

    joueur3.Affichage();

    if (dataIn2 != null) {
      xyJoueur3 = PApplet.parseFloat(split(dataIn2, "!"));
    }

    if (xyJoueur3[0] !=0 || xyJoueur3[1] !=0) {

      joueur3.x = xyJoueur3[0];
      joueur3.y = xyJoueur3[1];
    }

    joueur3.orientation = Switch_Joueur_Ori_char(PApplet.parseInt(xyJoueur3[2]));
  }
}

public char Switch_Joueur_Ori_char(int base) {    //Transforme 0123 en dghb
  char finalite = 'd';
  switch(base) {
  case 0:
    finalite = 'd';
    break;
  case 1:
    finalite = 'h';
    break;
  case 2:
    finalite = 'g';
    break;
  case 3:
    finalite = 'b';
    break;
  }
  return finalite;
}

Server server;
String []DataIn = new String[2];
String dataIn;
float ID1 = 0;
float ID2 = 0;

String dataOut = "test no 15641";

String dataIn1;
String dataIn2;

public void Serv() {



  Client client = server.available();
  if (client != null) {
    dataIn = client.readString();
  }
  if (dataIn != null) {
    String list[] = split(dataIn, "/");

    DataIn[0] = list[0];
    DataIn[1] = list[1];

    push();
    fill(255);
    //text(DataIn[0], 20, 20);
    //text(DataIn[1], 20, 40);
    pop();

    if (ID1 == 0) ID1 = PApplet.parseFloat(DataIn[1]);
    if (ID2 == 0 && PApplet.parseFloat(DataIn[1]) != ID1) ID2 = PApplet.parseFloat(DataIn[1]);

    if (PApplet.parseFloat(DataIn[1]) == ID1) dataIn1 = DataIn[0];
    if (PApplet.parseFloat(DataIn[1]) == ID2) dataIn2 = DataIn[0];
  }

  String infoJ1 = "0!0!0";
  String infoJ2 = "0!0!0!0";
  String infoJ3 = "0!0!0!0";  //mettre les infos là dessous

  int oriJ1 = Switch_Joueurs_Oris(joueur.orientation);
  int oriJ2 = Switch_Joueurs_Oris(joueur2.orientation);
  int oriJ3 = Switch_Joueurs_Oris(joueur3.orientation);

  infoJ1 = joueur.x + "!" + joueur.y + "!" + oriJ1;
  infoJ2 = joueur2.x + "!" + joueur2.y + "!" + oriJ2 + "!" + ID1;
  infoJ3 = joueur3.x + "!" + joueur3.y + "!" + oriJ3 + "!" + ID2;
  
  int envoiStart = 0;
  
  if (start ==  true) envoiStart = 1;
  if (start == false) envoiStart = 0;

  dataOut = infoJ1 + "/" + infoJ2 + "/" + infoJ3 + "/" + envoiStart + "/";
  server.write(dataOut);
  
  //x1.y1.o1/x2.y2.o2.ID/x3.y3.o3.ID/envoiStart

  //text(ID1, 100, 20);
  //text(ID2, 100, 40);
}


public int Switch_Joueurs_Oris(int ori_base) {
  int oriJ = 0;
  switch(ori_base) {
  case 'd':
    oriJ = 0;
    break;
  case 'h':
    oriJ = 1;        // d : 0 / h : 1 / g : 2 / b : 3
    break;
  case 'g':
    oriJ = 2;
    break;
  case 'b':
    oriJ = 3;
    break;
  }
  return oriJ;
}
  public void settings() {  size(1000, 1000);  noSmooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Paper_mdr" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
