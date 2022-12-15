void Images_Des_Personnages() {
  image_harpie =     loadImage("Nada.png");
  image_booster =    loadImage("Booster.png");
  image_bondisseur = loadImage("Nada.png");
  image_fonceur =    loadImage("Nada.png");
  image_voyageur =   loadImage("Nada.png");
  image_ninja =      loadImage("Nada.png");
  image_tank =       loadImage("Tank.png");
  image_canon =      loadImage("Nada.png");
  image_samourai =   loadImage("Nada.png");
  image_healer =     loadImage("Nada.png");
  image_pietineur =  loadImage("Nada.png");
  image_balaise =    loadImage("Nada.png");
  image_cameleon =   loadImage("Nada.png");
}



class Harpie {
  int xPos;
  int yPos;
  PImage Images_passif[] = new PImage [7];
  PImage Images_action[] = new PImage [10];
  Harpie(int x, int y) {
    xPos = x;
    yPos = y;
  }
}


void No_x_vers_images() {
  //No_1 =  image_harpie;
  No_2 =  image_booster;
  //No_3 =  image_bondisseur;
  //No_4 =  image_fonceur;
  //No_5 =  image_voyageur;
  //No_6 =  image_ninja;
  No_7 =  image_tank;
  //No_8 =  image_canon;
  //No_9 =  image_samourai;
  //No_10 = image_healer;
  //No_11 = image_pietineur;
  //No_12 = image_balaise;
  //No_13 = image_cameleon;
}
