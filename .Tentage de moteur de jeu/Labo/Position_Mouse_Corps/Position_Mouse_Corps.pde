float x = 100, y = 100, x1 = 300, y1 = 200;


void setup() {
  size(500, 500);
}

void draw() {

  if (isDessous(mouseX, mouseY, x, y, x1, y1, "dessus")) background(255);
  else background(125);
  
  strokeWeight(5);
  stroke(0);
  point(x, y);
  point(x1, y1);
  strokeWeight(2);
  line(x, y, x1, y1);
}



boolean isDessous(float mx, float my, float x1, float y1, float x2, float y2, String sens) {
  boolean dessous = false;

  float a = (y2-y1)/(x2-x1);
  float b = -(a*x1-y1);  
  float yf = a*mx+b;

  if (sens == "dessous") {
    if (my < yf) dessous = false;
    else dessous = true;
  } else { 
    if (my > yf) {
      dessous = false;
    } else dessous = true;
  }

  return dessous;
}
