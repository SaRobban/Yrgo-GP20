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

public class Circle_ADV extends PApplet {

Ball ball;
BoxCollider2D cols[];


public void setup(){
  
  ball = new Ball(40, 320, 240);

  cols = new BoxCollider2D[1];
  cols[0] = new BoxCollider2D(200,200,80,40, 0.523599f);

}

public void draw(){
  background(0);
  ball.SetPosition(mouseX, mouseY);
  ball.SetColor(color (0,128,64,255));

  if(cols[0].CircleCheckIfCollision(ball)){
    ball.SetColor(color (255,128,64,255));
  }

  ball.Draw();
  cols[0].Draw(color(0, 0, 255, 255));
}
//Mess made by Robert Sandh - Yrgo GP20

class BoxCollider2D{
	int posX;
	int posY;

	float rectSizeX;
	float rectSizeY;

	PVector v[];
	PVector cornerDir[];

	boolean hit;
	PVector hitNormal;
	PVector hitPoint;


	PVector testDotVectorOne = new PVector(0,0);
	PVector testDotVectorTwo = new PVector(0,0);
	PVector testHitPoint = new PVector(0,0);
	PVector testHitNormal = new PVector(0,0);
	PVector testDirToBall = new PVector(0,0);

	BoxCollider2D(int px, int py, int sx, int sy, float angle){
		this.posX = px;
		this.posY = py;

		this.v = new PVector[4];
		this.v[0] = new PVector( sx,  sy);
		this.v[1] = new PVector( sx, -sy);
		this.v[2] = new PVector(-sx, -sy);
		this.v[3] = new PVector(-sx,  sy);

		this.rectSizeX = 0;
		this.rectSizeY = 0;
		this.cornerDir = new PVector[4];

		for(int i = 0; i < v.length; i++){
			
			this.v[i].rotate(angle);

			this.cornerDir[i] = new PVector(v[i].x, v[i].y);

			if(v[i].x > rectSizeX)
				this.rectSizeX = v[i].x;

			if(v[i].y > rectSizeY)
				this.rectSizeY = v[i].y;

			this.v[i].set(v[i].x + px, v[i].y + py);
		}

		this.hit = false;
		this.hitPoint = new PVector(0,0);
		this.hitNormal = new PVector(0,0);
	}


	public boolean CircleCheckIfCollision(Ball ball){
		hit = false;
		float radius = ball.GetRadius();
		PVector bPos = new PVector(ball.GetPosition().x, ball.GetPosition().y);

		//Check if inside rect
		if(bPos.x - radius < this.posX + this.rectSizeX && bPos.x + radius > this.posX - this.rectSizeX){
			if(bPos.y - radius < this.posY + this.rectSizeY && bPos.y + radius > this.posY - this.rectSizeY){
				//print("ball is inside rect");
				CircleCollider2D(ball);
			}
		}
		return hit;
	}

	public void CircleCollider2D(Ball ball){
		PVector ballPos = ball.GetPosition();
		PVector bPos = new PVector(ballPos.x, ballPos.y);
		PVector bDir = new PVector(bPos.x - posX, bPos.y - posY);

		PVector compDir = new PVector(bDir.x, bDir.y);

		//Get closest dir in relation to ball (replace with sqrmag to vert?!)
		int closest = 0;
		int secondClosest = 0;
		float compDot = -100000.0f;
		float dot = 0;

		//Get closest dir in relation to ball
		for(int i = 0; i < v.length; i++){
			dot = compDir.dot(cornerDir[i]);
			if(dot > compDot){
				closest = i;
				compDot = dot;
			} 
		}


		PVector otherDir = new PVector(bDir.x, bDir.y);
		compDir.set(-cornerDir[closest].y, cornerDir[closest].x);

testDirToBall.set(otherDir.x, otherDir.y);
		
		//See if left or right to closest corner
		PVector wallDir = new PVector(0,0);
		float wallLength = 0;
		dot = compDir.dot(otherDir);

		if(dot > 0){
			secondClosest = (closest - 1);// %(v.length - 1);
			if(secondClosest < 0)
				secondClosest += 4;

			wallDir.set(v[secondClosest].x - v[closest].x, v[secondClosest].y - v[closest].y);
			wallLength = wallDir.mag();

		}else{
			secondClosest = (closest + 1);
			if(secondClosest > 3)
				secondClosest -= 4;

			wallDir.set(v[closest].x - v[secondClosest].x, v[closest].y - v[secondClosest].y);
			wallLength = wallDir.mag();
		}
		wallLength *= 0.5f;


testDotVectorOne.set(cornerDir[closest].x, cornerDir[closest].y);
testDotVectorTwo.set(cornerDir[secondClosest].x, cornerDir[secondClosest].y);


		//Get closest point on wall
		PVector pOnLine = NearestPointOnLine(v[closest], wallDir, bPos);
		PVector midPoint = new PVector(v[closest].x + v[secondClosest].x, v[closest].y + v[secondClosest].y);
				midPoint.mult(0.5f);
		float distToMid = GetSqrDistBetweenToPoints(midPoint, pOnLine);
		float distPOLToBallC = GetSqrDistBetweenToPoints(bPos, pOnLine);

		//If dist to ball < ball radius we are on/in collider
		if(distPOLToBallC < ball.GetRadius() * ball.GetRadius()){
			hit = true;
			//print("ball hit a wall");
			//If inside wall length else get vertexpoint
			if(distToMid < wallLength * wallLength){
				hitNormal.set(wallDir.y, -wallDir.x);
				hitNormal.normalize();
				hitPoint.set(pOnLine.x, pOnLine.y);
			}else{
				//print("ball hit a corner");
				//Closet bewtween v[closest]
				hitNormal.set(bPos.x - v[closest].x, bPos.y - v[closest].y);
				hitNormal.normalize();
				hitPoint.set(v[closest].x, v[closest].y);
			}
		}
testHitPoint.set(hitPoint.x, hitPoint.y);
testHitNormal.set(hitNormal.x * 100, hitNormal.y *100);
	}

