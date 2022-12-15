public class Corps {

  private ArrayList<Point> AllPoints = new ArrayList<Point>();
  private ArrayList<TrianglePoint> AllTriangles = new ArrayList<TrianglePoint>();
  private String styleTri = "Fan";
  public boolean modification = false;
  private color colLine = color(255), colFill = color(125);

  float x, y;

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
          Point point = new Point(obj.getFloat("x"), obj.getFloat("y"), int(obj.getInt("index")));
          AllPoints.add(point);

          compteur++;
        }

        JSONObject objSettings = json.getJSONObject(json.size()-1);
        styleTri = objSettings.getString("styleTri");
        colLine = objSettings.getInt("colLine");
        colFill = objSettings.getInt("colFill");


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

    x = this.x; 
    y = this.y;

    push();
    translate(x, y);


    fill(colFill);
    stroke(colLine);


    if (styleTri.equals("Fan")) beginShape(TRIANGLE_FAN);
    else beginShape(TRIANGLE_STRIP);
    for (Point point : AllPoints) {                               //Affichage
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
      text(int(point.index), point.x, point.y-10);
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
      scale(0.5);
      tri.Affichage(mouseX-width/2, mouseY-height/2);
      pop();
    }
  }

  public void setColor(color line, color fill) {
    colLine = line;
    colFill = fill;
  }


  void UpdateTrianglesPos(PVector pos) {
    for (TrianglePoint tri : AllTriangles) {
      tri.UpdatePosition(pos);
    }
  }
}

//======================================================= POINTS

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

//==================================================== TRIANGLES

public class TrianglePoint {

  private Point p1, p2, p3;

  TrianglePoint(Point np1, Point np2, Point np3) {
    p1 = np1;
    p2 = np2;
    p3 = np3;
  }

  float xS, yS;

  void UpdatePosition(PVector pos) {
    xS = pos.x;
    yS = pos.y;
  }

  public boolean isDedans(float mx, float my) {

    if (p1 != null && p2 != null && p3 != null) {
      float x1 = p1.x+xS, y1 = p1.y+yS;
      float x2 = p2.x+xS, y2 = p2.y+yS;
      float x3 = p3.x+xS, y3 = p3.y+yS;
      float x = mx, y = my;

      double ABC = Math.abs (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2));
      double ABP = Math.abs (x1 * (y2 - y) + x2 * (y - y1) + x * (y1 - y2));
      double APC = Math.abs (x1 * (y - y3) + x * (y3 - y1) + x3 * (y1 - y));
      double PBC = Math.abs (x * (y2 - y3) + x2 * (y3 - y) + x3 * (y - y2));

      boolean isInTriangle = ABP + APC + PBC <= ABC;

      return isInTriangle;
    } else return false;
  }

  public void Affichage(float mx, float my) {

    push();
    translate(xS, yS);
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
