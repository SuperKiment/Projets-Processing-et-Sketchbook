color blanc = color(255, 255, 255); //<>//
color noir = color(0, 0, 0);
int translateY;

int proc = 2;

void setup() {
  surface.setResizable(true);
  size(1600, 1000);  
  stroke(noir);
  fill(0);
  background(255);
  frameRate(60);

  AllBranches.add(new Branche(width/2, height/2));
}

void draw() {
  thread("getPlusHaut");
  background(255);
  translate(0, translateY);
  println(translateY);

  if (proc == 1) DrawProc1();

  if (mousePressed) {
    Branche b = new Branche(mouseX, mouseY);
    b.etat = 0;

    AllBranches.add(b);
  }

  AjoutB.clear();

  for (int i=0; i<AllBranches.size(); i++) {
    Branche b = AllBranches.get(i);
    b.Update();
    b.Display();

    if (b.morte()) {
      AllBranches.remove(i);
    }
  }

  AllBranches.addAll(AjoutB);
  
    line(0, posY, width, posY);

}

void mousePressed() {
  if (proc == 1) MouseProc1();

  Branche b = new Branche(mouseX, mouseY-translateY);
  b.etat = 0;

  AllBranches.add(b);
}

void keyPressed() {
  if (key == '2') {
    translateY += 20;
  }
}

ArrayList<Branche> AllBranches = new ArrayList<Branche>();
ArrayList<Branche> AjoutB = new ArrayList<Branche>();
color vert = color(#44D315);

class Branche {
  PVector pos, dir;
  float portee = 5;
  int etat = 0;
  color couleur = vert;

  Branche() {
    Constructor();
  }

  Branche(float x, float y) {
    Constructor();
    pos = new PVector(x, y);
  }

  void Constructor() {
    pos = new PVector();
    dir = PVector.random2D();
    if (dir.y > 0) dir.y = -dir.y;
    portee = random(portee/2, portee*2);
    dir.setMag(portee);
    etat = int(random(0, 5));
    if (etat == 3) etat = 0;
  }

  void Display() {
    if (etat == 0)stroke(255);
    if (etat == 1)stroke(50);
    if (etat == 2)stroke(0);
    line(pos.x, pos.y, pos.x+dir.x, pos.y+dir.y);
  }

  void Update() {
    if (etat == 2) {
      fill(50, 0, 200);
      ellipse(pos.x, pos.y, 5, 5);
      etat = 3;
    }

    if (etat == 1) {
      AjoutB.add(new Branche(pos.x+dir.x, pos.y+dir.y));
      etat = 2;
    }

    if (etat == 0) {
      AjoutB.add(new Branche(pos.x+dir.x, pos.y+dir.y));
      etat = 1;
    }
  }

  boolean morte() {
    if (etat == 3) return true;
    else return false;
  }
}

  float posY = 1000;

void getPlusHaut() {
  for (Branche b : AllBranches) {
    if (b.pos.y < posY) posY = b.pos.y;
  }
  translateY = -int(posY)+height/2;
}
