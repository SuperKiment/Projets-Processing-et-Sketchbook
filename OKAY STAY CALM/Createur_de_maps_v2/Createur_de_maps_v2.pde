void setup() {
  size(1280, 720); 
  noStroke();
  smooth();
  GrilleReset();
  
  
}

void draw() {
  background(0);
  Camera();
  
  GrilleRemplacement();

  GrilleAffichage(50, 0, 0);
  MenuAffichage();
  
  text(String.valueOf(clickG), 10, 10);
}
