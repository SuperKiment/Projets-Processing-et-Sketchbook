class Corps {

  float x = 250, y = 250;
  ArrayList<Point> AllPoints = new ArrayList<Point>();

  Corps() {
  }

  void Setup() {
    AllPoints.add(new Point(0, 50, 0));
    AllPoints.add(new Point(50, 50, 1));
    AllPoints.add(new Point(100, 0, 2));
    AllPoints.add(new Point(50, -50, 3));
    AllPoints.add(new Point(0, -50, 4));
    AllPoints.add(new Point(0, 50, 5));
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
      fill(150);
    } else fill(50);

    stroke(255);

    beginShape();
    for (Point point : AllPoints) {
      float vx = point.x, vy = point.y;
      vertex(vx, vy);
    }
    endShape();

    for (int i=0; i<AllPoints.size(); i++) {
      Point point = AllPoints.get(i);
      push();
      fill(255);
      textSize(10);
      text(i, point.x, point.y-10);
      pop();
    }

    AllPoints.get(0).Fleche(AllPoints.get(1));

    pop();
  }



  void Save() {
    JSONArray jsonCorps = new JSONArray();
    int compteur = 0;

    for (Point point : AllPoints) {
      JSONObject objPoint = new JSONObject();
      objPoint.setFloat("index", compteur);

      objPoint.setFloat("x", point.x);
      objPoint.setFloat("y", point.y);

      jsonCorps.setJSONObject(compteur, objPoint);

      compteur++;
    }

    saveJSONArray(jsonCorps, "Animaux/test.json");
    println("Saved");
  }
}
