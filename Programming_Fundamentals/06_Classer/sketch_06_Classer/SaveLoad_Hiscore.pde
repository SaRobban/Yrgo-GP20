  
PrintWriter output;
JSONObject json;
/*
void setup() {
  // Create a new file in the sketch directory
  output = createWriter("data/hiscore.json"); 
}
*/

void CreateNewFile() {

  File myObj = new File("data/hiscore.json");
  //myObj.CreateNewFile();
  output = createWriter("positions.txt"); 

  println("Created new file");

  json = new JSONObject();

  json.setInt("Highscore", 0);
  saveJSONObject(json, "hiscore.json");
}


void SaveHiScore(int score) {


  //json = new JSONObject();
  json.setInt("Highscore", score);

  saveJSONObject(json, "data/hiscore.json");
}



int LoadHiScore() {
  String filename = "hiscore.json";

  File f = new File(dataPath("hiscore.json"));

  if (f.exists())
  {
    println("file exist");
    json = loadJSONObject("data/hiscore.json");
    int oldScore = json.getInt("Highscore");
    return oldScore;
    
  }else{
    println("Create new file");
    

   //CreateNewFile();
    return 0;
  }
}