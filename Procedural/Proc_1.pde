int portee = 20;
int chance = 100;

void DrawProc1() {
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      if (get(x, y) != blanc) {
        pointR(x+portee, y);
        pointR(x-portee, y);
        pointR(x, y+portee);
        pointR(x, y-portee);
      }
    }
  }
}

void pointR(float x, float y) {
  int rand = int(random(1, chance));
  if (rand == 1) {
    //stroke(random(1, 255), random(1, 255), random(1, 255));
    point(x, y);
  }
}

void MouseProc1() {
  rect(mouseX, mouseY, 5, 5);
}
