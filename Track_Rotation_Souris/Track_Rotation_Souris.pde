void setup() {
  size(1000, 1000);
  background(0);
  noStroke();
  rectMode(CENTER);
}


void draw() {
  fill(0, 0, 0, 20);
  rect(0, 0, width*2, height*2);
  float x = width/2, y = height/2;
  float distX, distY, distSouris, rotation = 0;  //Variables
  float inversion = 1;

  distX = mouseX - x;  //Récupération de la distance entre mouseX et le centre
  distY = mouseY - y;

  if (distX > 0)inversion = 0;        //Si la souris est à gauche du point alors on ajoute PI
  if (distX < 0)inversion = PI;

  rotation = atan(distY/distX)+inversion;  //Calcul de la rotation avec l'inversion

  fill(255);
  text("distX : " + distX, 0, 20);    //Affichage de tout
  text("distY : " + distY, 0, 30);
  text("rotaion : " + rotation, 0, 40);
  
  distSouris = sqrt(pow(distX, 2) + pow(distY, 2));  //Distance à la souris

  translate(width/2, height/2);
  ellipse(0, 0, 20, 20);         //Affichage du truc
  rotate(rotation);
  rect(distSouris/2, 0, distSouris, 10);
}
