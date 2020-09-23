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

public class CollisionAndZombies extends PApplet {


Ball myBall;

public void setup(){
  
   myBall = new Ball(100, 100);
}

public void draw(){
  background(255);

  //instanceof Apple
  //myObject.drawK();
}
class GameObject{
	PVector position;
	PVector localPosition;
	PVector rotation;
	PVector localrotation;
	PVector scale;
	
	GameObject(PVector position, PVector rotation, PVector scale){
		this.position = position;
		this.rotation = rotation;
		this.scale = scale;
	}


}

  public void settings() {  size(512, 512); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CollisionAndZombies" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
