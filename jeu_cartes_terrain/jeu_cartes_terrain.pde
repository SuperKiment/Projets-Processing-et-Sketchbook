PImage fondherbe;
PImage BarreDenBas;
PImage No_1;
PImage No_2;
PImage No_3;
PImage No_4;
PImage No_5;
PImage No_6;
PImage No_7;
PImage No_8;
PImage No_9;
PImage No_10;
PImage No_11;
PImage No_12;
PImage No_13;
PImage InfoC_1;
PImage InfoC_2;
PImage InfoC_3;
PImage InfoC_4;
PImage InfoC_5;
PImage InfoC_6;
PImage InfoC_7;
PImage InfoC_8;
PImage InfoC_9;
PImage InfoC_10;
PImage InfoC_11;
PImage InfoC_12;
PImage InfoC_13;
PImage Selection_Vert_1;
PImage Selection_Bleu_2;
PImage Selection_Rouge_3;

PImage image_harpie;
PImage image_booster;
PImage image_bondisseur;
PImage image_fonceur;
PImage image_voyageur;
PImage image_ninja;
PImage image_tank;
PImage image_canon;
PImage image_samourai;
PImage image_healer;
PImage image_pietineur;
PImage image_balaise;
PImage image_cameleon;

boolean Debug_actif = false;

boolean DejaPasse = false;
boolean DejaClique = false;

int DepCartes = 0;
int ComptNbPerso;
int CompteTour = 1;               //Compte le nombre de tour
int Tour = 1;
int sourisG;


void setup() {
  fullScreen();
  frameRate(120);
  fondherbe = loadImage("texture_herbe.jpg");
  BarreDenBas = loadImage("Barre_D'en_Bas.png");

  Images_Des_Personnages();

  No_1 = loadImage("No_1.png");
  No_2 = loadImage("No_2.png");
  No_3 = loadImage("No_3.png");
  No_4 = loadImage("No_4.png");
  No_5 = loadImage("No_5.png");
  No_6 = loadImage("No_6.png");
  No_7 = loadImage("No_7.png");
  No_8 = loadImage("No_8.png");
  No_9 = loadImage("No_9.png");
  No_10 = loadImage("No_10.png");
  No_11 = loadImage("No_11.png");
  No_12 = loadImage("No_12.png");
  No_13 = loadImage("No_13.png");
  Selection_Vert_1 = loadImage("Selection_Vert_1.png");
  Selection_Bleu_2 = loadImage("Selection_Bleu_2.png");
  Selection_Rouge_3 = loadImage("Selection_Rouge_3.png");
  InfoC_1 =loadImage("Nada.png");
  InfoC_2 =loadImage("Nada.png");
  InfoC_3 =loadImage("Nada.png");
  InfoC_4 =loadImage("Nada.png");
  InfoC_5 =loadImage("Nada.png");
  InfoC_6 =loadImage("Nada.png");
  InfoC_7 =loadImage("Nada.png");
  InfoC_8 =loadImage("Nada.png");
  InfoC_9 =loadImage("Nada.png");
  InfoC_10 =loadImage("Nada.png");
  InfoC_11 =loadImage("Nada.png");
  InfoC_12 =loadImage("Nada.png");
  InfoC_13 =loadImage("Nada.png");


  No_x_vers_images();

  background(130);
  strokeWeight(20);
  line(0, 800, 1920, 800);
  line(1500, 0, 1500, 800);
  line(1920, 0, 1920, 1080);
  image(BarreDenBas, 0, 800);
  fill(0);

  noStroke();
  rect(1920, -20, 2160, 1200);
  rect(0, 1080, 2750, 1200);
  strokeWeight(20);


  Randomisation_des_Cartes_Au_Debut();
  Init_Tabl_General();
  Init_Tabl_RougeBleu();
}

void draw() {

  image(fondherbe, 0, 0);
  image(BarreDenBas, 0, 800);
  MouseX = mouseX-90;
  MouseY = mouseY-50;
  MouseXCartes = mouseX-57;

  Informations_Pour_Le_Joueur_Visuelles();
  Grille();
  Emplacement_Cartes();
  Numero_Cartes ();
  Numero_Case ();
  Affichage_Cartes();
  Selection_Cartes();
  Carte_Qui_Suit_la_Souris ();
  Vie_Des_Joueurs();

  Debug();
}

void mousePressed() {
  Prendre_et_Poser();

  Poser_les_cartes_sur_le_Terrain();

  Deplacement_Cartes();
}


void keyPressed() {

  if (key == 'a' && T_MouvInfini == 0) {
    T_MouvInfini = 1;
  } else {
    if (key == 'a' && T_MouvInfini == 1) {
      T_MouvInfini = 0;
    }
  }
  if (key == 'D') {
    Debug_actif = true;
  } 
  if (key == 'F') {
    Debug_actif = false;
    background(130);
    strokeWeight(20);
    stroke(0);
    line(0, 800, 1920, 800);
    line(1500, 0, 1500, 800);
    line(1920, 0, 1920, 1080);
    image(BarreDenBas, 0, 800);
    fill(0);
  }
  sourisG = 1;



  //******************************************************************************************************************************************************************************************************

  if (key == ' ' && Tour == 2 && Selec_Carte == 0 && SelecCarteGrille == false) {              //Changer manuellement de tour
    Tour = 1;
    ComptNbPerso = 0;
    NoCaseXTemp = 0;
    NoCaseYTemp = 0;
    CompteTour++;
    Redistribution_De_Cartes ();

    for (int XGrille = 0; XGrille<10; XGrille++) {
      for (int YGrille = 0; YGrille<4; YGrille++) {
        Tabl_CartesEffetsPos[YGrille][XGrille] = 0;
      }
    }
    for (int xTB = 0; xTB < 10; xTB++) {
      for (int yTB = 0; yTB < 4; yTB++) {
        Tabl_GDejaJoue[yTB][xTB] = 0;
      }
    }
    for (int x = 0; x<13; x++) {
      Tabl_Rouge_DejaJoue [x] = 0;
    }
  } else if (key == ' ' && Tour == 1 && Selec_Carte == 0 && SelecCarteGrille == false) {
    Tour = 2;
    ComptNbPerso = 0;
    NoCaseXTemp = 0;
    NoCaseYTemp = 0;
    CompteTour++;
    Redistribution_De_Cartes ();

    for (int xTB = 0; xTB < 10; xTB++) {
      for (int yTB = 0; yTB < 4; yTB++) {
        Tabl_GDejaJoue[yTB][xTB] = 0;
      }
    }
    for (int x = 0; x<13; x++) {
      Tabl_Bleu_DejaJoue [x] = 0;
    }
  }
}
void keyReleased() {
  sourisG = 0;
}
