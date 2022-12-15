int tabl[];
boolean fini = false;

void setup() {
  stroke(255);
  size(600, 600);
  frameRate(600);

  tabl = new int [600];

  for (int i=0; i<600; i++) {
    tabl[i] = int(random(0, 600));
  }

  thread("Tri");
}

int posD = 0;

void draw() {
  background(0);

  if (fini) {
    stroke(125);
  } else stroke(255);

  for (int i=0; i<600; i++) {
    line(i, 0, i, tabl[i]);
  }
}

void Tri() {
  while (!fini) {
    for (int i=0; i<100; i++) {
      //Tri1();      
      Tri2();
    }

    delay(1);
  }
}

void Tri1() {
  int pos1 = int(random(0, 599));
  int pos2 = int(random(pos1, 600));

  if (tabl[pos1] > tabl[pos2]) {
    int trans = tabl[pos1];
    tabl[pos1] = tabl[pos2];
    tabl[pos2] = trans;
  }
}

int count = 0;

void Tri2() {
  if (tabl[posD] > tabl[posD + 1]) {
    int trans = tabl[posD];
    tabl[posD] = tabl[posD+1];
    tabl[posD+1] = trans;
    count = 0;
  }

  posD++;
  count++;
  if (count >= 600) fini = true;

  if (posD >= 599) {
    posD = 0;
  }
}
