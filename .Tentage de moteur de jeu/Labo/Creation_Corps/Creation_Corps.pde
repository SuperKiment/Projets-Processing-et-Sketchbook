
void setup() {
  size(500, 500);
  surface.setResizable(true);
  background(0);
  corps = new Corps();
  corps.Setup(loadJSONArray("Animaux/test.json"));
}

int timerSave = 0;

void draw() {
  background(0);
  push();
  fill(255);
  textSize(20);
  text("Outil : "+outil.modeSouris, 20, 50);
  if (timerSave>millis()) text("Sauvegarde...", 20, 80);
  pop();
  corps.Affichage();
  outil.Affichage();
  
  println("mouseX : "+mouseX+" mouseY : "+mouseY);
  println("mouseX tr : "+(mouseX-width/2)+" mouseY tr : "+(mouseY-height/2));
  
}

Corps corps;
Outils outil = new Outils();
