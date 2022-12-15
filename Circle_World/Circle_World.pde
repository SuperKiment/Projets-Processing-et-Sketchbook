color ally = color(88, 144, 255);
color ennemy = color(255, 88, 88);
color neutP = color(88, 255, 89);
color neutA = color(249, 288, 88);
color white = color(255, 255, 255);

void setup() {
  size(1280, 720);

  noStroke();
  rectMode(CENTER);
  textAlign(CENTER);
  
  for (int i = 0; i<nbEntites; i++) {
    Entites.add(new Entite(random(0, width), random(0, height), 20, Faction.Ally));
  }
}

void draw() {
  background(50);
  
  EntiteDisplay();
  fill(ally);
  rect(0, 0, 50, 50);
}
