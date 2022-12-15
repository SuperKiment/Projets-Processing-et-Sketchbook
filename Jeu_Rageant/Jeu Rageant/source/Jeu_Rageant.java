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

public class Jeu_Rageant extends PApplet {

int noir = 0xff000000;
int blanc = 0xffFFFFFF;
float translateX, translateY;
int intervalleEnnemi = 100, timerEnnemi;

public void setup() {
  
  //size(1000, 1000);
}

public void draw() {
  background(noir);
  translateX = width/2;
  translateY = height/2;

  if (ecran == "Jeu") {
    push();
    translate(translateX, translateY);
    push();
    stroke(blanc);
    line(-translateX, 0, translateX, 0);
    line(0, -translateY, 0, translateY);
    pop();
    joueur.Fonctions();
    VieFonctions();
    EnnemiFonctions();
    timer.Time();
    pop();
  }

  Interface();
}
ArrayList<Ennemi> AllEnnemis = new ArrayList<Ennemi>();
int limiteEnnemis = 500;

class Ennemi {
  int hp, taille = 20, speed = 2;
  float x, y, direction;
  float xScreen, yScreen;
  float imprecision;

  int blanc = 0xffFFFFFF;
  int gris = 0xff888888;

  float rangeTaille = 2;
  float rangeSpeed = 2;
  float rangeImprecision = 2;


  Ennemi() {
    speed *= difficulte;
    taille *= difficulte;
    boolean plafond = false;
    float rand = random(-1, 1);
    while (rand == 0) rand = random(-1, 1);
    if (rand < 0) plafond = true; 
    else plafond = false;


    if (!plafond) {
      int cote = PApplet.parseInt(random(-10, 10));
      while (cote == 0) cote = PApplet.parseInt(random(-10, 10));
      if (cote < 0) cote = -1;
      if (cote > 0) cote = 1;

      y = PApplet.parseInt(random(-translateY, translateY));
      x = (translateX+100)*cote;
    }
    if (plafond) {
      int cote = PApplet.parseInt(random(-10, 10));
      while (cote == 0) cote = PApplet.parseInt(random(-10, 10));
      if (cote < 0) cote = -1;
      if (cote > 0) cote = 1;

      x = PApplet.parseInt(random(-translateX, translateX));
      y = (translateY+100)*cote;
    }


    speed = PApplet.parseInt(random(speed/rangeSpeed, speed*rangeSpeed));
    taille = PApplet.parseInt(random(taille/rangeTaille, taille*rangeTaille));
    imprecision = PApplet.parseInt(random(-PI*rangeImprecision/2, PI*rangeImprecision/2));
  }

  public void Affichage() {
    push();
    strokeWeight(3);
    stroke(gris);
    fill(blanc);
    ellipse(x, y, taille, taille);
    pop();
  }

  public void Deplacement() {

    float distX = x-joueur.x, distY = y-joueur.y;

    direction = atan(distY/distX);
    if (distX>0) direction += PI;

    direction += random(-imprecision, imprecision);

    x += speed*cos(direction);
    y += speed*sin(direction);
  }



  public boolean HorsLimite() {
    if (x>width-translateX || x < 0-translateX ||
      y > height-translateY || y < 0-translateY) return true;
    else return false;
  }

  public boolean CollisionJoueur() {
    boolean collision = false;

    float distJoueur = sqrt(pow(x-joueur.x, 2)+pow(y-joueur.y, 2));

    if (distJoueur <= taille/2) {
      collision = true;
      joueur.vies--;
      background(gris);
    }

    return collision;
  }

  public void Numerotation(int no) {
    push();
    fill(blanc);
    text(no, x+20, y+20);
    pop();
  }

