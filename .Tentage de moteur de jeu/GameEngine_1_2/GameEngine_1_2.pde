void setup() {
  surface.setTitle("Game Engine Test");
  surface.setResizable(true);
  size(600, 600);
  background(0);
  smooth();

  Setup_Mondes();

  JSON_Setup();
}

void draw() {
  consoleE = new ConsoleE(500);
  camera.Translate();
  Fond();

  mondeActif.Affichage_Entites();

  if (camera.focus != null) {
    consoleE.add("Entité focus :");
    consoleE.add(camera.focus.InfosBase());
    consoleE.add(camera.focus.InfosEntitesProches());
    consoleE.add(camera.focus.InfosCollisions());
    consoleE.add(camera.focus.InfosThreads());
  }

  consoleE.add("FrameRate : "+frameRate);

  Devant();
}
