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

Apple myApple;
Pear myPear;
public void setup(){
  
   myApple = new Apple(100,100,5);
   myPear = new Pear(200,100,5);
}

public void draw(){
  background(0);
  
  myApple.draw();
  myPear.draw();
}
class GameObject{
	PVector position;

	GameObject(float posX, float posY){
		this.position = new PVector(posX, posY);
	}
}
class Apple extends GameObject{
  int colApple = color(255,0,0,255);
  int radius;
  Apple(float x, float y, int r){
     super(x,y);
    this.radius = r;
  }  
  
  public void draw(){
    fill(colApple);
    circle(position.x, position.y, radius);
  }
}
class Pear extends GameObject{
  int colApple = color(0,255,0,255);
  int radius;
  Pear(float x, float y, int r){
      super(x,y);
      this.radius = r;
  }  
  
  public void draw(){
    fill(colApple);
    circle(position.x, position.y, radius);
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
