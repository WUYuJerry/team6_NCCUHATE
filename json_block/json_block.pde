int[] x ={100, 200, 300};
int[] y ={150, 150, 150};

JSONObject json;

void setup() {
  
  JSONArray values = new JSONArray();

  for (int i = 0; i < species.length; i++) {

    JSONObject block = new JSONObject();

    animal.setInt("num", i);
    animal.setInt("x", x[i]);
    animal.setInt("y", y[i]);

    values.setJSONObject(i, block);
  }
  
  json = new JSONObject();
  json.setJSONArray("block", values);

  saveJSONObject(json, "data/new.json");
}