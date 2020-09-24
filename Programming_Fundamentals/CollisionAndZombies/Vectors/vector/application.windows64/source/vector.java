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


int colbgA = color (40,41,35,255);
int colbgB = color (50,52,46,255);
int colBgC = color (70,72,66,255);
int colbgD = color (40,41,35,255);

int colInfoTextA = color(0, 0, 0, 255);
int colInfoTextB = color(0, 0, 0, 255);

PFont font;

public void setup(){
	
	font = loadFont("Consolas-12.vlw");
	textFont(font, 12);

	//noLoop();
	
	cordSys = new XYaxlar(offset, offset, 320, 320, cordScale, colbgA, colbgB);
	reDraw();
}


public void draw(){
}	


public void reDraw(){
	background(colbgA);
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
	reDraw();
}


//Special thx. Robin Bono, Daniel Nielsen, Jonatan Johansson, Simon Johansson
class Arrow{
	PVector from;
	PVector to;
	int col;
	int thickness;

	Arrow(PVector from, PVector to, int col, int thickness){
		this.from = from;
		this.to = to;
		this.col = color(red(col), green(col), blue(col), 128);
		this.thickness = thickness;

		//Shorten for grfx
		PVector subDir = PVector.sub(from, to);
		subDir.normalize();
		subDir.mult(thickness * 2);
		this.from.sub(subDir);
		this.to.add(subDir);
	}

	public void drawArrow(){
		stroke(col);
		
		strokeWeight(thickness);	
		line(from.x, from.y, to.x, to.y);

		float rad = PI * 0.25f;

		PVector dir = PVector.sub(from, to);
		dir = dir.normalize();
		dir = dir.rotate(rad);
		dir.mult(5);

		line(to.x, to.y, to.x + dir.x, to.y + dir.y);

		dir = dir.rotate(rad * -2);
		line(to.x, to.y, to.x + dir.x, to.y + dir.y);
	}


	public void drawLine(){
		stroke(col);
		
		strokeWeight(thickness);	
		line(from.x, from.y, to.x, to.y);

		float rad = PI * 0.5f;

		PVector dir = PVector.sub(from, to);
		dir = dir.normalize();
		dir = dir.rotate(rad);
		dir.mult(5);

		line(to.x, to.y, to.x + dir.x, to.y + dir.y);
		line(from.x, from.y, from.x + dir.x, from.y + dir.y);

		dir = dir.rotate(rad * 2);
		line(to.x, to.y, to.x + dir.x, to.y + dir.y);
		line(from.x, from.y, from.x + dir.x, from.y + dir.y);
	}
}
class BDisplay{
	boolean active = false;

	int posX;
	int posY;
	int sizeX;
	int sizeY;

	int lineThickness = 3;

	int cGreen;
	int cRed;
	int cOther;
	int cBase;
	String textHeader;
	String textGreen;
	String textRed;
	String textOther;
	String textInBox;
	
	BDisplay(){
		this.posX = 0;
		this.posY = 0;
		this.sizeX = 0;
		this.sizeY = 0;
		this.textHeader = new String();
		this.textGreen = new String();
		this.textRed = new String();
		this.textInBox = new String();
		this.textOther = new String();

		this.cGreen = color(0,255,0,255);
		this.cRed = color(255,0,0,255);
		this.cOther = color(0,255,255,255);
		this.cBase = color(0,255,255,255);
	}

	BDisplay(int posX, int posY, int sizeX, int sizeY, int colBase){
		this.posX = posX;
		this.posY = posY;
		this.sizeX = sizeX;
		this.sizeY = sizeY;

		this.textHeader = new String();
		this.textGreen = new String();
		this.textRed = new String();
		this.textInBox = new String();
		this.textOther = new String();

		this.cGreen = color(0,255,0,255);
		this.cRed = color(255,0,0,255);
		this.cOther = color(0,255,255,255);
		this.cBase = colBase;
	}


	public void toggleActive(){
		active = !active;
		print("\n" + active);
	}


	public boolean getActive(){
		return active;
	}


	public int getColorBase(){
		return this.cBase;
	}


	public void setColorGreen(int c){
		cGreen = c;
	}


	public void setColorRed(int c){
		cRed = c;
	}


	public void setColorOther(int c){
		cOther = c;
	}

