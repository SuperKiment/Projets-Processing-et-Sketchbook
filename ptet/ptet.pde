Point no1 = new Point (random(0, 2)*PI);
Point no2 = new Point (random(0, 2)*PI);
Point no3 = new Point (random(0, 2)*PI);
Point no4 = new Point (random(0, 2)*PI);
Point no5 = new Point (random(0, 2)*PI);
Point no6 = new Point (random(0, 2)*PI);
Point no7 = new Point (random(0, 2)*PI);


void setup() {
  frameRate(150);
  size (1500, 1000); 
  fill(0);
}

void draw() {
  no1.affichage();
  no2.affichage();
  no3.affichage();
  no4.affichage();
  no5.affichage();
  no6.affichage();
  no7.affichage();
}

class Point {
  float xpos = random(0, 1000);
  float ypos = random(0, 1000);
  float direction;
  float mvtx;
  float mvty;

  Point(float dir) {
    direction = dir;
  }

  void affichage() {
    stroke(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
    point (xpos, ypos);
    mvtx = cos(direction)*3;
    mvty = sin(direction)*3;
    xpos = xpos + mvtx;
    ypos = ypos + mvty;


    if (xpos > 1000) { 
      mvtx = -mvtx;
      
    }
    if (xpos < 0) { 
      mvtx = -mvtx;
      
    }
    if (ypos > 1000) { 
      direction = direction + HALF_PI;
      ypos = 999;
    }
    if (ypos < 0) { 
      direction = direction + HALF_PI;
      ypos = 1;
    }
  }
}
