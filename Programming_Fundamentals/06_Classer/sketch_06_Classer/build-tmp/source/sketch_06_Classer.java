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

public class sketch_06_Classer extends PApplet {

	//Start by making a copy from the "Input and Movement" lesson assignment, so we get a character that we can move on the screen.
	//Create a player class and move as much code out from the main file as possible.

	//(Let time and delta time still be calculated in the main file)
	
	//Add the Ball class from this lesson.
	
//Add size and color to the ball class.
	
	//Make the ball class handle bounces at the edge of the screen.
	
	//Create 10 balls that can bounce around the screen.
	//Check if the player collides with a ball.
	//Make some kind of Game Over screen when the player gets hit.


//Using the input example from the lesson. Make it so a circle/character can move left-right-up-down.
//Create input that gives the circle/character acceleration when it moves.
//Make it deaccelerate down to a standstill when no key is pressed.
//Use deltaTime to control movement every update.

PlayerBall plBall;
float plAccTime = 1; //seconds till full speed or stop is rached
float plDeAccTime = 2; 
float plTurnSpeed = 4; 
float plMaxSpeed = 5;

long timeSinceStart;
float deltaTime;
float intervall;

BallManager emyBallManager;
int numberOfBalls = 1;

int score = 0;
int hiScore = 0;

int state = 1; //1game start 2game 3 gameoever

//thx. Jacob Lundberg och Robin Bono
enum GameState{
	Title, MainGame, GameOver
};

GameState gState = GameState.Title;

//enum 
public void setup(){
	
	frameRate(60);
	mainGameInit();
	gState = GameState.Title;
}


public void mainGameInit(){
	emyBallManager = new BallManager(numberOfBalls);
	plBall = new PlayerBall(10, color(255, 0, 0, 255), new PVector(320,240), new PVector(0,1), 20, 3);
}


public void draw(){
	deltaTime = ((millis() - timeSinceStart) * 0.001f);
	intervall += deltaTime;

	//check game state
	if(gState == GameState.Title){
			runStartScreen(timeSinceStart * 0.01f);
		if(space){
			changeGameState();
		}
	}else if(gState == GameState.MainGame){
		runMainGame();
		if(!plBall.playerIsAlive()){
			changeGameState();
		}
	}else{
		GameOver(score, timeSinceStart *0.001f);
		if(space){
			changeGameState();
		}
	}


	//print("state " + state, space);
	endTime();
}


public void endTime(){
	space = false;
	timeSinceStart = millis();
}


public void changeGameState(){
	switch (gState)
    {
    	case Title:
        	gState = GameState.MainGame;
        break;

        case MainGame :
	        mainGameInit();
	        gState = GameState.GameOver;
        break;	

        case GameOver :
        	gState = GameState.Title;
        break;

        default :
       		gState = GameState.Title;
    }
	
    print(" ", gState);
}


public void runStartScreen(float anim){

	background(64,96,128,255);

	//text
	textAlign(CENTER, CENTER);
	fill(255, 200, 153,255);
	textSize(96);
	text("Goldfish", width * 0.5f, height * 0.5f - 160);
	textSize(32); 
	text("in bubble hell", width * 0.5f + 90, height * 0.5f - 100); 
	float ani = sin(anim) + 1;

	ani = lerp(255, 128, ani * 0.5f);

	fill(255, ani, 153,255);
	textSize(48);
	text("Press space", width * 0.5f, height * 0.5f); 
}


public void runMainGame(){
	if(intervall > 3){
		emyBallManager.AddBall();
		emyBallManager.NumberOfBalls();
		intervall = 0;
	}

	background(64,96,128,255);
	
	plBall.ControllBall(inputAxis, plMaxSpeed, plDeAccTime, plDeAccTime, plTurnSpeed, deltaTime);
	plBall.Restrict(width, height);

	emyBallManager.MovePositions(deltaTime);
	emyBallManager.CheckSelfCollitionsAnd(plBall);
	emyBallManager.DrawBalls();

	plBall.DrawBall(timeSinceStart * 0.01f);
		
	score = emyBallManager.GetNumberOfBalls();
	HUD(plBall.GetHp(), emyBallManager.GetNumberOfBalls());
}


//font = loadFont("LetterGothicStd-32.vlw");
public void GameOver(int wave, float anim){
	fill(255, 0, 0,255);
	textSize(48);
	textAlign(CENTER, CENTER);
	text("GameOver", width * 0.5f, 150); 
	text("Score: " + wave, width *0.5f, 300); 

	float ani = sin(anim) + 1;
	ani = lerp(255, 128, ani * 0.5f);
	fill(255, ani, 153,255);
	textSize(48);
	text("Press space", width * 0.5f, height -100); 
}
class Ball{
	int radius;
	int col;
	PVector pos;
	PVector dir;
	float speed;