	public void SetText(String header, String textGreen, String textRed, String textOther, String textInBox){
		this.textHeader = header;
		this.textInBox = textInBox;
		this.textGreen = textGreen;
		this.textRed = textRed;
		this.textOther = textOther;
	}


	public boolean clicked(float clickPosX, float clickPosY){
		if(clickPosX < posX + sizeX && clickPosX > posX){
			if(clickPosY < posY + sizeY && clickPosY > posY){
				toggleActive();
				return true;
			}
		}
		return false;
	}


	public void draw(int boxBg){
		fill(boxBg);
		noStroke();
		rect(posX, posY, sizeX, sizeY);

		//textSize(12);
		//textFont(font, 12);

		if(!textHeader.isEmpty()){
			
			text(textHeader, posX, posY - 2);
		}
		if(!textGreen.isEmpty()){
			fill(cGreen);
			text(textGreen, posX + 10, posY + 15);
		}
		if(!textRed.isEmpty()){
			fill(cRed);
			text(textRed, posX + 10, posY + 15);
		}
		if(!textOther.isEmpty()){
			fill(cOther);
			text(textOther, posX + 10, posY + 15);
		}

		if(!textInBox.isEmpty()){
			fill(cBase);
			text(textInBox, posX + 10, posY + 15);
		}
	}
}



//This is the code for direction between two points
public PVector getDirectionBetween(PVector v1, PVector v2){
	return PVector.sub(v2, v1);
}

public PVector getDirectionNormalizedBetween(PVector v1, PVector v2){
	PVector v = PVector.sub(v2, v1);
	return v.normalize();
}

public float getSqrDistanceBetween(PVector v1, PVector v2){
	PVector v = PVector.sub(v2, v1);
	return v.magSq();
}

//This is the code for distance between two points
public float getDistanceBetween(PVector v1, PVector v2){
	return PVector.dist(v1,v2);
}



class Point{
	String name;
	PVector cord;
	PVector pos;
	float radius;
	int col;
	int cordScale;

	Point(String name, int x, int y, int off, float radius, int col, int scal){
		this.name = name;
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

	public PVector getPosition(){
		return pos.copy();
	}

	public float getFakePosX(){
		return cord.x / cordScale;
	}

	public float getFakePosY(){
		return (cord.y / cordScale);
	}

	public void drawCord(){
		textSize(12);
		fill(col);
		text(name + "\n" + "X" + (cord.x / cordScale) + "\nY" + (cord.y / cordScale), pos.x + radius * 2, pos.y + radius);
	}
	public void draw(){
		fill(col);
		noStroke();
		circle(pos.x, pos.y, radius);
		stroke(255);
	}
}
class Direction extends BDisplay{
	Arrow arrow;

	Direction(int posX, int posY, int sizeX, int sizeY, int colBase){
		super(posX, posY, sizeX, sizeY, colBase);
	}

	public void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		PVector fakeDir = PVector.sub(v2, v1);
		PVector realDir = PVector.sub(realV2, realV1);
		PVector target = PVector.add(realV1, realDir);
		this.arrow = new Arrow(realV1, target, cBase, lineThickness);
		this.SetText(
			"Direction", 
			"   V1",
			"V2","",
			"  -   = direction\n" + 
			"dirX" + nf(fakeDir.x,0,1) + " dirY" + nf(fakeDir.y,0,1)
		);
	}


	public void draw(int boxBg){
		super.draw(boxBg);
		if(super.active)
			arrow.drawArrow();
	}
}



class DirectionNormalized extends BDisplay{
	Arrow arrow;

	DirectionNormalized(int posX, int posY, int sizeX, int sizeY, int colBase){
		super(posX, posY, sizeX, sizeY, colBase);
	}

	public void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		PVector fakeDirN = PVector.sub(v2, v1);
		fakeDirN.normalize();

		PVector realDir = PVector.sub(realV2, realV1);
		realDir.normalize();
		realDir.mult(20 + lineThickness);
		PVector target = PVector.add(realV1, realDir);
		this.arrow = new Arrow(realV1, target, cBase, lineThickness);
		this.SetText(
			"Direction normalized", "","",
			"dir  dir",
			"   /√   ² = normalized" +"\n" + "dirX" + nf(fakeDirN.x,0,2) + "  dirY" + nf(fakeDirN.y,0,2)
		);
	}


	public void draw(int boxBg){
		super.draw(boxBg);
		if(super.active)
			arrow.drawArrow();
	}
}


