//float scale = 1.0;

void setup() {
  size(1080, 720);
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
  float ecartText = height/30;
  textSize(ecartText);
  text("Outil : "+outil.modeSouris, width/25, ecartText + height/20);
  text("Style Triangles : "+corps.styleTri, width/25, 2*ecartText + height/20);
  if (timerSave>millis()) text("Sauvegardé !", width/25, 3*ecartText + height/20);

  fill(125);
  textSize(ecartText*3/4);
  text("Outils : |1| / |2| / |3| / |4|", width/25, height*9/10);
  text("Style Triangles : |F| / |G|", width/25, ecartText*3/4+height*9/10);
  text("Sauvegarde : |S|", width/25, 2*ecartText*3/4+height*9/10);

  pop();

  corps.Affichage();
  outil.Affichage();
}

Corps corps;
Outils outil = new Outils();
