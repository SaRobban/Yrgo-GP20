//thx. Jonatan Johansson, Jimmy Saarela  
JSONObject json;

void CreateNewFile() {
  println("Created new file");
  json = new JSONObject();
  json.setInt("Highscore", score);
  saveJSONObject(json, "data/hiscore.json");
}


void SaveHiScore(int score) {
  json.setInt("Highscore", score);
  saveJSONObject(json, "data/hiscore.json");
}


int LoadHiScore() {
  File f = new File(dataPath("hiscore.json"));

  if (f.exists()){
    println("file exist");
    json = loadJSONObject("data/hiscore.json");
    int oldScore = json.getInt("Highscore");
    return oldScore;
    
  }else{
    println("Try to create new file");
    CreateNewFile();
    return score;
  }
}