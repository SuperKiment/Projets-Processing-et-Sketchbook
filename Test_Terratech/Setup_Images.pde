void SetupImages() {
  basicHull = LoadBlocImage(6, "Textures_Blocs/Basic_Hull/");
}

PImage basicHull[];

PImage[] LoadBlocImage(int nb, String path) {
  PImage[] tabl = new PImage[nb];
  for (int i = 0; i<tabl.length; i++) {
    String no = "Basic_Hull_" + i + ".png";

    tabl[i] = loadImage(path + no);
  }
  return tabl;
}
