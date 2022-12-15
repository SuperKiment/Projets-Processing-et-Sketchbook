void setup() {
  size(1000, 800);
  surface.setTitle("Bot Maker goes brrr");
  surface.setResizable(true);
  surface.setIcon(loadImage("icon.png"));

  SetupImages();
  SetupBlocs();

  background(0);
}

void draw() {
  background(125);

  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}
