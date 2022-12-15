Block blo1G  = new Block(0, 0, 10, 10);
Block blo2G  = new Block(0, 0, 10, 10);
Block blo3G  = new Block(0, 0, 10, 10);//         Création des Blocks
Block blo4G  = new Block(0, 0, 10, 10);
Block blo5G  = new Block(0, 0, 10, 10);

Block blo1D  = new Block(0, 0, 10, 10);
Block blo2D  = new Block(0, 0, 10, 10);
Block blo3D  = new Block(0, 0, 10, 10);
Block blo4D  = new Block(0, 0, 10, 10);
Block blo5D  = new Block(0, 0, 10, 10);

Tir tir_G = new Tir(10000, 0, 25, 25);
Tir tir_D = new Tir(10000, 0, 25, 25);

void setup() {
  background(100);
  fullScreen();
  frameRate(120);

  rectMode(CENTER);

  Ini_Aff_D();      //Initialisation des Vaisseaux
  Ini_Aff_G();

  Ini_Grille();//Initialisation de la grille (peu utile au final)
  Ini_Blocks();//Initailisation des emplacements et tailles des blocks

  print("size : " + width + " / " + height);
}


void draw() {
  Grille();  //Affichage du background

  Affichage_Tirs();    //Affichage des Tirs

  Vaisseau_G_Aff();  //Affichage des Vaisseaux
  Vaisseau_D_Aff();

  Vaisseau_G_Contr();  //Contrôle des Vaisseaux
  Vaisseau_D_Contr();

  Affichage_Blocks();  //Affichage des Blocks
}

void keyPressed() {
  if (key == 'z') Ship_G_H = true;
  if (key == 'q') Ship_G_G = true;  //Contrôle du Ship Gauche
  if (key == 's') Ship_G_B = true;
  if (key == 'd') Ship_G_D = true;

  if (key == 'o') Ship_D_H = true;
  if (key == 'k') Ship_D_G = true;  //Contrôle du Ship Droite
  if (key == 'l') Ship_D_B = true;
  if (key == 'm') Ship_D_D = true;


  if (key == 'b') Retour_Case_Depart();  //Retour à l'emplacement de base des Ships

  if (key == 'e') Pose_De_Block_G();  //Pose de Block Gauche
  if (key == 'a') Tir_G();            //Tir Gauche
  
  if (key == 'p') Tir_D();            //Tir Droite
}

void keyReleased() {
  if (key == 'z') Ship_G_H = false;
  if (key == 'q') Ship_G_G = false;
  if (key == 's') Ship_G_B = false;
  if (key == 'd') Ship_G_D = false;

  if (key == 'o') Ship_D_H = false;
  if (key == 'k') Ship_D_G = false;
  if (key == 'l') Ship_D_B = false;
  if (key == 'm') Ship_D_D = false;
}
