ArrayList<Particule> particules = new ArrayList <Particule>();

void setup() {
  size(500, 500);
  background(0);
  noSmooth();
  surface.setResizable(true);
}

float vitesseMax = 5;
float nbPartMax = 100;

void draw() {
  frameRate(1000);
  //background(0);

  Particule particule = new Particule(random(0, width), random(0, height), random(-vitesseMax, vitesseMax), random(-vitesseMax, vitesseMax));
  particules.add(particule);
  for (int i = 0; i < particules.size(); i++) {
    Particule part = particules.get(i);
    part.Tout();
    if (part.Delet()) particules.remove(i);
  }

  if (particules.size() > nbPartMax && nbPartMax >= 0) particules.remove(int(random(0, particules.size()-1)));
  fill(0);
  rect(width/2, height/2-10, 60, 30);
  fill(255);
  text(particules.size(), width/2, height/2);
  text(vitesseMax, width/2, height/2+10);
  text(nbPartMax, width/2, height/2+20);
}

class Particule {

  float x, y, mvtx, mvty;

  Particule(float nx, float ny, float nmvtx, float nmvty) {
    x = nx;
    y = ny;
    mvtx = nmvtx;
    mvty = nmvty;
  }

  void Affichage() {
    fill(255);
    stroke(255);
    //ellipse(x, y, 10, 10);
    point(x, y);
  }

  void Depl() {
    x+=mvtx;
    y+=mvty;
  }

  boolean Delet() {
    boolean delet = false;
    if (x>width || x<0 || y>width || y<0) { 
      return delet = true;
    } else {
      return delet = false;
    }
  }

  void Tout() {
    Depl();
    Affichage();
  }
}

void keyPressed() {
  if (key == '+') vitesseMax++;
  if (key == '-') vitesseMax--;
  if (key == '*') nbPartMax--;
  if (key == '9') nbPartMax++;
  if (key == ' ') background(0);
}
