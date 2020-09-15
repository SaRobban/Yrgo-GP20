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

public class vector extends PApplet {


XYaxlar cordSys;
Point pointer;

int offset = 20;

int cordScale = 20;

Direction dir;

int bg = color (40,41,35,255);
int colOne = color (50,52,46,255);
int colTwo = color (70,72,66,255);
int colTre = color (40,41,35,255);

public void setup(){
	//noLoop();
	
	cordSys = new XYaxlar(offset, offset, 320, 320, cordScale, colOne, colTwo);
	//dir = new Direction(340,20,150,50);
}


public void draw(){
	background(bg);
	cordSys.DrawXY();

}	

public void mousePressed() {
	boolean lc = false;
	boolean rc = false;
	if(mouseButton == LEFT)
		lc = true;

	if(mouseButton == RIGHT)
		rc = true;

	cordSys.Clicked(mouseX, mouseY, rc, lc);
}

public boolean Contains(float posX, float posY, float minX, float maxX, float minY, float maxY){
	if(posX < maxX && posX > minX){
		if(posY < maxY && posY > offset)
			return true;
	}
	return false;
}

public void Arrow(PVector from, PVector to, int col){

	

	stroke(col);	
	line(from.x, from.y, to.x, to.y);


	float rad = PI * 0.25f;

	PVector dir = new PVector();

	dir.x = from.x - to.x;
	dir.y = from.y - to.y;

	//dir.set(from.sub(to));  //BUG???????????????

	dir = dir.normalize();
	dir = dir.rotate(rad);
	dir.mult(10);


	line(to.x, to.y, to.x + dir.x, to.y + dir.y);

	dir = dir.rotate(rad * -2);
	line(to.x, to.y, to.x + dir.x, to.y + dir.y);

}
class BDisplay{
	int posX;
	int posY;
	int sizeX;
	int sizeY;

	String head;
	String display;

	BDisplay(int posX, int posY, int sizeX, int sizeY){
		this.posX = posX;
		this.posY = posY;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
		head = new String();
		display = new String();
	}

	public void SetText(String header, String display){
		print(header);
		this.head = header;
		this.display = display;
	}

	public void Draw(int col, int fill){
		stroke(col);
		fill(fill);
		rect(posX, posY, sizeX, sizeY);


		if(head.isEmpty() || display.isEmpty()){
			line(posX, posY, posX + sizeX, posY + sizeY);
		}else{
			textSize(12);
			text(head, posX, posY);
			fill(255,0,0);
			text(display, posX + 10, posY + 15);
		}
	}
}
class Direction{
	int posX;
	int posY;
	int sizeX;
	int sizeY;

		String head;
				String display;

	Direction(int posX, int posY, int sizeX, int sizeY){
		this.posX = posX;
		this.posY = posY;
		this.sizeX = sizeX;
		this.sizeY = sizeY;
	}

	public void setText(String head, String display){
		this.head = head;
		this.display = display;
	}

	public void Draw(String headder, String display, int col, int fill){
		stroke(col);
		fill(fill);
		rect(posX, posY, sizeX, sizeY);
		line(posX, posY, posX + sizeX, posY + sizeY);

		textSize(12);
		
		text(headder, posX, posY);

		
		fill(255,0,0);
		text("V1", posX + 10, posY + 20);
		fill(0,255,0);
		text("     V2", posX + 10, posY + 20); // SCACE = NUMBER OF CHARACTERS
		fill(col);
		text(display, posX + 10, posY + 20);
	}
}



class Point{
	PVector cord;
	PVector pos;
	float radius;
	int col;
	int cordScale;

	Point(int x, int y, int off, float radius, int col, int scal){
		this.pos = new PVector(x,y);
		this.radius = radius;
		this.col = col;

		
		this.cordScale = scal;

		this.cord = new PVector((x - off), (y - off));

	}

	public void setPosition(int x, int y, int off){
		pos.set(x, y);
		cord.set(x - off, y - off);
	}



	public float GetFakePosX(){
		return cord.x / cordScale;
	}

	public float GetFakePosY(){
		return (cord.y / cordScale);
	}