	public float GetSqrDistBetweenToPoints(PVector vOne, PVector vTwo){
		PVector v1 = new PVector(vOne.x , vOne.y);
		PVector v2 = new PVector(vTwo.x , vTwo.y);

		v1.sub(v2);
		return v1.magSq();
	}

	//Thx. "lordOfDuct" //Rewritten from unity tutorial
	public PVector NearestPointOnLine(PVector lineStart, PVector lineDir, PVector vPoint){
		PVector lS = new PVector(lineStart.x, lineStart.y);
		PVector lDir = new PVector(lineDir.x, lineDir.y);
		PVector pnt = new PVector(vPoint.x, vPoint.y);

	    lDir.normalize();
	    PVector v = pnt.sub(lS);
	    float d = v.dot(lDir);
	   // line(lS.x + lDir.x * d, lS.y + lDir.y * d, lS.x + lDir.x * d, lS.y+200 + lDir.y * d);

	    //point on line
	    lDir.mult(d);
	    lS.add(lDir);
	    return lS;
	}


	public void Draw(int col){
		strokeWeight(2);
		noStroke();
		fill(color(col));
		quad(v[0].x, v[0].y, v[1].x, v[1].y, v[2].x, v[2].y, v[3].x, v[3].y);
		
/*
		//Debug
		noFill();
		stroke(color(255,0,0,64));
		for(int i = 0; i < v.length; i++){
			line(posX, posY, posX + cornerDir[i].x * 20, posY + cornerDir[i].y * 20);
		}
		//draw rect
		stroke(color(255,128,0,128));
		
		rect(posX - rectSizeX, posY - rectSizeY, rectSizeX * 2, rectSizeY * 2);
		
		stroke(color(0,128,0,255));
		line(posX, posY, posX + testDotVectorOne.x, posY + testDotVectorOne.y);

		stroke(color(0,64,0,255));
		line(posX, posY, posX + testDotVectorTwo.x, posY + testDotVectorTwo.y);

		stroke(color(0,255,0,255));
		line(posX,posY,posX+ testDirToBall.x, posY + testDirToBall.y);
*/
		if(hit){
			stroke(color(255,0,0,255));
			line(testHitPoint.x, testHitPoint.y, testHitPoint.x + testHitNormal.x, testHitPoint.y + testHitNormal.y);
		}

	}
}
/*
class HitInfo{
	boolean hit;
	PVector hitPoint;
	PVector hitNormal;

	HitInfo(boolean hit, PVector hitPoint, PVector hitNormal){
		this.hit = hit;
		this.hitPoint = hitPoint;
		this.hitNormal = hitNormal;
	}

	void setHit(boolean h){
		this.hit = h; 
	}

	void setNormal(PVector n){
		this.hitNormal = n;
	}

	void setPoint(PVector p){
		this.hitPoint = p;
	}

}
*/
class Ball{
	float radius;
	PVector pos;
	PVector forceV;

	float deformY;
	float deformX;

	int ballColor = color(255, 255, 255);

	Ball(float r, float posX, float posY){
		this.radius = r;
		this.pos = new PVector(posX, posY);
		this.deformX = 0;
		this.deformY = 0;
		this.forceV = new PVector(0,0);
	}

	public void SetPosition(float x, float y){
		pos.set(x,y);
	}

	public void SetForce(float fX, float fY){
		forceV.set(fX, fY);
	}

	public void AddForces(float g, float drag){
		forceV.mult(1 - drag);
		forceV.set(forceV.x, forceV.y + g);
		pos.add(forceV);
	}

	public void SetColor(int col){
		this.ballColor = col;
	}

	public float GetRadius(){
		return radius;
	}

	public PVector GetPosition(){
		return pos;
	}

	public void Draw(){

		deformX *= 0.1f;
		deformY *= 0.1f;

		noStroke();
		fill(ballColor);

		ellipse(pos.x, pos.y, radius *2 + deformX, radius *2 + deformY);
	}
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Circle_ADV" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
