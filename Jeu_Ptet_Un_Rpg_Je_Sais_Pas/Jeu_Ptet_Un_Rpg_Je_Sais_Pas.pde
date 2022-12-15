 //<>//
//---------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
  size(1000, 1000);
}

//---------------------------------------------------------------------------------------------------------------------------------------------
int verif;
void draw() {
  background(50);


  //----------------------------------FOND



  Camera();
  pushMatrix();                     //Sauvegarde des transformations
  
  scale(echelle); 
  translate(xOrigine, yOrigine);    //Placement de l'origine du fond
  
  Villageois();

  popMatrix();                      //Restauration de la sauvegarde


  //----------------------------------INTERFACE 
  Debug();
}
