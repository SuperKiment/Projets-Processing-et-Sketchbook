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

public class Creation_Corps3 extends PApplet {

public void setup() {
  
  surface.setResizable(true);
  surface.setTitle("Création de corps");
  PImage icon = null;
  try {
    icon = loadImage("data/icon.png");
  }
  catch(Exception e) {
    println("Pas d'icon");
  }
  if (icon != null) surface.setIcon(icon);

  corps = new Corps();
  corps.Setup("Animaux/test.json");
  corps.modification = true;
}


public void draw() {
  Interface();
  corps.Affichage(width/2, height/2);
  outil.Affichage();
}




Corps corps;
Outils outil = new Outils();




int timerSave = 0;

public void Interface() {
  background(0);

  stroke(125);
  line(0, height/2, width, height/2);   //Croix mid ecran
  line(width/2, 0, width/2, height);

  push();

  fill(255);
  float ecartText = height/30;
  textSize(ecartText);
  text("Outil : "+outil.modeSouris, width/25, ecartText + height/20);
  text("Style Triangles : "+corps.styleTri, width/25, 2*ecartText + height/20);
  if (timerSave>millis()) text("Sauvegardé !", width/25, 3*ecartText + height/20);

  fill(125);
  textSize(ecartText*3/4);
  text("Outils : |1| / |2| / |3|", width/25, -3*ecartText*3/4+height*9/10);
  text("Style Triangles : |F| / |G|", width/25, -2*ecartText*3/4+height*9/10);
  text("Sauvegarde : |A|", width/25, -ecartText*3/4+height*9/10);
  text("Choisir Couleur : |Z| / |Q| / |S| / |D|", width/25, height*9/10);
  text("Changer Couleur : |W| / |X|", width/25, ecartText*3/4+height*9/10);
  text("Voir Couleur : |C|", width/25, 2*ecartText*3/4+height*9/10);


  fill(0);
  stroke(255);       //COULEUR
  rectMode(CENTER);
  translate(width*3.5f/4, height*3/4);
  rect(0, 0, width/4, height/4); //Base

  fill(255);
  textAlign(CENTER);
  translate(0, -height/12);
  text("Couleur", 0, 0);  //Titres

  text("Fill", 0, ecartText);
  text("Line", 0, height/8);

  fill(0);

  float hRect = height/25, wRect = width/20;   //Cases

  float selX = 0, selY = 0;
  if (outil.selColor.equals("Line")) {
    selY = 5*ecartText;
  } else selY = 2*ecartText;
  if (outil.selRGB == 'R') selX = -width/12;
  if (outil.selRGB == 'G') selX = 0;
  if (outil.selRGB == 'B') selX = width/12;
  
  rect(selX, selY, wRect*1.5f, hRect*1.5f);

  rect(-width/12, 2*ecartText, wRect, hRect);
  rect(0, 2*ecartText, wRect, hRect);
  rect(width/12, 2*ecartText, wRect, hRect);

  rect(-width/12, 5*ecartText, wRect, hRect);
  rect(0, 5*ecartText, wRect, hRect);
  rect(width/12, 5*ecartText, wRect, hRect);

  fill(255);
  text(PApplet.parseInt(red(outil.couleurFill)), -width/12, 2.2f*ecartText);
  text(PApplet.parseInt(green(outil.couleurFill)), 0, 2.2f*ecartText);
  text(PApplet.parseInt(blue(outil.couleurFill)), width/12, 2.2f*ecartText);

  text(PApplet.parseInt(red(outil.couleurLine)), -width/12, 5.2f*ecartText);
  text(PApplet.parseInt(green(outil.couleurLine)), 0, 5.2f*ecartText);
  text(PApplet.parseInt(blue(outil.couleurLine)), width/12, 5.2f*ecartText);


  pop();
}
public class Corps {

  private ArrayList<Point> AllPoints = new ArrayList<Point>();
  private ArrayList<TrianglePoint> AllTriangles = new ArrayList<TrianglePoint>();
  private String styleTri = "Fan";
  public boolean modification = true;
  private int colLine = color(255), colFill = color(125);

  Corps() {
  }

