JSONArray json;

void setup() {
  size(500, 500);

  json = loadJSONArray("trucs.json");

  for (int i=0; i<json.size(); i++) {
    JSONObject obj = json.getJSONObject(i);
    
    float x = obj.getFloat("x");
    float y = obj.getFloat("y");
    
    AllTrucs.add(new Truc(x, y));
    
  }
}

void draw() {
  background(0);

  for (Truc truc : AllTrucs) {
    truc.Affichage();
  }
}
