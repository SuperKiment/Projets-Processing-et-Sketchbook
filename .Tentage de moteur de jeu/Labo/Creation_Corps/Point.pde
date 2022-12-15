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
