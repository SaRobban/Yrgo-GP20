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

public class ParabolicCurves_Extra extends PApplet {

//Modyfied copypaste from assingment
//THX. Simon J, for how to convert int to float

//grid
PVector gridCenter;

int numberOfAxis = 6;
int numberOfLines = 24;
float axisStep = 10.0f;

PVector[] axisVectors;
PVector[] nodes;

//Create our timing variable
int frame = 0;
int animHardStep = 0;
int animHardStepIntervall = 10;

boolean animateArms = true;

//Lines
int colorIntervall = 3;
int lineColOne = color(128,64,255,32);
int lineColTwo = color(128,128,255,200);
int lineColTre = color(255,128,255,255);

//Background
int bgColOne = color(128,128,128,255);
int bgColOneolTwo = color(255,255,255,32);
int offsetFromCorner = 40;


public void setup()
{
	
	gridCenter = new PVector((float)width * 0.5f, (float)height * 0.5f);
	gridCenter.x -= 200; //Compensate or sloppy animation
	CreateGrid(numberOfAxis, numberOfLines, frame);
}

public void CreateGrid(int nOA, int nOL, float anim){
	
	//failsafe if numberOfarms or number of lines is less then minimum use minimum
	if(nOL < 1){
		nOL = 1;
	}
	if(nOA < 2){
		nOA = 2;
	}

	//Create points in a circle;
	float mulCircle = 2 * PI; //Full circle in radians
	float mulI = 1.00000000f / (float)nOA;

	//failsafe if numberOfarms is minimum use other angle, no flatline
	if (nOA == 2) {
		mulCircle = 2 * PI; //Full circle in radians
		mulI = 1.00000000f / 3.0f;
	}

	axisVectors = new PVector[nOA];
	nodes = new PVector[nOA * nOL];
	
	int axisTravel = 0; 
	int axisLine = 0;
	boolean  swapDir = true;

	//animation
	float axStepOne = axisStep * sin(anim);
	float axStepTwo = axisStep * sin(anim);
	if(animateArms){
		axStepOne = axisStep * (1.5f + sin(anim)) * 0.5f;
		axStepTwo = axisStep * (2.5f + cos(anim)) * 0.25f;
	}

	for(int x = 0; x < nodes.length; x++){
		if((x % nOL) == 0){
			axisTravel = 0;
			axisLine++;
			swapDir = !swapDir;
		}

		nodes[x] = PVector.fromAngle(mulCircle * mulI * axisLine + anim);
		if(swapDir){
			nodes[x].x *= axisTravel * axStepOne;
			nodes[x].y *= axisTravel * axStepOne;

		}else{
			nodes[x].x *= (axStepTwo * nOL) - (axisTravel * axStepTwo);
			nodes[x].y *= (axStepTwo * nOL) - (axisTravel * axStepTwo);
		}
		axisTravel++;
	}

	print("axisTravel = ", axisTravel, "   AxisLine = ", axisLine, "  nodes = ", nodes.length);

	for(int i = 0; i < nOA; i++){
		//PVector p = new PVector(0,1);
		axisVectors[i] = PVector.fromAngle(mulCircle * mulI * i);
	}
}

public void draw()
{
	//Tweeks
	numberOfAxis = 6;//prefer even
	numberOfLines = 48;
	axisStep = 8;

	animHardStepIntervall = 4;


	gridCenter.x += sin(frame * 0.005f);
	gridCenter.y += cos(frame * 0.01f);

	CreateGrid(numberOfAxis, numberOfLines, frame * 0.01f);


	//Draw backdrop
	DrawBackGround(animHardStep);

	//Draw our scan lines.
	strokeWeight(1.5f);
	stroke(lineColOne);
	
	//Draw axis'es
	//for(int i = 0; i < axisVectors.length; i ++){
		 //line(gridCenter.x, gridCenter.y, gridCenter.x + axisVectors[i].x * 200, gridCenter.y + axisVectors[i].y * 200);
	//}

	//Draw rest
	 for(int u = 0; u < nodes.length; u++){
	 	stroke(lineColOne);
strokeWeight(1.5f);
	 	if((u + animHardStep) % 12 == 0){
	 		stroke(lineColTre);
strokeWeight(3.5f);
	 	}
	 	if((u - 1 + animHardStep) % 12 == 0){
	 		stroke(lineColTwo);
strokeWeight(2.5f);
	 	}
	 	if((u + 1 + animHardStep) % 12 == 0){
	 		stroke(lineColTwo);
strokeWeight(2.5f);
	 	}
	 	int z = (u + numberOfLines) % nodes.length;
	 	line(gridCenter.x + nodes[u].x, gridCenter.y + nodes[u].y, gridCenter.x + nodes[z].x, gridCenter.y + nodes[z].y);
	 }
	 
	 frame++;
	 if(frame % animHardStepIntervall == 0)
	 	animHardStep++;
}

public void DrawBackGround(int anim){
	//Clear background
	background(bgColOne);
	noStroke();
	fill(bgColOneolTwo);


	int yL = 10;
	int xL = 20;

	float w = width;
	float h = height;
	float xI = w / xL;
	float yI = h / yL;


	int p = 0 + anim;
	int q = (int)w + (int)h - anim;


	boolean  swap = false;
	int dir = 0;
	for(int y = 0; y < yL; y++){
		if(swap){
			for(int x = 0; x < xL; x++){
				p++;
				DrawBGPixels(p, x* xI, y * yI , xI, yI);
			}
		}else{
			for(int x = xL; x > 0; x--){
				p++;
				DrawBGPixels(p, (float)x * xI -xI, (float)y * yI, xI, yI);
			}
		}
		swap = !swap;
	}

//rect(offsetFromCorner, offsetFromCorner, width - offsetFromCorner *2, height - offsetFromCorner *2);
}

public void DrawBGPixels(int p, float x,float y, float xsize, float ysize){
	if(p % 38 == 0){
					fill(bgColOne);
				}else{
					fill(bgColOneolTwo);
				}
				rect(x, y, xsize, ysize);
}
  public void settings() { 	size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ParabolicCurves_Extra" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
