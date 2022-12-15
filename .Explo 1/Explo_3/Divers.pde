void TranslateArPl() {
  translate(-joueur1.xSui+width/2-25, -joueur1.ySui+height/2-25);
}

void TitePhrases() {
  String[] PhrasesDebut = loadStrings("Random Titres.txt");
  int noRand = int(random(0, PhrasesDebut.length-1));

  surface.setTitle(PhrasesDebut[noRand]);
}