  public void Setup(String path) {
    JSONArray json = null;

    try {
      json = loadJSONArray(path);
    }
    catch (Exception e) {
      println("Pas de .json à "+path+", demo mise en place");
    }

    if (json == null) {
      AllPoints.add(new Point(0, 50, 0));
      AllPoints.add(new Point(50, 50, 1));      //Recup JSON File
      AllPoints.add(new Point(100, 0, 2));
      AllPoints.add(new Point(50, -50, 3));
      AllPoints.add(new Point(0, -50, 4));
      AllPoints.add(new Point(0, 50, 5));
    } else {
      try {
        int compteur = 0;
        for (int i=0; i<json.size()-1; i++) {
          JSONObject obj = json.getJSONObject(i);
          Point point = new Point(obj.getFloat("x"), obj.getFloat("y"), PApplet.parseInt(obj.getInt("index")));
          AllPoints.add(point);

          compteur++;
        }

        JSONObject objSettings = json.getJSONObject(json.size()-1);
        styleTri = objSettings.getString("styleTri");
        colLine = objSettings.getInt("colLine");
        colFill = objSettings.getInt("colFill");

        if (modification) outil.setColor(colLine, colFill);

        println("Corps créé à partir de "+path+" : créé "+compteur+" points, style de triangle "+styleTri);
      }


      catch (Exception e) {
        println("Pas réussi à analyser le .json, demo mise en place");
        AllPoints.add(new Point(0, 50, 0));
        AllPoints.add(new Point(50, 50, 1));                 //Recup JSON File
        AllPoints.add(new Point(100, 0, 2));
        AllPoints.add(new Point(50, -50, 3));
        AllPoints.add(new Point(0, -50, 4));
        AllPoints.add(new Point(0, 50, 5));
      }
    }
    UpdateModifTriangles();
  }


  public void Save(String path) {
    JSONArray jsonCorps = new JSONArray();
    int compteur = 0;

    for (Point point : AllPoints) {
      JSONObject objPoint = new JSONObject();
      objPoint.setInt("index", compteur);

      objPoint.setFloat("x", point.x);                            //Sauvegarde
      objPoint.setFloat("y", point.y);

      jsonCorps.setJSONObject(compteur, objPoint);

      compteur++;
    }

    JSONObject objSettings = new JSONObject();
    objSettings.setString("styleTri", styleTri);
    objSettings.setInt("colLine", colLine);
    objSettings.setInt("colFill", colFill);

    jsonCorps.setJSONObject(compteur, objSettings);


    saveJSONArray(jsonCorps, path);
    println("Saved");
  }


  public void Affichage(float x, float y) {

    if (modification) UpdateModifTriangles();

    push();
    translate(x, y);

    if (modification) {
      if (this == outil.corpsCible) {
        if (isDedans(mouseX-x, mouseY-y)) {                       //Affichage
          fill(153);
          cursor(HAND);
        } else {
          fill(103);
          cursor(ARROW);
        }
      } else fill(50);              //Couleur Surface

      stroke(255);
    } else {
      fill(colFill);
      stroke(colLine);
    }

    if (styleTri.equals("Fan")) beginShape(TRIANGLE_FAN);
    else beginShape(TRIANGLE_STRIP);
    for (Point point : AllPoints) {
      float vx = point.x, vy = point.y;      //Crée les vertex
      vertex(vx, vy);
    }
    endShape(CLOSE);

    for (int i=0; i<AllPoints.size(); i++) {
      Point point = AllPoints.get(i);

      point.index = i;

      push();
      fill(255);           //Indicateur no point
      textSize(10);
      text(PApplet.parseInt(point.index), point.x, point.y-10);
      pop();
    }

    if (modification) {
      if (AllPoints.size() > 1) {
        AllPoints.get(0).Fleche(AllPoints.get(1));  //Fleche de P0 à P1
      }
    }

    pop();
  }

  public boolean isDedans(float xf, float yf) {
    boolean dedans = false;

    if (AllPoints.size() >= 3) {
      int i = 0;
      while (dedans == false) {

        TrianglePoint tri = AllTriangles.get(i);

        if (tri.isDedans(xf, yf)) dedans = true;

        if (i == AllTriangles.size()-1) break;
        else i++;
      }
    }

    return dedans;
  }

  private void UpdateModifTriangles() {
    AllTriangles.clear();

    if (styleTri.equals("Fan")) {

      for (int i = 0; i<AllPoints.size()-1; i++) {
        AllTriangles.add(new TrianglePoint(
          AllPoints.get(0), 
          AllPoints.get(i), 
          AllPoints.get(i+1)
          ));
      }
    } else {
      for (int i = 0; i<AllPoints.size()-2; i++) {
        AllTriangles.add(new TrianglePoint(
          AllPoints.get(i), 
          AllPoints.get(i+1), 
          AllPoints.get(i+2)
          ));
      }
    }

    for (TrianglePoint tri : AllTriangles) {
      push();
      translate(width*3/4, height/4);
      scale(0.5f);
      tri.Affichage(mouseX-width/2, mouseY-height/2);
      pop();
    }
  }

  public void setColor(int line, int fill) {
    colLine = line;
    colFill = fill;
  }
}

//=======================================================

public class Point {
  private float x, y;
  private int index;

  Point(float nx, float ny, int ni) {
    x = nx;
    y = ny;
    index = ni;
  }


