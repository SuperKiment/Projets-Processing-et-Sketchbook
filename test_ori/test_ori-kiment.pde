void setup() {
  size(600, 600);
  player = new Player();
  player.AllModules.add(module = new Module(PI/8));
}

void draw() {
  background(0);
  player.Update();
  player.Display();
}

Player player;
Module module;

class Player {

  PVector pos;

  ArrayList<Module> AllModules;

  Player() {
    pos = new PVector(200, 200);
    AllModules = new ArrayList<Module>();
  }

  void Display() {

    for (Module m : AllModules) {
      m.Display();
    }

    ellipse(pos.x, pos.y, 50, 50);
  }

  void Update() {
    for (Module m : AllModules) {
      m.Update(pos);
    }
  }
}


class Module {

  float ori = 0, dist = 50;
  PVector pos, posA;

  Module(float d) {
    ori = d;
    pos = new PVector();
  }

  void Update(PVector p) {
    pos.lerp(p, 0.1);
  }

  void Display() {
    push();
    translate(pos.x, pos.y);
    rotate(-ori);


    ellipse(dist, 0, 20, 20);

    pop();
  }
}


void keyPressed() {

  if (key == 'z') player.pos.y -= 10;
  if (key == 'q') player.pos.x -= 10;
  if (key == 's') player.pos.y += 10;
  if (key == 'd') player.pos.x += 10;
}
