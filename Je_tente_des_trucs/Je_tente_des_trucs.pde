float xpos = 50;
float ypos = 50;
float pi = 3.14159265359;
float xmvt;
float ymvt;
float angle;

float [][] Tabl = new float [500][500];

int couleur = 50;

boolean toucheD = false;
boolean toucheG = false;

void setup() {
  size(500, 500);

  for (int x = 0; x < 500; x++) {
    for (int y = 0; y < 500; y++) {
      Tabl[y][x] = 0;
    }
  }
}

void draw() {
  background(couleur);


  xpos = xpos + xmvt;
  ypos = ypos + ymvt;

  xmvt = cos(angle);
  ymvt = sin(angle);

  ellipse(xpos, ypos, 20, 20);
  if (Tabl[int(xpos)][int(ypos)] == 1) couleur = 255;


  if (toucheD == true) angle = angle + pi/48;
  if (toucheG == true) angle = angle - pi/48;

  Tabl[int(ypos)][int(xpos)] = 1;
  //Tabl[int(ypos+1)][int(xpos)] = 1;
  //Tabl[int(ypos-1)][int(xpos)] = 1;
  //Tabl[int(ypos)][int(xpos-1)] = 1;

  for (int x = 0; x < 500; x++) {
    for (int y = 0; y < 500; y++) {
      if (Tabl[y][x] == 1) point(x, y);
    }
  }
}


void keyPressed() {
  if (key == 'd') toucheD = true;
  if (key == 'q') toucheG = true;
}
void keyReleased() {
  if (key == 'd') toucheD = false;
  if (key == 'q') toucheG = false;
}
