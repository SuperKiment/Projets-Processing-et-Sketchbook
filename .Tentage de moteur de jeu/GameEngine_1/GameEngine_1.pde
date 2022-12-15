void setup() {
  surface.setTitle("Game Engine Test");
  size(600, 600);
  background(0);
  smooth();

  Setup_Mondes();
}

void draw() {
  consoleE = new FenValeurs(500);
  camera.Translate();
  Fond();

  mondeActif.Affichage_Entites();
  consoleE.add(mondeActif.AllEntites.get(0).InfosBase());
  consoleE.add(mondeActif.AllEntites.get(0).InfosCollision());
  
  Devant();
}
