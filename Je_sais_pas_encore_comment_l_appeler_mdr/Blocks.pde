class Block {
  int x;//Coordonnées du Block
  int y;
  int taillex;//Taille du Block
  int tailley;

  boolean actif = false;


  Block (int nouvx, int nouvy, int nouvtaillex, int nouvtailley) {   //Constructeur
    x = nouvx;
    y = nouvy;
    taillex = nouvtaillex;
    tailley = nouvtailley;
  }

  void aff() {     //Affichage des Blocks (Changeable)        Garder (x, y, taillex, tailley)
    rectMode(CENTER);
    rect(x, y, taillex, tailley);
  }


  void deplacement() {
    x = xShipG + 100;
    y = yShipG + 100;
    taillex = 100;
    tailley = 500;
  }
}


void Pose_De_Block_G() {
  
}

void Affichage_Blocks() {
  blo1G.aff();
  blo2G.aff();   //Affichage des blocks Gauche
  blo3G.aff();
  blo4G.aff();
  blo5G.aff();


  blo1D.aff();
  blo2D.aff();   //Affichage des blocks Droite
  blo3D.aff();
  blo4D.aff();
  blo5D.aff();
}


void Ini_Blocks() {
  blo1G.x = width*1/30;
  blo1G.y = height/15;
  blo1G.taillex = width/50;   //Initialisation des blocks Gauche
  blo1G.tailley = height/10;

  blo2G.x = width*2/30;
  blo2G.y = height/15;
  blo2G.taillex = width/50;
  blo2G.tailley = height/10;

  blo3G.x = width*3/30;
  blo3G.y = height/15;
  blo3G.taillex = width/50;
  blo3G.tailley = height/10;

  blo4G.x = width*4/30;
  blo4G.y = height/15;
  blo4G.taillex = width/50;
  blo4G.tailley = height/10;

  blo5G.x = width*5/30;
  blo5G.y = height/15;
  blo5G.taillex = width/50;
  blo5G.tailley = height/10;



  blo1D.x = width*25/30;
  blo1D.y = height*14/15;
  blo1D.taillex = width/50;   //Initialisation des blocks Droite
  blo1D.tailley = height/10;

  blo2D.x = width*26/30;
  blo2D.y = height*14/15;
  blo2D.taillex = width/50;
  blo2D.tailley = height/10;

  blo3D.x = width*27/30;
  blo3D.y = height*14/15;
  blo3D.taillex = width/50;
  blo3D.tailley = height/10;

  blo4D.x = width*28/30;
  blo4D.y = height*14/15;
  blo4D.taillex = width/50;
  blo4D.tailley = height/10;

  blo5D.x = width*29/30;
  blo5D.y = height*14/15;
  blo5D.taillex = width/50;
  blo5D.tailley = height/10;
}