	Ball(int r, int c, PVector p, PVector d, float s){
		this.radius = r;
		this.col = c;
		this.pos = p;
		this.dir = d;
		this.speed = s;
	}
	
	public PVector GetPosition(){
		return pos.copy();
	}

	public int GetRadius(){
		return radius;
	}

	public void MovePos(float deltaT){
		PVector d = dir.copy();
		d.mult(speed * deltaT);
		pos.add(d);
	}

	public void Restrict(int maxRoomX, int maxRoomY){
		//Restrict room
		if(this.pos.x <= radius){
			if(this.dir.dot(1,0,0) <= 0)
				this.dir.x *= -1;
		}else if(this.pos.x >= maxRoomX - radius){
			if(this.dir.dot(-1,0,0) <= 0)
				this.dir.x *= -1;
		}

		if(this.pos.y <= radius){
			if(this.dir.dot(0,1,0) <= 0)
				this.dir.y *= -1;
		}else if(this.pos.y > maxRoomY - radius){
			if(this.dir.dot(0,-1,0) <= 0)
				this.dir.y *= -1;
		}

	}

	public void CheckCollision(PVector posOther, float rOther){
		

		float minDist = radius + rOther;
		minDist *= minDist;

		PVector dirBetween = posOther.sub(pos);
		//Optimized???????
		if(dirBetween.x > minDist && dirBetween.y > minDist){
			return;
		}

		float  distBetween = dirBetween.magSq();

		if(distBetween < minDist){
			this.col = color(255,255,0,255);
			this.dir = dirBetween.normalize();
			this.dir.mult(-1);
		}
	}

	public void DrawBall(){
		strokeWeight(3);
		stroke(128,192,255,255);
		//fill(col);
		fill(128,192,255,128);
		ellipse(pos.x, pos.y, radius*2, radius*2);
		fill(255,255,255,64);
		ellipse(pos.x + radius*0.5f, pos.y - radius * 0.5f, 5,3);
	}
}

public void HUD(int hp, int wave){
	textAlign(LEFT, UP);
	fill(255, 102, 153,255);
	textSize(32);
	text("HP: " + hp, 10, 60); 
	text("Wave: " + wave, 10, 30); 
}

class BallManager{
	Ball[] emyBalls;
	int baseColor = color(128,64,32,255);
	int baseRadius = 5;
	float baseSpeed = 100;

	float spawnRange;


	BallManager(int numberOfBalls, int r, int c, PVector p, PVector d, float s){
		this.emyBalls = new Ball[numberOfBalls];

		for(int b = 0; b < this.emyBalls.length; b++){
			this.emyBalls[b] = new Ball(r,c,p,d,s);
		}
	}

	BallManager(int numberOfBalls, int r, PVector p, float s){
		this.emyBalls = new Ball[numberOfBalls];

		for(int b = 0; b < this.emyBalls.length; b++){
			this.emyBalls[b] = new Ball(r, baseColor, p, new PVector(random(0, 1), random(0, 1)), s);
		}
	}

	BallManager(int numberOfBalls){
		spawnRange = width * 0.5f + 20;

		this.emyBalls = new Ball[numberOfBalls];

		for(int b = 0; b < this.emyBalls.length; b++){
			this.emyBalls[b] = CreateRadnomBall();
		}
 	}


 	public int GetNumberOfBalls(){
 		int l = emyBalls.length;
 		return l;
 	}

