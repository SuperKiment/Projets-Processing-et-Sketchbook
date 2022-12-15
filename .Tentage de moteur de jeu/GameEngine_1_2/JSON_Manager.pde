BufferedReader JSONReader;

void JSON_Setup() {
  saveMonde(AllMondes.get("monde1"));
}


void saveMonde(Monde monde) {
  JSONObject jsonMonde = new JSONObject();
  JSONObject jsonGrille = monde.grille.getJSONGrille();  
  JSONObject jsonEntites = monde.getJSONEntites();  
  JSONObject jsonProperties = new JSONObject();  


  jsonProperties.setInt("width", monde.grille.grilleCases.length);
  jsonProperties.setInt("height", monde.grille.grilleCases[0].length);
  jsonProperties.setInt("Entites count", monde.AllEntites.size());
  jsonProperties.setString("name", monde.name);

  jsonMonde.setJSONObject("Grille", jsonGrille);
  jsonMonde.setJSONObject("Entites", jsonEntites);
  jsonMonde.setJSONObject("Properties", jsonProperties);
  
  
  saveJSONObject(jsonMonde, "Mondes/"+monde.name + ".json");
}
