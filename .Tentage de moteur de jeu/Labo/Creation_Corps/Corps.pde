class Corps {

  float x = 250, y = 250;
  ArrayList<Point> AllPoints = new ArrayList<Point>();

  Corps() {
  }

  void Setup(JSONArray json) {

    if (json == null) {
      AllPoints.add(new Point(0, 50, 0));
      AllPoints.add(new Point(50, 50, 1));
      AllPoints.add(new Point(100, 0, 2));
      AllPoints.add(new Point(50, -50, 3));
      AllPoints.add(new Point(0, -50, 4));
      AllPoints.add(new Point(0, 50, 5));
    } else {
      for (int i=0; i<json.size(); i++) {
        JSONObject obj = json.getJSONObject(i);
        Point point = new Point(obj.getFloat("x"), obj.getFloat("y"), int(obj.getInt("index")));
        AllPoints.add(point);
      }
    }
  }

  void Affichage() {
    x = width/2;
    y = height/2;
    stroke(125);
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height);

    push();
    translate(x, y);

    if (this == outil.corpsCible) {
      if (isDedans(mouseX-width/2, mouseY-height/2)) fill(203);
      else fill(103);
    } else fill(50);

    stroke(255);

    beginShape();
    for (Point point : AllPoints) {
      float vx = point.x, vy = point.y;
      vertex(vx, vy);
    }
    if (!AllPoints.isEmpty()) vertex(AllPoints.get(0).x, AllPoints.get(0).y);
    endShape();

    for (int i=0; i<AllPoints.size(); i++) {
      Point point = AllPoints.get(i);

      point.index = i;

      push();
      fill(255);
      textSize(10);
      text(int(point.index), point.x, point.y-10);
      pop();
    }

    if (AllPoints.size() > 1) {
      AllPoints.get(0).Fleche(AllPoints.get(1));
    }

    pop();
  }



  void Save() {
    JSONArray jsonCorps = new JSONArray();
    int compteur = 0;

    for (Point point : AllPoints) {
      JSONObject objPoint = new JSONObject();
      objPoint.setInt("index", compteur);

      objPoint.setFloat("x", point.x);
      objPoint.setFloat("y", point.y);

      jsonCorps.setJSONObject(compteur, objPoint);

      compteur++;
    }

    saveJSONArray(jsonCorps, "Animaux/test.json");
    println("Saved");
  }


  boolean isDedans(float xf, float yf) {
    boolean dedans = false;

    if (AllPoints.size() >= 3) {

      Point p1 = AllPoints.get(0);
      Point p2 = AllPoints.get(1);

      PVector v = new PVector(p2.x-p1.x, p2.y-p1.y);
      v.setMag(v.mag()/2);
      

      if (isDessous(xf, yf, p1.x, p1.y, p2.x, p2.y, "dessous")) {
        dedans = true;
      } else dedans = false;
    }
    return dedans;
  }
}

boolean isDessous(float mx, float my, float x1, float y1, float x2, float y2, String sens) {
  boolean dessous = false;

  float a = (y2-y1)/(x2-x1);
  float b = -(a*x1-y1);  
  float yf = a*mx+b;

  if (sens == "dessous") {
    if (my < yf) dessous = false;
    else dessous = true;
  } else { 
    if (my > yf) {
      dessous = false;
    } else dessous = true;
  }

  return dessous;
}
