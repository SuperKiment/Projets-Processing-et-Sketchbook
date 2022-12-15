void setup() {
  size(1000, 800);
  frameRate(60);
  surface.setTitle("RonTech");
  surface.setResizable(true);
  surface.setIcon(loadImage("icon.png"));

  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  gameManager = new GameManager();
  time = new Time();
  hud = new HUD();


  map = new Map();
  camera = new Camera();

  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 50, PI, 0.1, 1));
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 20, 0, 0.2, 1));
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 40, PI/2, 0.07, 2));
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 100, PI*3/4, 0.02, 3));
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

    rectMode(CORNER);


    pop();
  }

  gameManager.PostUpdate();

  hud.Display();
}