	public void CheckSelfCollitionsAnd(){
		for(int b = 0; b < emyBalls.length; b++){
			for(int bOther = 0; bOther < emyBalls.length; bOther++){
				if(bOther != b){
					this.emyBalls[b].CheckCollision(this.emyBalls[bOther].GetPosition(), this.emyBalls[bOther].GetRadius());
				}
			}
			this.emyBalls[b].Restrict(width, height);
		}
	}

	public void CheckSelfCollitionsAnd(PlayerBall playerBall){
		for(int b = 0; b < emyBalls.length; b++){
			for(int bOther = 0; bOther < emyBalls.length; bOther++){
				if(bOther != b){
					this.emyBalls[b].CheckCollision(this.emyBalls[bOther].GetPosition(), this.emyBalls[bOther].GetRadius());
				}
			}
			this.emyBalls[b].CheckCollision(playerBall.GetPosition(), playerBall.GetRadius());
			playerBall.CheckCollision(this.emyBalls[b].GetPosition(), this.emyBalls[b].GetRadius());

			this.emyBalls[b].Restrict(width, height);
		}
	}

	public void MovePositions(float deltaT){
		for(int b = 0; b < emyBalls.length; b++){
			this.emyBalls[b].MovePos(deltaT);
		}
	}

	public void DrawBalls(){
		for(int i = 0; i < this.emyBalls.length; i++){
			this.emyBalls[i].DrawBall();
		}
	}


	public void AddBall(){
		emyBalls = (Ball[]) expand(emyBalls, emyBalls.length + 1);
		emyBalls[emyBalls.length - 1] = CreateRadnomBall();
		//emyBalls = temp;

		//this.emyBalls[b] = new Ball(baseRadius, baseColor, new PVector(100 + 10 * b, 100 + 10 * b), new PVector(random(0, 1), random(0, 1)), baseSpeed);
	}

	public Ball CreateRadnomBall(){
		PVector randomSpawnPoint = new PVector(random(0, 1), random(0, 1));
		randomSpawnPoint = randomSpawnPoint.normalize();
		PVector randomDir = randomSpawnPoint.copy();

		randomSpawnPoint.mult(-spawnRange);
		randomSpawnPoint.add(random(-10, 10),random(-10, 10));

		return new Ball((int)random(5, 20), baseColor, randomSpawnPoint, randomDir, baseSpeed);
	}

	public void NumberOfBalls(){
		print(emyBalls.length);
	}
}
PVector inputAxis = new PVector(0,0);
//keys

int left;
int right;
int up; 
int down;

boolean space = false;

public void keyPressed(){
	if(keyCode == LEFT || key == 'a'){
		left = 1;
	}

	if(keyCode == RIGHT || key == 'd'){
		right = 1;
	}

	if(keyCode == UP || key == 'w'){
		up = 1;
	}

	if(keyCode == DOWN || key == 's'){
		down = 1;
	}

	inputAxis.set(right - left, down - up);
	inputAxis.normalize();

	if(key == ' '){
		space = true;
		//print("space is true " , space);
	}

}


public void keyReleased(){
	if(keyCode == LEFT || key == 'a'){
		left = 0;
	}

	if(keyCode == RIGHT || key == 'd'){
		right = 0;
	}

	if(keyCode == UP || key == 'w'){
		up = 0;
	}

	if(keyCode == DOWN || key == 's'){
		down = 0;
	}

	inputAxis.set(right - left, down - up);
	inputAxis.normalize();

	if(key == ' '){
		space = false;
		//print("space is false " , space);
	}
}
class PlayerBall{
	int radius;
	int col;
	PVector pos;
	PVector dir;
	float speed;
	float scaleSpeed;

	int hp;

	PVector graphicDir;
	float anim;


	PlayerBall(int r, int c, PVector p, PVector d, float s, int hp){
		this.radius = r;
		this.col = c;
		this.pos = p;
		this.dir = d.normalize();
		this.speed = s;
		this.hp = hp;
		this.graphicDir = d.copy();
	}
	
	public PVector GetPosition(){
		return pos.copy();
	}

	public int GetRadius(){
		return radius;
	}

	public int GetHp(){
		return hp;
	}

