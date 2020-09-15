import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GameMaster extends PApplet {

int black = color(0, 0, 0,255);
int neonRed = color(255, 0, 128,255);
int neonPurp = color(128, 0, 255,255);
int neonPink = color(255, 0, 255,255);
int gray = color(128, 128, 128,255);

public void setup(){
	
}

public void draw(){
	background(black);
	strokeWeight(2);
	stroke(neonRed);
	line(0,0,256,256);
	stroke(neonPink);
		line(256,256,512,512);
}
  public void settings() { 	size(512,512); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GameMaster" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
