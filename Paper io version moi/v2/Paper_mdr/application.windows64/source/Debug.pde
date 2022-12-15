void Debug() {
  push();

  fill(50, 50, 50, 50);
  noStroke();
  rect(0, 0, 1000, 300);

  fill(0, 255, 0);
  textSize(10);

  text("ID1 " + ID1, 10, 20); 
  text("ID2 " + ID2, 10, 30); 
  text("dataIn " + dataIn, 10, 40);

  if (DataIn[1] != null) {
    if (float(DataIn[1]) == ID1) text("DataIn[0] ID1 : " + DataIn[0], 10, 50);
    if (float(DataIn[1]) == ID2) text("DataIn[0] ID2 : " + DataIn[0], 10, 60);
  }

  text("dataIn1 " + dataIn1, 10, 70);
  text("dataIn2 " + dataIn2, 10, 80);
  
  text("dataOut " + dataOut, 10, 90);

  pop();
}