	public boolean playerIsAlive(){
		if(hp > 0){
			return true;
		}else{
			return false;
		}
	}


	public void Restrict(int maxRoomX, int maxRoomY){
		//Restrict room
		if(this.pos.x <= this.radius){
			this.dir.x *= -1;
		}else if(this.pos.x >= maxRoomX - this.radius){
			this.dir.x *=-1;
		}

		if(this.pos.y <= this.radius){
			this.dir.y *= -1;
		}else if(this.pos.y > maxRoomY - this.radius){
			this.dir.y *= -1;
		}
	}

	public void CheckCollision(PVector posOther, float rOther){
		float minDist = radius + rOther;
		minDist *= minDist;

		PVector dirBetween = posOther.sub(pos);

		//Optimized???????
		if(dirBetween.x > minDist && dirBetween.y > minDist){
			return;
		}

		float  distBetween = dirBetween.magSq();

		if(distBetween < minDist){
			this.col = color(255,255,0,255);
			this.dir = dirBetween.normalize();
			this.dir.mult(-1);
			this.scaleSpeed = 1;//ImpactSpeed
			this.hp--;
		}
	}

	public void ControllBall(PVector inputAxis, float maxSpeed, float accTime, float deAccTime, float turnSpeed, float deltaTime){
		if(inputAxis.magSq() != 0){
			
			if(scaleSpeed <= 1){
				scaleSpeed += deltaTime * accTime;
				//scaleSpeed = 1;
			}

			dir.set(lerp(dir.x, inputAxis.x, turnSpeed * deltaTime), lerp(dir.y, inputAxis.y, turnSpeed * deltaTime));
			graphicDir = dir.copy();
			graphicDir = graphicDir.normalize();

			
		}else{
			scaleSpeed -= deltaTime * deAccTime;
			if(scaleSpeed < 0){
				scaleSpeed = 0;
			}
		}


		PVector d = dir.copy();
		d.mult(scaleSpeed * maxSpeed);
		this.pos.add(d);

		anim += scaleSpeed * 0.5f;
	}

	public void DrawBall(float t){
		noStroke();
		fill(col);

		PVector[] gfx = new PVector[4];
		for(int i = 0; i < 4; i++){
			gfx[i] = graphicDir.copy();
			gfx[i].rotate(0.5f*PI * i);
			
		}
		ellipse(pos.x, pos.y, radius*2, radius*2);
		
		float floppyValue = 2 * (sin(anim) + 5 + scaleSpeed);
		//fin
		quad(pos.x - gfx[0].x * radius, pos.y - gfx[0].y * radius,
			
			pos.x - gfx[1].x * (radius + 8) - gfx[0].x *5,
			pos.y - gfx[1].y * (radius + 8) - gfx[0].y *5,

			pos.x - gfx[2].x * radius, pos.y - gfx[2].y * radius,
			
			pos.x - gfx[3].x * (radius + 5) - gfx[0].x *floppyValue,
			pos.y - gfx[3].y * (radius + 5) - gfx[0].y *floppyValue);

		for(int u = 0; u<4;u++){
			gfx[u].add(graphicDir);
		}
		//back fin
		floppyValue = 2 * (sin(anim +1) + 2 + scaleSpeed);		

		quad(pos.x - gfx[0].x * radius, pos.y - gfx[0].y * radius,
			
			pos.x - gfx[1].x * radius - gfx[0].x *floppyValue,
			pos.y - gfx[1].y * radius - gfx[0].y *floppyValue,

			pos.x - gfx[2].x * radius, pos.y - gfx[2].y * radius,
			
			pos.x - gfx[3].x * radius - gfx[0].x *floppyValue,
			pos.y - gfx[3].y * radius - gfx[0].y *floppyValue);

		fill(255,255,255,128);
		ellipse(pos.x + 2, pos.y - 5, 10, 5);

		fill(255,255,255,255);
		ellipse(pos.x + dir.x * 10, pos.y + dir.y * 10, 10, 10);
	
		fill(0);
		ellipse(pos.x + dir.x * 12, pos.y + dir.y * 12, 5, 5);
	}
}
  public void settings() { 	size(640,480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_06_Classer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