  public void Fleche(Point point) {
    if (point != null) {
      push();
      float dist = dist(x, y, point.x, point.y)*3/4;
      translate(x, y);
      rotate(Direction(point));
      rectMode(CENTER);
      translate(dist, 0);
      fill(100);
      beginShape();
      vertex(0, 0);
      vertex(-10, 5);
      vertex(-10, -5);
      vertex(0, 0);
      endShape();
      pop();
    }
  }


  public float Direction(Point point) {
    if (point != null) {
      float distX, distY, rotation = 0;  //Variables
      float inversion = 1;

      distX = point.x - x;  //Récupération de la distance entre mouseX et le centre
      distY = point.y - y;

      if (distX > 0)inversion = 0;        //Si la souris est à gauche du point alors on ajoute PI
      if (distX < 0)inversion = PI;

      rotation = atan(distY/distX)+inversion;  //Calcul de la rotation avec l'inversion

      return rotation;
    } else return 0;
  }
}

//====================================================

public class TrianglePoint {

  private Point p1, p2, p3;

  TrianglePoint(Point np1, Point np2, Point np3) {
    p1 = np1;
    p2 = np2;
    p3 = np3;
  }

  public boolean isDedans(float mx, float my) {

    if (p1 != null && p2 != null && p3 != null) {
      float x1 = p1.x, y1 = p1.y;
      float x2 = p2.x, y2 = p2.y;
      float x3 = p3.x, y3 = p3.y;
      float x = mx, y = my;

      double ABC = Math.abs (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2));
      double ABP = Math.abs (x1 * (y2 - y) + x2 * (y - y1) + x * (y1 - y2));
      double APC = Math.abs (x1 * (y - y3) + x * (y3 - y1) + x3 * (y1 - y));
      double PBC = Math.abs (x * (y2 - y3) + x2 * (y3 - y) + x3 * (y - y2));

      boolean isInTriangle = ABP + APC + PBC == ABC;

      return isInTriangle;
    } else return false;
  }

  public void Affichage(float mx, float my) {
    push();
    stroke(50);
    if (isDedans(mx, my))fill(185);
    else fill(80);

    beginShape(TRIANGLE_STRIP);

    if (p1 != null && p2 != null && p3 != null) {
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
    }

    endShape(CLOSE);
    pop();
  }
}

class Outils {
  String modeSouris = "Selectionner";
  Corps corpsCible;
  Point pointPr = new Point(0, 0, 0);
  Point pointSel = new Point(-1684, 1464, 0);
  float x, y;

  boolean colorMode = false;

  int couleurFill, couleurLine;
  int Rl = 255, Gl = 255, Bl = 255;
  int Rf = 100, Gf = 100, Bf = 100;

  String selColor = "Line";
  char selRGB = 'R';

  Outils() {
    corpsCible = corps;
  }
  //                                         PERM
  public void Affichage() {
    translate(width/2, height/2);
    corpsCible = corps;
    x = mouseX-width/2;
    y = mouseY-height/2;

    float distMin = 99999;
    for (Point p : corpsCible.AllPoints) {
      if (dist(x, y, p.x, p.y) < distMin) {
        distMin = dist(x, y, p.x, p.y);
        pointPr = p;
      }
    }

    if (modeSouris == "Selectionner") {
      line(x, y, pointPr.x, pointPr.y);
    }


    if (modeSouris == "Effacer") {
      push();
      stroke(255, 0, 0);
      line(x, y, pointPr.x, pointPr.y);
      pop();
    }


    if (modeSouris == "Point") {
      push();
      stroke(255);
      line(x, y, pointSel.x, pointSel.y);
      Fleche(mouseX-width/2, mouseY-height/2, pointSel);
      pop();
    }

    if (pointSel.x != -1684 && pointSel.y != 1464) {
      push();
      noStroke();
      fill(255, 0, 0);
      ellipse(pointSel.x, pointSel.y, 10, 10);
      pop();
    }

    if (corps.AllPoints.isEmpty()) {
      corps.AllPoints.add(new Point(0, 0, 0));
      pointSel = corps.AllPoints.get(0);
    }

    couleurFill = color(Rf, Gf, Bf);               //Couleur
    couleurLine = color(Rl, Gl, Bl);

    corps.setColor(couleurLine, couleurFill);
    corps.modification = !colorMode;
  }


  //                                             CLICK
  public void Click() {
    if (modeSouris == "Selectionner") {
      pointSel = pointPr;
    }

    if (modeSouris == "Effacer") {
      int index = 0;
      int compteur = 0;
      for (Point point : corps.AllPoints) {
        if (pointPr == point) index = compteur;
        compteur++;
      }
      if (!corps.AllPoints.isEmpty()) {
        corps.AllPoints.remove(index);
        println("removed "+pointPr.index);
      }

      PointProche();
      pointSel = pointPr;
    }

    if (modeSouris == "Point") {
      corps.AllPoints.add(PApplet.parseInt(pointSel.index), new Point(mouseX-width/2, mouseY-height/2, PApplet.parseInt(pointSel.index+1)));
      PointProche();
      pointSel = pointPr;
    }
  }

