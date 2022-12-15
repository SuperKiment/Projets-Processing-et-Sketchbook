class Point {
  float x, y, index;
  Point(float nx, float ny, int ni) {
    x = nx;
    y = ny;
    index = ni;
  }


  public void Fleche(Point point) {
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


  public float Direction(Point point) {
    float distX, distY, rotation = 0;  //Variables
    float inversion = 1;

    distX = point.x - x;  //Récupération de la distance entre mouseX et le centre
    distY = point.y - y;

    if (distX > 0)inversion = 0;        //Si la souris est à gauche du point alors on ajoute PI
    if (distX < 0)inversion = PI;

    rotation = atan(distY/distX)+inversion;  //Calcul de la rotation avec l'inversion

    return rotation;
  }
}



class TrianglePoint {

  Point p1, p2, p3;

  boolean selectionne = false;

  TrianglePoint(Point np1, Point np2, Point np3) {
    p1 = np1;
    p2 = np2;
    p3 = np3;
  }

  boolean isDedans(float mx, float my) {

    float x1 = p1.x, y1 = p1.y;
    float x2 = p2.x, y2 = p2.y;
    float x3 = p3.x, y3 = p3.y;
    float x = mx, y = my;

    double ABC = Math.abs (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2));
    double ABP = Math.abs (x1 * (y2 - y) + x2 * (y - y1) + x * (y1 - y2));
    double APC = Math.abs (x1 * (y - y3) + x * (y3 - y1) + x3 * (y1 - y));
    double PBC = Math.abs (x * (y2 - y3) + x2 * (y3 - y) + x3 * (y - y2));

    boolean isInTriangle = ABP + APC + PBC == ABC;

    selectionne = ABP + APC + PBC == ABC;

    return isInTriangle;
  }

  void Affichage(float mx, float my) {
    push();
    stroke(50);
    if (isDedans(mx, my))fill(185);
    else fill(80);

    beginShape(TRIANGLE_STRIP);

    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);

    endShape(CLOSE);
    pop();
  }
}
