class Corps {

  float x = 250, y = 250;
  ArrayList<Point> AllPoints = new ArrayList<Point>();
  ArrayList<TrianglePoint> AllTriangles = new ArrayList<TrianglePoint>();
  String styleTri = "Fan";

  Corps() {
  }

  void Setup(JSONArray json) {

    if (json == null) {
      AllPoints.add(new Point(0, 50, 0));
      AllPoints.add(new Point(50, 50, 1));      //Recup JSON File
      AllPoints.add(new Point(100, 0, 2));
      AllPoints.add(new Point(50, -50, 3));
      AllPoints.add(new Point(0, -50, 4));
      AllPoints.add(new Point(0, 50, 5));
    } else {
      int compteur = 0;
      for (int i=0; i<json.size()-1; i++) {
        JSONObject obj = json.getJSONObject(i);
        Point point = new Point(obj.getFloat("x"), obj.getFloat("y"), int(obj.getInt("index")));
        AllPoints.add(point);

        compteur++;
      }

      JSONObject objSettings = json.getJSONObject(json.size()-1);
      styleTri = objSettings.getString("Settings");

      println("Créé "+compteur+" points, style de triangle "+styleTri);
    }
  }

  void Save() {
    JSONArray jsonCorps = new JSONArray();
    int compteur = 0;

    for (Point point : AllPoints) {
      JSONObject objPoint = new JSONObject();
      objPoint.setInt("index", compteur);

      objPoint.setFloat("x", point.x);            //Sauvegarde
      objPoint.setFloat("y", point.y);

      jsonCorps.setJSONObject(compteur, objPoint);

      compteur++;
    }

    JSONObject objSettings = new JSONObject();
    objSettings.setString("Settings", corps.styleTri);

    jsonCorps.setJSONObject(compteur, objSettings);


    saveJSONArray(jsonCorps, "Animaux/test.json");
    println("Saved");
  }

  void Affichage() {


    UpdateTriangles();

    x = width/2;
    y = height/2;
    stroke(125);
    line(0, height/2, width, height/2);   //Croix mid ecran
    line(width/2, 0, width/2, height);

    push();
    translate(x, y);

    if (this == outil.corpsCible) {
      if (isDedans(mouseX-width/2, mouseY-height/2)) {
        fill(153);
        cursor(HAND);
      } else {
        fill(103);
        cursor(ARROW);
      }
    } else fill(50);              //Couleur Surface

    stroke(255);

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
      text(int(point.index), point.x, point.y-10);
      pop();
    }

    if (AllPoints.size() > 1) {
      AllPoints.get(0).Fleche(AllPoints.get(1));  //Fleche de P0 à P1
    }

    pop();
  }

  boolean isDedans(float xf, float yf) {
    boolean dedans = false;

    if (AllPoints.size() >= 3) {
      int i = 0;
      while (dedans == false) {
        TrianglePoint tri = AllTriangles.get(i);

        if (tri.selectionne) dedans = true;

        if (i == AllTriangles.size()-1) break;
        else i++;
      }
    }

    return dedans;
  }

  void UpdateTriangles() {
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
}
