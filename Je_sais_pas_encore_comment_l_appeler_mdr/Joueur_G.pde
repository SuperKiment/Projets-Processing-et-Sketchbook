int xShipG;
int yShipG;
boolean Ship_G_H;
boolean Ship_G_B;
boolean Ship_G_G;
boolean Ship_G_D;


void Ini_Aff_G() {
  xShipG = width/12;       //Initialise la position du Ship Gauche
  yShipG = height/2;
}


void Vaisseau_G_Aff() {
  fill(255);
  noStroke();                                  //Affiche le Ship Gauche
  rect(xShipG, yShipG, width/30, height/20);
}

void Vaisseau_G_Contr() {
  if (Ship_G_H == true) yShipG = yShipG - 3;
  if (Ship_G_G == true) xShipG = xShipG - 3;    //Contrôle du Ship
  if (Ship_G_B == true) yShipG = yShipG + 3;
  if (Ship_G_D == true) xShipG = xShipG + 3;

  if (xShipD > width-(width/30)) xShipD = width-(width/30)-1;
  if (yShipD > height-(height/20)) yShipD = height-(height/20)-1;   //Collisions du Ship
  if (xShipD < 0) xShipD = 1;
  if (yShipD < 0) yShipD = 1;
}
