
PVector pos;
float x, x2, y, y2, y3;

void setup() {
  size(1000, 800);
  pos = new PVector(500, 500);
}

void draw() {
  background(0);
  fill(255);
  noStroke();

  ellipse(pos.x, pos.y, 50, 50);
}


public class SODyn {

  PVector xp, y, yd;
  float k1, k2, k3;

  SODyn(float f, float z, float r, PVector v) {
    k1 = z/(PI*f);
    k2 = 1/(sqrt(2*PI*f));
    k3 = r*z/(2*PI*f);

    xp = v;
    y = v;
    yd = new PVector(0, 0);
  }

  PVector Update(float T, PVector x, PVector xd) {
    if (xd == null) {
      xd = x;
      xd.sub(xp);
      xd.div(T);
      
      xp = x;
    }
    
    PVector add = yd;
    add.mult(T);
    y.add(add);
    
    PVector add2 = x;
    
    return y;
  }
}
