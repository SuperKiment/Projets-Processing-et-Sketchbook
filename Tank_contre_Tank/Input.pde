void keyPressed() {
  if (key == 'z') AllTanks.get(0).forw  = true;
  if (key == 'q') AllTanks.get(0).left  = true;
  if (key == 's') AllTanks.get(0).back  = true;
  if (key == 'd') AllTanks.get(0).right = true;
  if (key == 'c') AllTanks.get(0).canon.Tir();
}

void keyReleased() {
  if (key == 'z') AllTanks.get(0).forw  = false;
  if (key == 'q') AllTanks.get(0).left  = false;
  if (key == 's') AllTanks.get(0).back  = false;
  if (key == 'd') AllTanks.get(0).right = false;
}

void mousePressed() {
  placeMur.Reset();
  placeMur.lock = true;
}
void mouseReleased() {
  placeMur.Place();
  placeMur.lock = false;
}
