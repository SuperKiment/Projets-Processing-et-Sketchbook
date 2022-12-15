boolean afficher = false;
boolean a_jour = false;

void setup() {
  size(1117, 931);
}

void draw() {
  background(0);
  Cadres();
  Rectangles('g');
  Rectangles('d');
  Rectangles('t');
  Rectangles('i');
  Lignes();
  A_jour();
}




void keyPressed() {
  if (key == ' ') afficher = true;
  if (key == 'a') a_jour = true;
}

void keyReleased() {
  if (key == ' ') afficher = false;
  if (key == 'a') a_jour = false;
}




void Cadres() {
  strokeWeight(2);
  stroke(255, 255, 255, 255);
  fill(30);

  rect(width/24, height/3, (width/24)*10.64, height*3/6-width/48, 60, 0, 0, 0);          //Gauche haut
  rect(width*12.5/24, height/3, (width/24)*10.62, height*2/3-width/24, 0, 60, 60, 0);     //Droite
  rect(width/6, width/24, width*2/3, height/3-2*width/24, 70, 70, 0, 0);                  //Haut
  rect(width/24, height*5/6, (width/24)*10.64, height/6-width/24, 0, 0, 0, 60);   //Gauche bas
}


void Rectangles(char rect) {
  noStroke();
  fill(120);

  if (rect == 'g') {
    for (int i = 0; i < 5; i ++) {
      rect(400, 420 + i*60, 80, 40, 5);    //Piti  cadre G
      rect(100, 420 + i*60, 270, 40, 20);  //Grand cadre G
    }
  }
  if (rect == 'd') {
    for (int i = 0; i < 7; i ++) {
      rect(940, 420 + i*60, 80, 40, 5);    //Piti  cadre D
      rect(640, 420 + i*60, 270, 40, 20);  //Grand cadre D
    }
  }

  if (rect == 't') {
    rect(70, 810, 170, 40, 20);  //Temperature
    rect(270, 810, 80, 40, 5);
  }

  fill(80);

  if (rect == 'i') {
    rect(200, 342, 170, 50);   //Titres
    rect(740, 342, 170, 50);
  }
}


void Lignes() {

  stroke(255, 255, 255, 125);
  strokeWeight(1);

  if (afficher == true) {

    line(width/2, 0, width/2, height);

    line(0, height/3, width, height/3);
    line(0, height*2/3, width, height*2/3);

    line(width/24, 0, width/24, height);
    line(width*23/24, 0, width*23/24, height);

    line(width*11.5/24, 0, width*11.5/24, height);
    line(width*12.5/24, 0, width*12.5/24, height);

    line(width/3, 0, width/3, height);
    line(width*2/3, 0, width*2/3, height);
  }
}


void A_jour() {
  textSize(20);
  if (a_jour == true) {
    fill(10, 255, 10);
    text(" A jour", width*2/6+40, height*21.5/24+2);
    fill(10, 255, 10);
  }
  if (a_jour == false) {
    fill(255, 10, 10);
    text(" Retardé", width*2/6+40, height*21.5/24+2);
    fill(255, 10, 10);
  }
  noStroke();
  ellipse(width*2/6+20, height*21.5/24-5, 30, 30);
}
