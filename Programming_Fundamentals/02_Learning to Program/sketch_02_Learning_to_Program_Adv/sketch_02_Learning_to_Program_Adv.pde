//Modyfied copypaste from assingment
//THX. Simon J, for convert to float

//Create our timing variable
int frame = 0;
int animHardStepInter = 45;
int animHardStep = 0;
float animSoftStep = 0;
boolean animateGrid = true;

//Background
color bgC = color(128,128,128,255);
color bgTwoC = color(255,255,255,64);
int offsetFromCorner = 20;

//Lines
int colorIntervall = 3;
color lineC = color(255,255,255,128);
color oddLineC = color(128,128,128,255);
color oddLineTwoC = color(0,0,0,255);

//Grid
PVector gridCenter;
PVector[] gridV;
float radius = 200;
int gridStep = 180;
int drawLineEvery = 3;

int lineStep = 94;

void setup()
{
	size(640, 480);
	CreateGrid(0);
}

void CreateGrid(float anim){
	//Create points in a circle;
	gridV = new PVector[gridStep];

	float mulCircle = 2 * PI;
	float mulI = 1.00000000 / gridStep;

	for(int i = 0; i < gridStep; i++){
		gridV[i] = PVector.fromAngle(mulCircle * mulI * (i + anim));
		gridV[i].x *= (float)width;
		gridV[i].y *= (float)width;
	}

	gridCenter = new PVector((float)width *0.5, (float)height * 0.5);
}

void draw()
{
	//Tweeks
	drawLineEvery = 2;
	lineStep = 94;
	animHardStepInter = 45;

	if(animateGrid)
		CreateGrid(animSoftStep);

	//Draw backdrop
	DrawBackGround();

	//Draw our scan lines.
	strokeWeight(2);
	
	for(int i = 0; i < gridV.length; i += drawLineEvery){
		//oddline is diffrent color
		stroke(lineC);
		if((i + animHardStep) % 3 == 0)
			stroke(oddLineC);

		if((i) % 3 == 0)
			stroke(oddLineTwoC);

		//Lets Make lines between i and u (cheesy pick up line)
		int u = (i + lineStep) % gridV.length;
		line(gridCenter.x + gridV[i].x, gridCenter.y + gridV[i].y, gridCenter.x + gridV[u].x, gridCenter.y + gridV[u].y);
	}
	
	//Increment our frame count
	frame++;
  
  if(frame % animHardStepInter == 0){
    animHardStep++;
  }
  animSoftStep += 0.1;
}

void DrawBackGround(){
	//Clear background
	background(bgC);
	noStroke();
	fill(bgTwoC);

	//Draw our art, or in this case a rectangle
	rect(offsetFromCorner, offsetFromCorner, width - offsetFromCorner *2, height - offsetFromCorner *2);
}
