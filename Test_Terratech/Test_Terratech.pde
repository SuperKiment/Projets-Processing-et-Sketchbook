void setup() {
  size(1000, 800);
  surface.setTitle("PlaTech");
  surface.setResizable(true);

  PImage icon = new PImage();
  icon = loadImage("icon.png");
  surface.setIcon(icon);

  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  gameManager = new GameManager();
  hud = new HUD();

  SetupImages();

  map = new Map();
  camera = new Camera();
}

void draw() {
  background(#27813D);

  gameManager.PreUpdate();

  if (gameManager.isPlay()) {    
    //Physics (à threader)
    map.Update();
  }

  if (!gameManager.isTitle()) {
    //Display
    push();  
    camera.Update();
    camera.Translate();

    map.Display();
    pop();
  }

  gameManager.PostUpdate();

  hud.Display();
}
