int xShipD;
int yShipD;
boolean Ship_D_H;
boolean Ship_D_B;
boolean Ship_D_G;
boolean Ship_D_D;


void Ini_Aff_D() {
  xShipD = width*11/12;    //Initialise la position du Ship Droite
  yShipD = height/2;
}


void Vaisseau_D_Aff() {
  fill(255);
  noStroke();                                  //Affiche le Ship Droite
  rect(xShipD, yShipD, width/30, height/20);
}

void Vaisseau_D_Contr() {
  if (Ship_D_H == true) yShipD = yShipD - 3;
  if (Ship_D_G == true) xShipD = xShipD - 3;    //Contrôle du Ship
  if (Ship_D_B == true) yShipD = yShipD + 3;
  if (Ship_D_D == true) xShipD = xShipD + 3;

  if (xShipG > width-(width/30)) xShipG = width-(width/30)-1;
  if (yShipG > height-(height/20)) yShipG = height-(height/20)-1;   //Collisions du Ship
  if (xShipG < 0) xShipG = 1;
  if (yShipG < 0) yShipG = 1;
}
