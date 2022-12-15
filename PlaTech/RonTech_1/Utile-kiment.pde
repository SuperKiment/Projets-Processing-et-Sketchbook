float GrToSn(float x) {
  return x*map.tailleCase;
}

float SnToGr(float x) {  
  return x/map.tailleCase;
}

PVector Rotate(PVector v, float a) {
  PVector r = new PVector();

  r.x = v.x * cos(a) - v.y * sin(a);
  r.y = v.x * sin(a) + v.y * cos(a);

  return r;
}
