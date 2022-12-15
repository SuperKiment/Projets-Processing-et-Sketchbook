int NoCaseX = 99;
int NoCaseY = 99;
float MouseX = mouseX-90;
float MouseY = mouseY-50;

void Numero_Case () { 
  if (mouseX <= 90 || mouseX >= 1390 || mouseY <= 50 || mouseY >= 730) {
    NoCaseX = 99;
    NoCaseY = 99;
  } else {
    NoCaseX = int ((MouseX/1300+0.1)*10 - 1);
    NoCaseY = int((MouseY/680)*4+1 - 1);
  }
}
