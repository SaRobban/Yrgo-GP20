//Modyfied copypaste from assingment
//THX. Simon J, for convert to float

//Create our timing variable
int frame = 0;
int animHardStep = 0;
float animSoftStep = 0;

int offsetFromCorner = 20;
//Background
color bgC = color(128,128,128,255);
color bgTwoC = color(255,255,255,64);

//Lines
int spaceBetweenLines = 10;
int colorIntervall = 3;
color lineC = color(255,255,255,128);
color oddLineC = color(0,0,0,255);

//Grid
PVector gridCenter;
PVector[] gridV;
float radius = 200;
int gridStep = 36;
int lineStep = 5;

void setup()
{
	size(640, 480);

	//Create points in a circle;
	gridV = new PVector[gridStep];

	float mulCircle = 2 * PI;
	float mulI = 1.00000000 / gridStep;

	for(int i = 0; i < gridStep; i++){
		gridV[i] = PVector.fromAngle(mulCircle * mulI * i);
		gridV[i].x *= (float)width * 0.5;
		gridV[i].y *= (float)width * 0.5;
	}

	gridCenter = new PVector((float)width *0.5, (float)height * 0.5);

}

void draw()
{
	
	//float xAspect = (float)width / (float)height;
	lineStep = 20 + animHardStep;
	DrawBackGround();

	//Draw our scan lines.
	strokeWeight(2);
	
	for(int i = 0; i < gridV.length; i++){
		//oddline is diffrent color
		stroke(lineC);
		if((i + animHardStep) % 3 == 0)
			stroke(oddLineC);

		//Lets Make lines between i and u (cheesy pick up line)
		int u = (i + lineStep) % gridV.length;
		line(gridCenter.x + gridV[i].x, gridCenter.y + gridV[i].y, gridCenter.x + gridV[u].x, gridCenter.y + gridV[u].y);
	}
	
	//Increment our frame count
	frame++;
  
  if(frame % 10 == 0){
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
	rect(40, 40, width -80, height -80);
}
