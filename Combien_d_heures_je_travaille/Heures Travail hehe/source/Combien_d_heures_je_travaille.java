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

public class Combien_d_heures_je_travaille extends PApplet {

int heures, minutes, aHeures, aMinutes;
float aSecondes, secondes, mil;
String[] fichier;
boolean pause = true;

public void setup() {
  
  background(0);
  fichier = loadStrings("temps.txt");
  aHeures = PApplet.parseInt(fichier[0]);
  aMinutes = PApplet.parseInt(fichier[1]);
  aSecondes = PApplet.parseFloat(fichier[2]);
}

public void draw() {
  background(0);
  fill(255);
  textSize(30);
  text(heures, 69, 30);
  text(minutes, 69, 60);
  text(secondes, 35, 90);
  text(aHeures, 200, 30);
  text(aMinutes, 200, 60);
  text(aSecondes, 165, 90);
  stroke(255);
  strokeWeight(5);
  text("H", 5, 30); 
  text("M", 5, 60); 
  text("S", 5, 90); 
  line(152, 0, 152, 101);
  textSize(20);
  fill(155);
  text("SPACE pour go et stop", 42, 129);
  textSize(30);
  if (secondes >= 60) {
    minutes++;
    secondes = 0;
    mil += 60000;
  }
  if (minutes >= 60) {
    heures++;
    minutes = 0;
  }

  if (pause == false) {
    secondes = (millis()-mil)/1000;
  }

  ResetBouton();
}
public void keyPressed() {
  if (key == ' ' && pause == true) {
    pause = false;
    mil = millis();
    minutes = 0;
    heures = 0;
  } else {
    pause = true;
    aSecondes += secondes;
    aMinutes += minutes;
    aHeures += heures;
    if (aSecondes >= 60) {
      aSecondes -= 60;
      aMinutes++;
    }
    if (aMinutes >= 60) {
      aMinutes -= 60;
      aHeures++;
    }
    fichier[2] = String.valueOf(aSecondes);
    fichier[1] = String.valueOf(aMinutes);
    fichier[0] = String.valueOf(aHeures);
    saveStrings("temps.txt", fichier);
  }
}

public void ResetBouton() {
  stroke(100);
  rect(50, 150, 200, 40);
  fill(0);
  text("RESET", 111, 181);

  if (mouseX >50 && mouseX < 250) {
    if (mouseY > 150 && mouseY < 190) {
      if (mousePressed == true) {
        aSecondes = 0;
        aMinutes = 0;
        aHeures = 0;
      }
    }
  }
}
  public void settings() {  size(300, 200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Combien_d_heures_je_travaille" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
