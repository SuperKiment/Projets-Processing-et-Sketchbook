void setup() {
  size(1080, 720);
  noStroke();
  Setup_Tanks();
  Setup_Murs();
  rectMode(CENTER);
}

boolean clickP, clickR;

void draw() {
  background(0);
  Fonctions_Tanks();
  Fonctions_Murs();
  ParticuleFonctions();
  
  placeMur.Fonctions();

  clickP = false;
  clickR = false;
}