class SqrMagnitude extends BDisplay{
	Arrow line;
	Arrow lineB;
	PVector fakeOrigo;

	SqrMagnitude(int posX, int posY, int sizeX, int sizeY, int colBase, PVector fakeOrigo){
		super(posX, posY, sizeX, sizeY, colBase);
		this.fakeOrigo = fakeOrigo;
	}

	public void setCalculation(PVector v1, PVector v2, PVector realV1, PVector realV2){
		PVector fakeDir = PVector.sub(v2, v1);
		float fakeMagSq = fakeDir.magSq();
		PVector realDir = PVector.sub(realV2, realV1);

		float compSq = v1.magSq();
		//float realMagSq = realDir.magSq();
		PVector target = realDir.normalize();
		target.mult(fakeMagSq * 20);
		target.add(realV1);

		this.lineB = new Arrow(realV1.copy(), fakeOrigo.copy(), color(32,32,32), lineThickness);
		this.line = new Arrow(realV1, target, cBase, lineThickness);
		
		if(compSq < fakeMagSq){
			this.SetText(
				"Squared Magnitude","\nV1",                  
				"\n                           V2         " + nf(fakeMagSq,3,2),
				"Direction Direction",
				"         *          = Squared Magnitude" + "\n" + 
				"   is closer to Origo then    ("+ nf(compSq,3,2) + "<" + "      )"
			);
		}else{
			this.SetText(
				"Squared Magnitude","\nV1",                  
				"\n                V2                    " + nf(fakeMagSq,3,2),
				"Direction Direction",
				"         *          = Squared Magnitude" + "\n" + 
				"   is closer to    then Origo ("+ nf(compSq,3,2) + ">" + "      )"
			);
		}
	}


	public void draw(int boxBg){
		super.draw(boxBg);
		if(super.active){
			this.line.drawLine();
			this.lineB.drawLine();
		}
	}
}

//Class cordinatSystem
class XYaxlar{
	PVector origo;
	PVector xAxis;
	Arrow arrowX;
	PVector yAxis;
	Arrow arrowY;
	int cordScale;

	Point pOne;
	Point pTwo;

	int cBgA;
	int cBgB;
	int colArrow;
	int arrowThickness;

	Direction direction;
	DirectionNormalized directionNormal;
	SqrMagnitude sqrMagnitude;
	BDisplay distance;
	BDisplay dotProduct;

	//scalar
	//angle

	//Constructor
	XYaxlar(int origoX, int origoY, int endX, int endY, int scal, int cBgA, int cBgB){
 
		this.origo = new PVector(origoX, origoY);
		this.xAxis = new PVector(endX, origoY);
		this.yAxis = new PVector(origoX, endY);
		this.cordScale = scal;
		this.cBgA = cBgA;
		this.cBgB = cBgB;
		this.colArrow = color(255, 255, 0, 255);
		this.arrowThickness = 3;

		this.direction = new Direction(origoX, endY + 20, 140, 40, color(255, 128, 0));
		this.directionNormal = new DirectionNormalized(origoX + 160, endY + 20, 140, 40, color(255, 255, 0));
		this.sqrMagnitude = new SqrMagnitude(origoX, endY + 80, 300, 40, color(255, 64, 0), origo.copy());

		this.distance = new BDisplay(origoX, endY + 140, 300, 40, color(255, 32, 0));
	}

	public int GetSizeX(){
		return (int)xAxis.x;
	}

	public int GetSizeY(){
		return (int)yAxis.y;
	}

	public void DrawXY(){

		//DrawGrid BG
		stroke(cBgB);
		strokeWeight(1);
		for(int x = 0; x < xAxis.x - cordScale; x += cordScale){
			line(origo.x + x, origo.y, origo.x + x, yAxis.y);
			line(origo.x, origo.y + x, xAxis.x, origo.y + x);
		}

		//Draw Boxes and functions
		direction.draw(cBgB);
		directionNormal.draw(cBgB);
		sqrMagnitude.draw(cBgB);
		//distance.draw(cBgB);


		//Draw Vectors
		if(pOne != null){
			pOne.draw();
			pOne.drawCord();
		}

		if(pTwo != null){
			pTwo.draw();
			pTwo.drawCord();
		}
	}

	

