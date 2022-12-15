void setup() {
  size(600, 600);
  player = new Player();
  module = new Module(PI);
}

void draw() {
  background(0);
  player.Update();
  player.Display();
  
  module.Update();
  module.Display();
}

Player player;
Module module;

class Player {

  PVector pos;

  Player() {
    pos = new PVector(200, 200);
  }

  void Display() {
    ellipse(pos.x, pos.y, 50, 50);
  }

  void Update() {
  }
}


class Module {

  float ori = 0;
  PVector posC;

  Module(float d) {
    ori = d;
    posC = new PVector();
  }

  void Update() {
  }

  void Display() {
    ellipse(posC.x, posC.y, 20, 20);
  }
}


void keyPressed() {

  if (key == 'z') player.pos.y -= 10;
  if (key == 'q') player.pos.x -= 10;
  if (key == 's') player.pos.y += 10;
  if (key == 'd') player.pos.x += 10;
}
