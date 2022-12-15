
void setup() {
  size(500, 500);
  surface.setResizable(true);  
  background(0);
  corps = new Corps();
  corps.Setup();
}

void draw() {
  background(0);
  push();
  fill(255);
  textSize(20);
  text("Outil : "+outil.modeSouris, 20, 50);
  pop();
  corps.Affichage();
  outil.Affichage();
}

Corps corps;
Outils outil = new Outils();
