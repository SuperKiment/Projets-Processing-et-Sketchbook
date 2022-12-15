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

public class Paper_mdr_client extends PApplet {

boolean start = false;
boolean gagne = false;
boolean clientActif = false;

int joueurNo = 0;

public void setup() {
  frameRate(300);
  
  background(0);
  rectMode(CENTER);
  //InitGrille();
  
  //client = new Client(this, "localhost", 5204);
  ID = random(1, 10);
  surface.setTitle("Paper de Kiment Client");
  push();
  textSize(30);
  text("'C' POUR SE CONNECTER", width/2-180, height/3);
  pop();
}

public void draw() {
  if (!start) EcrireIP();

  if (clientActif == true) {
    Cli();
    Gestion_xy_Joueurs();
  }

  //background(0);
  //AffichageGrille();

  //Affichage_Joueurs();

  Affichage_Joueurs();

  if (joueur.x != 500) start = true;

  if (start == true) {
    Chrono();
    joueur.Deplacement();

    joueur2.Deplacement();

    if (joueurNo == 3) joueur3.Deplacement();
  }

  //if (start == true) text("true", 10, 10);
  //if (start == false) text("false", 10, 10);
  if (gagne == true) Gagne();

  //if (start ==  false) Debug();
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


Client client;

String z = "4";
float ID;

int compteurCli;

String []DataIn = new String [4];
float[] DataJ1 = new float [5];
float[] DataJ2 = new float [7];
float[] DataJ3 = new float [7];

String dataIn = " coucou";

String ipClient = "192.168.0.";

public void Cli() {



  int oriJ1 = Switch_Joueurs_Oris(joueur.orientation);
  int oriJ2 = Switch_Joueurs_Oris(joueur2.orientation);
  int oriJ3 = Switch_Joueurs_Oris(joueur3.orientation);

  compteurCli++;
  z = "0!0!";
  boolean printretard = false;
  if (compteurCli >= 500) {
    printretard = true;
    compteurCli = 0;

    switch(joueurNo) {
    case 2 :
      z = joueur2.x + "!" + joueur2.y + "!";
      break;
    case 3 :
      z = joueur3.x + "!" + joueur3.y + "!";
      break;
    }
  }

  if (joueurNo == 2) z += oriJ2;
  if (joueurNo == 3) z += oriJ3;

  if (printretard == true) println("z : " + z);

  client.write(z + "/" + ID + "/");  

  fill(255);


  if (client.available() != 0) {
    dataIn = client.readString();
    println("dataIn : " + dataIn);
    DataIn = split(dataIn, "/");
    if (start == false) AfficherTableau(DataIn);

    DataJ1 = PApplet.parseFloat(split(DataIn[0], "!"));
    DataJ2 = PApplet.parseFloat(split(DataIn[1], "!"));
    DataJ3 = PApplet.parseFloat(split(DataIn[2], "!"));
  }

  if (DataJ2[3] == ID) joueurNo = 2;
  if (DataJ3[3] == ID) joueurNo = 3;

  if (DataIn[3] == "1") {
    println("DataIn = 1");
  }
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

public void EcrireIP() {
  push();
  rectMode(CENTER);
  stroke(255);
  fill(0);
  rect(width/2, height*3/4, 500, 200);
  textSize(30);
  fill(255);
  text(ipClient,400, height*3/4 + 0);
  text("N'utiliser que les touches &é\"'(", 280, height*3/4 -70);
  text("pour entrer l'IP :", 280, height*3/4 -40);
  text("CTRL pour effacer", 280, height*3/4 +70);
  pop();
}
public void keyPressed() {

  switch(joueurNo) {
  case 2 :
    if (key == 'd') joueur2.D();
    if (key == 'q') joueur2.G();
    if (key == 'z') joueur2.H();
    if (key == 's') joueur2.B();
    break;
  case 3 :
    if (key == 'd') joueur3.D();
    if (key == 'q') joueur3.G();
    if (key == 'z') joueur3.H();
    if (key == 's') joueur3.B();
    break;
  }

  /*
  if (key == 't') Verif(joueur.couleur, color(1), color(2), color(3));
   if (key == 'y') Verif(joueur.couleur, color(1), color(2), color(3));*/
  //if (key == 'g') background(0, 255, 0);

  if (key == ' ' && start == false) {
    start = true;
    tempsgo = millis();
  }

  //if (key == 'h') triche += 10;
  //if (key == 'k') gagne = true;

  if (key == 'c') {
    client = new Client(this, ipClient, 5204);
    clientActif = true;
  }

  if (clientActif == false) {
    if (key == '&') ipClient += "1";
    if (key == 'é') ipClient += "2";
    if (key == '"') ipClient += "3";
    if (key == '\'') ipClient += "4";
    if (key == '(') ipClient += "5";
    if (key == '-') ipClient += "6";
    if (key == 'è') ipClient += "7";
    if (key == '_') ipClient += "8";
    if (key == 'ç') ipClient += "9";
    if (key == 'à') ipClient += "0";
    if (key == ';') ipClient += ".";
    if (key == CODED && keyCode == CONTROL) ipClient = "";
  }
}
public void Debug() {
  push();

  fill(50, 50, 50, 50);
  noStroke();
  rect(0, 0, 1500, 400);

  fill(0, 255, 0);
  textSize(10);

  text("z : " + z, 10, 20);
  text("dataIn : " + dataIn, 10, 30);
  text("ID : " + ID, 10, 40);
  text("ipClient : " + ipClient, 10, 50);
  text("joueurNo : " + joueurNo, 10, 60);
  text("start : " + start, 10, 70);

  /*
  text("ID1 " + ID1, 10, 20); 
   text("ID2 " + ID2, 10, 30); 
   text("dataIn " + dataIn, 10, 40);
   
   if (DataIn[1] != null) {
   if (float(DataIn[1]) == ID1) text("DataIn[0] ID1 : " + DataIn[0], 10, 50);
   if (float(DataIn[1]) == ID2) text("DataIn[0] ID2 : " + DataIn[0], 10, 60);
   }
   
   text("dataIn1 " + dataIn1, 10, 70);
   text("dataIn2 " + dataIn2, 10, 80);
   */
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
    ResultatsFin = Verif(joueur.couleurligne, color(10), color(20), color(30));
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
Joueur joueur = new Joueur(color(PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255))), 500, 500);

class Joueur {

  float x;
  float y;
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

//---------------------------------------------------------------------------------------------

Joueur joueur2 = new Joueur(color(PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255))), 200, 200);
Joueur joueur3 = new Joueur(color(PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255)), PApplet.parseInt(random(50, 255))), 700, 700);

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