	public void Clicked(float x, float y, boolean rc, boolean lc){
		//Clicked functions
		if(pOne != null && pTwo != null){
			direction.clicked(x, y);
			directionNormal.clicked(x,y);
			sqrMagnitude.clicked(x,y);
		}


		//Clicked vectorfield
		if(Contains(x, y, origo.x, xAxis.x, origo.y, yAxis.y)){
			int posX = round(x * 0.1f);
			int posY = round(y * 0.1f);
			posX *= 10;
			posY *= 10;
			
			if (lc) {
				if(pOne == null){
					pOne = new Point("V1", posX, posY, offset, 5.0f, color(0,255,0,255), cordScale);
				}
				pOne.setPosition(posX, posY, offset);
			}
			else if (rc) 
			{
				if(pTwo == null){
					pTwo = new Point("V2", posX, posY, offset, 5.0f, color(255,0,0,255), cordScale);
				}
				pTwo.setPosition(posX, posY, offset);
			}
		}
		Calculate();
	}


	public void Calculate(){
		if(pOne != null && pTwo != null){

			PVector vectOne = new PVector(pOne.getFakePosX(), pOne.getFakePosY());
			PVector vectTwo = new PVector(pTwo.getFakePosX(), pTwo.getFakePosY());

			//Direction
			direction.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			directionNormal.setColorOther(direction.getColorBase());
			directionNormal.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());

			sqrMagnitude.setColorOther(direction.getColorBase());
			sqrMagnitude.setCalculation(vectOne, vectTwo, pOne.getPosition(), pTwo.getPosition());



		}
	}

	public boolean Contains(float posX, float posY, float minX, float maxX, float minY, float maxY){
		if(posX < maxX && posX > minX){
			if(posY < maxY && posY > minY)
				return true;
		}
		return false;
	}

	/*
			PVector dir = PVector.sub(vectTwo, vectOne);
			directionV = PVector.add(pOne.GetPosition(), dir);
			direction.SetText(
				"Direction", 
				"   V1",
				"V2","",
				"  -   = direction\n" + 
				"dirX" + nf(dir.x,0,1) + " dirY" + nf(dir.y,0,1)
			);

			//Direction Normalized
			

			PVector dirN = dir.copy();
			dirN.normalize();
			directionNV = PVector.add(pOne.GetPosition(), PVector.mult(dirN, cordScale + arrowThickness * 2));//compansate for arrow shotening
			directionNormal.setColorOther(direction.getColorBase());

			directionNormal.SetText(
				"Direction normalized", "","",
				"dir  dir",
				"   /√   ² = normalized" +"\n" + "dirX" + nf(dirN.x,0,2) + "  dirY" + nf(dirN.y,0,2)
			);
			

			//sqrMagnitude
			PVector compDir = vectOne.copy();
			float compSqr = compDir.magSq();
			compDir.mult(-1);
			float vecSqr = dir.magSq();
			compDir.normalize();

			
			sqrMagnitude.setColorOther(direction.getColorBase());

			if(compSqr < vecSqr){
				sqrMagnitude.SetText(
					"Squared Magnitude","\nV1",
					"\n                           V2 ", 
					"Direction Direction",
					"         *          = Squared Magnitude" + "\n" + 
					"   is closer to Origo then     (" + nf(vecSqr,0,2) + ")"
				);
			}else{
				sqrMagnitude.SetText(
					"Squared Magnitude",
					"\nV1",
					"\n                V2",
					"Direction Direction",
					"         *          = SquaredMagnitude" + "\n" + 
					"   is closer to    then Origo  (" + nf(vecSqr,0,2) + ")"
				);
			}
			sqrMagnitudeVOne = PVector.add(pOne.GetPosition(), PVector.mult(dirN, vecSqr * cordScale));
			sqrMagnitudeVTwo = PVector.add(pOne.GetPosition(), PVector.mult(compDir, compSqr * cordScale));

			//Magnitude
			float dist = dir.mag();
			distance.setColorOther(sqrMagnitude.getColorBase());
			distance.SetText(
				"Distance","\n" + 
				"V1", "\n" +
				"               V2 = ",
				"  SquaredMagnitude",
				"√                   = Correct Distance" + "\n" + 
				"   distance to    = " +  nf(dist,0,2)
			);

			*/

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
