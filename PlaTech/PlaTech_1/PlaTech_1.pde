void setup() {
  size(1000, 800);
  surface.setTitle("PlaTech");
  surface.setResizable(true);
  surface.setIcon(loadImage("icon.png"));

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
    if (camera.trackCible) {
      camera.Update();
      camera.Translate();
    }

    map.Display();
    PVector a = map.AllEnsembles.get(0).getPosBlocInMap(13, 12);
    rectMode(CORNER);
    rect(a.x, a.y, map.tailleBlocs, map.tailleBlocs);

    pop();
  }

  gameManager.PostUpdate();

  hud.Display();
}
