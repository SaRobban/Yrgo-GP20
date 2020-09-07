//Modyfied copypaste from assingment
//THX. Simon J, for convert to float

//Settings
PVector axisOne;
PVector axisTwo;
float  axisLength = 200.0;
int numberOfLines = 10;


//Create our timing variable
int frame = 0;

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

void setup()
{
	size(640, 480);
	radius = 200;// (float)width;
	gridCenter = new PVector((float)width *0.5, (float)height * 0.5);

	CreateGrid(0);
}

void CreateGrid(float anim){
	//Create points in a circle;
	float  step = 100 / ;
	gridV = new PVector[gridStep];

	float mulCircle = 2 * PI;
	float mulI = 1.00000000 / gridStep;

	for(int i = 0; i < gridStep; i++){
		gridV[i] = PVector.fromAngle(mulCircle * mulI * (i + anim));
		gridV[i].x *= radius;
		gridV[i].y *= radius;
	}
}

void draw()
{
	if(animateGrid)
		CreateGrid(animSoftStep);

	//Draw backdrop
	DrawBackGround();

	//Draw our scan lines.
	strokeWeight(2);
	
	for(int i = 0; i < gridV.length; i += drawLineEvery){
		//oddline is diffrent color
		stroke(lineC);
		if((i) % 3 == 0)
			stroke(oddLineC);

		if((i+1) % 3 == 0)
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
  animSoftStep += 0.01;
}

void DrawBackGround(){
	//Clear background
	background(bgC);
	noStroke();
	fill(bgTwoC);

	//Draw our art, or in this case a rectangle
	rect(offsetFromCorner, offsetFromCorner, width - offsetFromCorner *2, height - offsetFromCorner *2);
}
