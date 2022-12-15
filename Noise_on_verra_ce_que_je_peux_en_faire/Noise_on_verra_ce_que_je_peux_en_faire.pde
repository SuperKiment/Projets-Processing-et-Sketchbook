int baseInt = 241;
float zoom = 5;
float range = 1;
int limit1 = 125;
int limit2 = 125;

int res = 500;

void setup() {
  size(500, 500);
}


void draw() {
  background(255);
  

  for (float x=0; x<range; x=x+range/res) {
    for (float y=0; y<range; y=y+range/res) {
      float col=noise(x*10, y*10)*255;
      noStroke();

      col = Limits(col);

      fill(col);
      rect(x*width, y*height, zoom, zoom);
    }
  }
}

float Limits(float col) {
  if (col>limit2) col = 255;
  else if (col<limit1) col = 0;
  return col;
}

void keyPressed() {
  if (key == 'a') res += 20;
  if (key == 'z' && res-20 > 0) res -= 20;
  
  println(res);
}