  public void PointProche() {
    float distMin = 99999;
    for (Point p : corpsCible.AllPoints) {
      if (dist(x, y, p.x, p.y) < distMin) {
        distMin = dist(x, y, p.x, p.y);
        pointPr = p;
      }
    }
  }

  public void Fleche(float x1, float y1, Point point) {
    push();
    float dist = dist(x1, y1, point.x, point.y)/4;
    translate(x1, y1);
    rotate(Direction(point));
    rectMode(CENTER);
    translate(dist, 0);
    fill(100);
    beginShape();
    vertex(0, 0);
    vertex(10, 5);
    vertex(10, -5);
    vertex(0, 0);
    endShape();
    pop();
  }

  public float Direction(Point point) {
    float distX, distY, rotation = 0;  //Variables
    float inversion = 1;

    distX = point.x - mouseX+width/2;  //Récupération de la distance entre mouseX et le centre
    distY = point.y - mouseY+height/2;

    if (distX > 0)inversion = 0;        //Si la souris est à gauche du point alors on ajoute PI
    if (distX < 0)inversion = PI;

    rotation = atan(distY/distX)+inversion;  //Calcul de la rotation avec l'inversion

    return rotation;
  }

  public void setColor(int line, int fill) {
    couleurLine = line;
    couleurFill = fill;

    Rl = PApplet.parseInt(red(couleurLine));
    Gl = PApplet.parseInt(green(couleurLine));
    Bl = PApplet.parseInt(blue(couleurLine));

    Rf = PApplet.parseInt(red(couleurFill));
    Gf = PApplet.parseInt(green(couleurFill));
    Bf = PApplet.parseInt(blue(couleurFill));
  }
}

public void keyPressed() {
  if (key == 'a') {
    corps.Save("Animaux/test.json");
    timerSave = millis()+1000;
  }

  if (key == '&' || key == 'é' || key == '"') {
    if (key == '&') outil.modeSouris = "Point";
    if (key == 'é') outil.modeSouris = "Effacer";
    if (key == '"') outil.modeSouris = "Selectionner";
    println("Passage de l'outil en " + outil.modeSouris);
  }

  if (key == 'f' || key == 'g') {
    if (key == 'f') corps.styleTri = "Fan";
    if (key == 'g') corps.styleTri = "Strip";
    println("Passage du style de triangle en " + corps.styleTri);
  }


  if (key == 's' && outil.selColor.equals("Fill")) {
    outil.selColor = "Line";
  }
  if (key == 'z' && outil.selColor.equals("Line")) {
    outil.selColor = "Fill";
  }

  if (key == 'd') {
    boolean click = false;
    if (outil.selRGB == 'R' && !click) {
      outil.selRGB = 'G';
      click = true;
    }
    if (outil.selRGB == 'G' && !click) {
      outil.selRGB = 'B';
      click = true;
    }
    if (outil.selRGB == 'B' && !click) {
      outil.selRGB = 'R';
      click = true;
    }
  }
  if (key == 'q') {
    boolean click = false;
    if (outil.selRGB == 'R' && !click) {
      outil.selRGB = 'B';
      click = true;
    }
    if (outil.selRGB == 'G' && !click) {
      outil.selRGB = 'R';
      click = true;
    }
    if (outil.selRGB == 'B' && !click) {
      outil.selRGB = 'G';
      click = true;
    }
  }

  if (key == 'x') {
    if (outil.selColor.equals("Line")) {
      if (outil.selRGB == 'R') outil.Rl++;
      if (outil.selRGB == 'G') outil.Gl++;
      if (outil.selRGB == 'B') outil.Bl++;
    }
    if (outil.selColor.equals("Fill")) {
      if (outil.selRGB == 'R') outil.Rf++;
      if (outil.selRGB == 'G') outil.Gf++;
      if (outil.selRGB == 'B') outil.Bf++;
    }
  }
  if (key == 'w') {
    if (outil.selColor.equals("Line")) {
      if (outil.selRGB == 'R') outil.Rl--;
      if (outil.selRGB == 'G') outil.Gl--;
      if (outil.selRGB == 'B') outil.Bl--;
    }
    if (outil.selColor.equals("Fill")) {
      if (outil.selRGB == 'R') outil.Rf--;
      if (outil.selRGB == 'G') outil.Gf--;
      if (outil.selRGB == 'B') outil.Bf--;
    }
  }

  if (key == 'c') {
    if (outil.colorMode) {
      outil.colorMode = false;
    } else outil.colorMode = true;
  }
}

public void mousePressed() {
  outil.Click();
}

  public void settings() {  size(1080, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Creation_Corps3" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