	public void DrawCord(){
		textSize(12);
		fill(col);
		text(("X" + (cord.x / cordScale) + "\nY" + (cord.y / cordScale)), pos.x + radius * 2, pos.y + radius);
	}
	public void Draw(){
		fill(col);
		noStroke();
		circle(pos.x, pos.y, radius);
		stroke(255);
	}
}
//Class cordinatSystem
class XYaxlar{
	PVector origo;
	PVector xAxis;
	PVector yAxis;
	int cordScale;

	Point pOne;
	Point pTwo;

	int colOne;
	int colTwo;

	BDisplay direction; 
	BDisplay sqrMagnitude;
	BDisplay distance;
	

	//Constructor
	XYaxlar(int origoX, int origoY, int endX, int endY, int scal, int cOne, int cTwo){
 
		this.origo = new PVector(origoX, origoY);
		this.xAxis = new PVector(endX, origoY);
		this.yAxis = new PVector(origoX, endY);
		this.cordScale = scal;
		this.colOne = cOne;
		this.colTwo = cTwo;

		this.direction = new BDisplay(origoX, endY + 20, 200, 20);
		this.sqrMagnitude = new BDisplay(origoX, endY + 60, 200, 40);

		this.distance = new BDisplay(origoX, endY + 120, 200, 40);
	}

	public void DrawXY(){
		stroke(colOne);
		for(int x = 0; x < xAxis.x -cordScale; x += cordScale){
			line(origo.x + x, origo.y, origo.x + x, yAxis.y);
			line(origo.x, origo.y + x, xAxis.x, origo.y + x);
		}

		Arrow(origo, xAxis, color(colTwo));
		Arrow(origo, yAxis, color(colTwo));

		if(pOne != null){
			pOne.Draw();
			pOne.DrawCord();
		}

		if(pTwo != null){
			pTwo.Draw();
			pTwo.DrawCord();
		}



		//Draw Boxes
		direction.Draw(colOne, colTwo);
		sqrMagnitude.Draw(colOne, colTwo);
		distance.Draw(colOne, colTwo);
	}

	public int GetSizeX(){
		return (int)xAxis.x;
	}

	public int GetSizeY(){
		return (int)yAxis.y;
	}

	public void Clicked(float x, float y, boolean rc, boolean lc){
		if(Contains(x, y, origo.x, xAxis.x, origo.y, yAxis.y)){

			int posX = round(x * 0.1f);
			int posY = round(y * 0.1f);
			posX *= 10;
			posY *= 10;
			
			if (lc) {
				if(pOne == null){
					pOne = new Point(posX, posY, offset, 5.0f, color(0,255,0,255), cordScale);
				}
				pOne.setPosition(posX, posY, offset);
			}
			else if (rc) 
			{
				if(pTwo == null){
					pTwo = new Point(posX, posY, offset, 5.0f, color(255,0,0,255), cordScale);
				}
				pTwo.setPosition(posX, posY, offset);
			}
		}

		Calculate();
	}


	public void Calculate(){
		if(pOne != null && pTwo != null){

			PVector vectOne = new PVector(pOne.GetFakePosX(), pOne.GetFakePosY());
			PVector vectTwo = new PVector(pTwo.GetFakePosX(), pTwo.GetFakePosY());

			PVector dir = vectTwo.sub(vectOne);
			direction.SetText("Direction", ("V2 - V1 = " + "dirX " + dir.x + " dirY " + dir.y));// ("V1 - V2 = " +(String)dir));

			

			PVector comp = new PVector(pOne.GetFakePosX(), pOne.GetFakePosY());
			float compSqr = comp.magSq();
			float vecSqr = dir.magSq();

			if(compSqr < vecSqr){
				sqrMagnitude.SetText("Squared Magnitude", ("Dir * Dir = " + vecSqr + "\n" + "V1 is closer to Origo then V2"));
			}else{
				sqrMagnitude.SetText("Squared Magnitude", ("Dir * Dir = " + vecSqr + "\n" + "V1 is closer to V2 then Origo"));
			}

			float dist = dir.mag();
			distance.SetText("Distance", "√ (dir * dir) = " + dist + "\n"+"V1 distance to V2");
		}
	}
}
  public void settings() { 	size(512,512); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "vector" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
