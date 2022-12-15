class Outils {
  String modeSouris = "Selectionner";
  Corps corpsCible;
  Point pointPr = new Point(0, 0, 0);
  Point pointSel = new Point(-1684, 1464, 0);
  float x, y;

  Outils() {
    corpsCible = corps;
  }

  void Affichage() {
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
  }

  void Click() {
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

      float distMin = 99999;
      for (Point p : corpsCible.AllPoints) {
        if (dist(x, y, p.x, p.y) < distMin) {
          distMin = dist(x, y, p.x, p.y);
          pointPr = p;
        }
      }
      pointSel = pointPr;
    }

    if (modeSouris == "Point") {
      corps.AllPoints.add(int(pointSel.index), new Point(mouseX-width/2, mouseY-height/2, int(pointSel.index+1)));
      float distMin = 99999;
      for (Point p : corpsCible.AllPoints) {
        if (dist(x, y, p.x, p.y) < distMin) {
          distMin = dist(x, y, p.x, p.y);
          pointPr = p;
        }
      }
      pointSel = pointPr;
    }
  }

  void Fleche(float x1, float y1, Point point) {
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

  float Direction(Point point) {
    float distX, distY, rotation = 0;  //Variables
    float inversion = 1;

    distX = point.x - mouseX+width/2;  //Récupération de la distance entre mouseX et le centre
    distY = point.y - mouseY+height/2;

    if (distX > 0)inversion = 0;        //Si la souris est à gauche du point alors on ajoute PI
    if (distX < 0)inversion = PI;

    rotation = atan(distY/distX)+inversion;  //Calcul de la rotation avec l'inversion

    return rotation;
  }
}

void keyPressed() {
  if (key == 's') {
    corps.Save();
    timerSave = millis()+1000;
  }

  if (key == '&') outil.modeSouris = "Point";
  if (key == 'é') outil.modeSouris = "Effacer";
  if (key == '"') outil.modeSouris = "Selectionner";
}

void mousePressed() {
  outil.Click();
}
