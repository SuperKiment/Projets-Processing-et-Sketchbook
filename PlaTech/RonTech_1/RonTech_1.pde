void setup() {
  size(1000, 800);
  surface.setTitle("RonTech");
  surface.setResizable(true);
  surface.setIcon(loadImage("icon.png"));
  
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  gameManager = new GameManager();
  hud = new HUD();


  map = new Map();
  camera = new Camera();
  
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 50));
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 20));
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 40));
  map.AllPlayers.get(0).AllModules.add(new Module(map.AllPlayers.get(0), 100));

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
