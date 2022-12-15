void setup() {
  surface.setTitle("Game Engine Test");
  surface.setResizable(true);
  size(1000, 1000);
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

  mondeActif.AllEntites.get(0).corps.AllTriangles.get(0).Affichage(
    mondeActif.AllEntites.get(1).corps.AllPoints.get(0).x, 
    mondeActif.AllEntites.get(1).corps.AllPoints.get(0).y
    );

  mondeActif.AllEntites.get(1).corps.AllTriangles.get(0).Affichage(
    mondeActif.AllEntites.get(0).corps.AllPoints.get(0).x, 
    mondeActif.AllEntites.get(0).corps.AllPoints.get(0).y
    );

  mondeActif.AllEntites.get(0).corps.AllTriangles.get(0).Affichage(
    mouseX-camera.translX, mouseY-camera.translY
    );

  Devant();
  println("-------------");
}
