class Bot {

  float x;
  float y;
  int vitesse = 1;
  char orientation = 'd';
  color couleur;
  color couleurligne;

  float coorPt1 = 100;
  float coorPt2 = 200;

  Bot(color newcouleur, float newx, float newy) {
    couleur = newcouleur;
    x = newx;
    y = newy;
  }

  void Affichage() {
    push();

    translate(x, y);
    float orientation2 = 0;
    if (orientation == 'd') orientation2 = 0;
    if (orientation == 'g') orientation2 = PI;
    if (orientation == 'h') orientation2 = PI/2;
    if (orientation == 'b') orientation2 = 3*PI/2;
    rotate(-orientation2);
    noStroke();
    fill(couleurligne - 100);
    rect(20, 0, 20, 60);

    pop();

    push();

    strokeWeight(3);
    fill(couleur);
    stroke(couleurligne);

    rect(x, y, 50, 50);

    pop();
  }

  void D() {
    if (orientation != 'g') orientation = 'd';
  }
  void G() {
    if (orientation != 'd') orientation = 'g';
  }
  void H() {
    if (orientation != 'b') orientation = 'h';
  }
  void B() {
    if (orientation != 'h') orientation = 'b';
  }

  void Deplacement() {
    if (orientation == 'd') x += vitesse;
    if (orientation == 'g') x -= vitesse;
    if (orientation == 'h') y -= vitesse;
    if (orientation == 'b') y += vitesse;

    if (x < 0) x++;
    if (x > 1000) x--;
    if (y < 0) y++;
    if (y > 1000) y--;
  }
}
