void setup() {
  size(1080, 720);
  surface.setResizable(true);
  surface.setTitle("Création de corps");
  PImage icon = null;
  try {
    icon = loadImage("data/icon.png");
  }
  catch(Exception e) {
    println("Pas d'icon");
  }
  if (icon != null) surface.setIcon(icon);

  corps = new Corps();
  corps.Setup("Animaux/test.json");
  corps.modification = true;
}


void draw() {
  Interface();
  corps.Affichage(width/2, height/2);
  outil.Affichage();
}




Corps corps;
Outils outil = new Outils();




int timerSave = 0;

public void Interface() {
  background(0);

  stroke(125);
  line(0, height/2, width, height/2);   //Croix mid ecran
  line(width/2, 0, width/2, height);

  push();

  fill(255);
  float ecartText = height/30;
  textSize(ecartText);
  text("Outil : "+outil.modeSouris, width/25, ecartText + height/20);
  text("Style Triangles : "+corps.styleTri, width/25, 2*ecartText + height/20);
  if (timerSave>millis()) text("Sauvegardé !", width/25, 3*ecartText + height/20);

  fill(125);
  textSize(ecartText*3/4);
  text("Outils : |1| / |2| / |3|", width/25, -3*ecartText*3/4+height*9/10);
  text("Style Triangles : |F| / |G|", width/25, -2*ecartText*3/4+height*9/10);
  text("Sauvegarde : |A|", width/25, -ecartText*3/4+height*9/10);
  text("Choisir Couleur : |Z| / |Q| / |S| / |D|", width/25, height*9/10);
  text("Changer Couleur : |W| / |X|", width/25, ecartText*3/4+height*9/10);
  text("Voir Couleur : |C|", width/25, 2*ecartText*3/4+height*9/10);


  fill(0);
  stroke(255);       //COULEUR
  rectMode(CENTER);
  translate(width*3.5/4, height*3/4);
  rect(0, 0, width/4, height/4); //Base

  fill(255);
  textAlign(CENTER);
  translate(0, -height/12);
  text("Couleur", 0, 0);  //Titres

  text("Fill", 0, ecartText);
  text("Line", 0, height/8);

  fill(0);

  float hRect = height/25, wRect = width/20;   //Cases

  float selX = 0, selY = 0;
  if (outil.selColor.equals("Line")) {
    selY = 5*ecartText;
  } else selY = 2*ecartText;
  if (outil.selRGB == 'R') selX = -width/12;
  if (outil.selRGB == 'G') selX = 0;
  if (outil.selRGB == 'B') selX = width/12;
  
  rect(selX, selY, wRect*1.5, hRect*1.5);

  rect(-width/12, 2*ecartText, wRect, hRect);
  rect(0, 2*ecartText, wRect, hRect);
  rect(width/12, 2*ecartText, wRect, hRect);

  rect(-width/12, 5*ecartText, wRect, hRect);
  rect(0, 5*ecartText, wRect, hRect);
  rect(width/12, 5*ecartText, wRect, hRect);

  fill(255);
  text(int(red(outil.couleurFill)), -width/12, 2.2*ecartText);
  text(int(green(outil.couleurFill)), 0, 2.2*ecartText);
  text(int(blue(outil.couleurFill)), width/12, 2.2*ecartText);

  text(int(red(outil.couleurLine)), -width/12, 5.2*ecartText);
  text(int(green(outil.couleurLine)), 0, 5.2*ecartText);
  text(int(blue(outil.couleurLine)), width/12, 5.2*ecartText);


  pop();
}