  public void Fonctions(int no) {
    Deplacement();
    Affichage();
    //Numerotation(no);
  }
}

public void EnnemiFonctions() {
  push();
  fill(255);
  textSize(20);
  text("Nombre d'ennemis : "+AllEnnemis.size(), 50, 50);
  pop();

  for (int i = 0; i<AllEnnemis.size(); i++) {
    Ennemi ennemi = AllEnnemis.get(i);
    ennemi.Fonctions(i);

    if (ennemi.CollisionJoueur()) AllEnnemis.remove(i);
    //if (ennemi.HorsLimite()) AllEnnemis.remove(i);
  }

  if (AllEnnemis.size() >= limiteEnnemis) AllEnnemis.remove(1);

  if (millis()-timerEnnemi >= intervalleEnnemi) { 
    timerEnnemi = millis();
    AllEnnemis.add(new Ennemi());
  }
}

public void EnnemiReset() {
  for (int i = 0; i<AllEnnemis.size(); i++) {
    AllEnnemis.remove(i);
  }
}
public void keyPressed() {
  if (key == ' ' && ecran == "Ecran Titre") {
    ecran = "Jeu";
    EnnemiReset();
    timer.Go();
  }

  if (key == ' ' && ecran == "Mort") {
    ecran = "Ecran Titre";
    joueur.Reset();
    EnnemiReset();
  }

  if (ecran == "Ecran Titre") {
    if (key == '&' || key == '1') difficulte = 1;
    if (key == 'é' || key == '2') difficulte = 2;
    if (key == '"' || key == '3') difficulte = 3;
  }
}

String ecran = "Ecran Titre";
int difficulte = 1;
int gris_fonce = 0xff222222;

public void Interface() {
  if (ecran == "Ecran Titre") {
    push();
    background(noir);
    stroke(blanc);
    fill(noir);
    rectMode(CENTER);
    rect(translateX, translateY, 600, 400);
    fill(blanc);
    textSize(50);
    text("JEU RAGEANT", translateX-155, translateY+17);
    textSize(20);
    text("SPACE pour commencer", translateX-113, translateY+185);

    fill(noir);
    rect(translateX, translateY-500+794, 329, 160);
    fill(blanc);
    textSize(40);
    text("DIFFICULTE", translateX-500+387, translateY-500+765);
    for (int i = 1; i<=3; i++) {
      int tremblement = 0;

      fill(noir);
      if (difficulte == i) {
        fill(gris_fonce);
        tremblement = 2;
      }
      float offsetX = random(-tremblement, tremblement), 
        offsetY = random(-tremblement, tremblement);
      rect(translateX-500+i*100+300+offsetX, translateY-500+828+offsetY, 50, 50);
      fill(blanc);
      text(i, translateX-500+i*100+288+offsetX, translateY-500+842+offsetY);
    }
    pop();
  }

  if (ecran == "Mort") {
    push();
    int tremblement = 7;
    float offsetX = random(-tremblement, tremblement), 
      offsetY = random(-tremblement, tremblement);

    background(noir);
    stroke(blanc);
    fill(noir);
    rectMode(CENTER);
    rect(translateX, translateY, 600, 400);
    fill(blanc);
    textSize(80);
    text("MORT", translateX-500+389+offsetX, translateY-500+532+offsetY);
    textSize(20);
    text("SPACE pour aller à l'écran titre", translateX-500+355, translateY-500+685);
    pop();
  }
}

Joueur joueur = new Joueur();

class Joueur {
  int x, y;
  float xScreen, yScreen;
  int taille = 10;
  int blanc = 0xffFFFFFF;
  int vies;
  int viesBase = 5;
  Joueur() {
    vies = viesBase;
  }

  public void Affichage() {

    xScreen = x-translateX;
    yScreen = y-translateY;

    push();
    strokeWeight(3);
    rectMode(CENTER);
    fill(blanc);
    rect(x, y, taille, taille);
    pop();
  }

  public void Deplacement() {
    x = mouseX-PApplet.parseInt(translateX);
    y = mouseY-PApplet.parseInt(translateY);
  }

  public boolean Mort() {
    if (vies <= 0) return true;
    else return false;
  }

  public void Reset() {
    vies = viesBase;
  }

  public void Fonctions() {
    Deplacement();
    Affichage();

    if (Mort()) {
      ecran = "Mort"; 
      timer.Stop();
    }

    push();
    fill(blanc);
    textSize(20);
    text("Nombre de vies restantes : "+vies, 50, 80);
    pop();
  }
}
Timer timer = new Timer();

class Timer {
  int temps;
  int antimillis;
  int highscore1 = 0;
  int highscore2 = 0;
  int highscore3 = 0;

  Timer() {
  }

  public void Go() {
    antimillis = millis();
  }

  public void Time() {
    temps = millis() - antimillis;
    push();
    fill(blanc);
    textSize(20);
    text("Temps en vie : "+temps/1000+"s", 50, 110);
    text("Highscore (difficulté 1) : "+highscore1/1000+"s", 50, 140);
    text("Highscore (difficulté 2) : "+highscore2/1000+"s", 50, 170);
    text("Highscore (difficulté 3) : "+highscore3/1000+"s", 50, 200);
    pop();
  }


  public void Stop() {
    if (difficulte == 1 && temps > highscore1) highscore1 = temps;
    if (difficulte == 2 && temps > highscore2) highscore2 = temps;
    if (difficulte == 3 && temps > highscore3) highscore3 = temps;
  }
}
ArrayList<Vie> AllVies = new ArrayList<Vie>();
int limiteVie = 3;
float intervalleVie = 100, timerVie;

class Vie {
  float x, y, taille = 20, rangeTaille = 2;

  Vie() {
    x = random(-translateX, translateX);
    y = random(-translateY, translateY);
    taille = random(taille/rangeTaille, taille*rangeTaille);
  }

  public void Affichage() {
    push();
    strokeWeight(3);
    stroke(0xff00FFAA);
    strokeWeight(5);
    fill(0xff00FF00);
    ellipse(x, y, taille, taille);
    pop();
  }

  public boolean CollisionJoueur() {
    boolean collision = false;

    float distJoueur = sqrt(pow(x-joueur.x, 2)+pow(y-joueur.y, 2));

    if (distJoueur <= taille/2) {
      collision = true;
      joueur.vies++;
    }
    return collision;
  }

  public void Fonctions() {
    Affichage();
  }
}

public void VieFonctions() {
  for (int i = 0; i < AllVies.size(); i++) {
    Vie vie = AllVies.get(i);
    vie.Fonctions();

    if (vie.CollisionJoueur()) AllVies.remove(i);
  }

  if (millis()-timerVie >= intervalleVie && AllVies.size() < limiteVie) { 
    timerVie = millis();
    Vie vie = new Vie();
    AllVies.add(vie);
    println("vie créée en x:"+vie.x+" / y : "+vie.y);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Jeu_Rageant" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
