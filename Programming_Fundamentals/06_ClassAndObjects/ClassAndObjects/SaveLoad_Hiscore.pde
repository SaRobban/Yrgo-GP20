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
  File file = new File(dataPath("hiscore.json"));

  if (file.exists()){
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

//scala cordinater
//push
//pop