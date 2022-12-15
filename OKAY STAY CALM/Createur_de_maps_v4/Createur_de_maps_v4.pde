void setup() {
  size(1280, 720); 
  noStroke();
  smooth();
  GrilleReset();

  lines = loadStrings(fichier);
  linesZero = lines[0];
  println(linesZero.length()/2);
  println(lines.length);
}




void draw() {
  background(0);
  Camera();

  GrilleRemplacement();

  GrilleAffichage(50, 0, 0);
  MenuAffichage();

  text(String.valueOf(clickG), 10, 10);
}