/*
  void Lignes() {
  }*/
}

/*
void Affichage_Joueurs() {
 if (ID1 != 0) {
 
 float[] xyJoueur2 = new float[2];
 
 joueur2.Affichage();
 
 xyJoueur2 = float(split(dataIn1, "."));
 
 if (xyJoueur2[0] !=0 || xyJoueur2[1] !=0) {
 
 joueur2.x = xyJoueur2[0];
 joueur2.y = xyJoueur2[1];
 
 }
 }
 }
 */


//--------------------------------------Gestion client--------------------

public void Gestion_xy_Joueurs() {
  if (DataJ1[0] != 0) {

    joueur.x = DataJ1[0];
    joueur.y = DataJ1[1];

    switch(PApplet.parseInt(DataJ1[2])) {
    case 0 :
      joueur.orientation = 'd';      //Gestion de l'envoi DataInJx vers joueur.x/y 
      break;
    case 1 :
      joueur.orientation = 'h';
      break;
    case 2 :
      joueur.orientation = 'g';
      break;
    case 3 :
      joueur.orientation = 'b';
      break;
    }
  }
}


public void Affichage_Joueurs() {
  joueur.Affichage();
  if (joueurNo == 2) {
    joueur2.Affichage();
  }
  if (joueurNo == 3) {
    joueur2.Affichage();
    joueur3.Affichage();
  }
}
/*

 Il faut
 afficher les joueurs
 
 
 
 Bouger le client j2 ou j3
 lier le client j23
 renvoyer les infos sur j23 à 32
 lier start et gagne
 lier les infos ?
 Optimiser
 
 */

/*

 Orientation full donnée
 xy tous les 1 sec           ok
 0 = rien
 
 Commandes ok
 
 On voit l'orientation pour le j2 et le j3
 
 Le DataIn est chelou wtf
 
 faire bouger le j23
 
 */
/*import processing.net.*;
 Server server;
 String []DataIn = new String[2];
 String dataIn;
 float ID1;
 float ID2;
 
 String dataOut = "test no 15641";
 
 String dataIn1;
 String dataIn2;
 
 void Serv() {
 
 server.write(dataOut);
 
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
 
 if (ID1 == 0) ID1 = float(DataIn[1]);
 if (ID2 == 0 && float(DataIn[1]) != ID1) ID2 = float(DataIn[1]);
 
 if (float(DataIn[1]) == ID1) dataIn1 = DataIn[0];
 if (float(DataIn[1]) == ID2) dataIn2 = DataIn[0];
 }
 
 
 
 //text(ID1, 100, 20);
 //text(ID2, 100, 40);
 }*/
public void AfficherTableau(String Tableau[]) {
  push();
  fill(20, 20, 20, 150);
  rect(100, 750, 200, 500);
  pop();
  for (int i = 0; i<4; i++) {
    push();
    fill(0xff00FFF9);
    textSize(10);
    text("Tableau demandé : " + i + " : " + Tableau[i], 20, 550 + i*10);
    pop();
  }

  text("DataIn 3 : \"" + DataIn[3] + "\"", 20, 700);
}
  public void settings() {  size(1000, 1000);  noSmooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Paper_mdr_client" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
