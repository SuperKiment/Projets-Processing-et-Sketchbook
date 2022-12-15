class Outils {
  String modeSouris = "Selectionner";
  Corps corpsCible;
  Point pointPr = new Point(0, 0, 0);
  Point pointSel = new Point(-1684, 1464, 0);
  float x, y;

  boolean colorMode = false;

  color couleurFill, couleurLine;
  int Rl = 255, Gl = 255, Bl = 255;
  int Rf = 100, Gf = 100, Bf = 100;

  String selColor = "Line";
  char selRGB = 'R';

  Outils() {
    corpsCible = corps;
  }
  //                                         PERM
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

    couleurFill = color(Rf, Gf, Bf);               //Couleur
    couleurLine = color(Rl, Gl, Bl);

    corps.setColor(couleurLine, couleurFill);
    corps.modification = !colorMode;
  }


  //                                             CLICK
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

      PointProche();
      pointSel = pointPr;
    }

    if (modeSouris == "Point") {
      corps.AllPoints.add(int(pointSel.index), new Point(mouseX-width/2, mouseY-height/2, int(pointSel.index+1)));
      PointProche();
      pointSel = pointPr;
    }
  }

  void PointProche() {
    float distMin = 99999;
    for (Point p : corpsCible.AllPoints) {
      if (dist(x, y, p.x, p.y) < distMin) {
        distMin = dist(x, y, p.x, p.y);
        pointPr = p;
      }
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

  void setColor(color line, color fill) {
    couleurLine = line;
    couleurFill = fill;

    Rl = int(red(couleurLine));
    Gl = int(green(couleurLine));
    Bl = int(blue(couleurLine));

    Rf = int(red(couleurFill));
    Gf = int(green(couleurFill));
    Bf = int(blue(couleurFill));
  }
}

void keyPressed() {
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

void mousePressed() {
  outil.Click();
}
