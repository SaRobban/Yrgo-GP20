//Modyfied copypaste from assingment
//THX. Simon J, for convert to float

//grid
int numberOfAxis = 6;
int numberOfLines = 24;
float axisStep = 10.0;
PVector[] axisV;
PVector[] nodes;

//Create our timing variable
int frame = 0;
int animHard = 0;
int animHintervall = 10;

boolean animateArms = true;

//Background
PVector gridCenter;
color bgC = color(128,128,128,255);
color bgTwoC = color(255,255,255,32);
int offsetFromCorner = 40;

//Lines
int colorIntervall = 3;
color lineC = color(128,64,255,32);
color oddLineC = color(128,128,255,200);
color oddLineTwoC = color(255,128,255,255);


void setup()
{
	size(640, 480);
	gridCenter = new PVector((float)width *0.5, (float)height * 0.5);

	CreateGrid(numberOfAxis, numberOfLines, frame);
}

void CreateGrid(int nOA, int nOL, float anim){
	if(nOL < 1){
		nOL = 1;
	}
	if(nOA < 2){
		nOA = 2;
	}


	axisV = new PVector[nOA];
	nodes = new PVector[nOA * nOL];

	//Create points in a circle;
	float mulCircle = 2 * PI; //Full circle in radians
	float mulI = 1.00000000 / (float)nOA;

	if (nOA == 2) {
		mulCircle = 2 * PI; //Full circle in radians
		mulI = 1.00000000 / 3.0;
	}


	int axisTravel = 0; 
	int axisLine = 0;
	boolean  swapDir = true;


	//animation
	float axStepOne = axisStep * sin(anim);
	float axStepTwo = axisStep * sin(anim);
	if(animateArms){
		axStepOne = axisStep * (1.5 + sin(anim)) * 0.5;
		axStepTwo = axisStep * (2.5 + cos(anim)) * 0.25;
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
		axisV[i] = PVector.fromAngle(mulCircle * mulI * i);
	}
}

void draw()
{
	//Tweeks
	numberOfAxis = 6;//prefer even
	numberOfLines = 48;
	axisStep = 8;

animHintervall = 4;

	CreateGrid(numberOfAxis, numberOfLines, frame * 0.01);


	//Draw backdrop
	DrawBackGround(animHard);

	//Draw our scan lines.
	strokeWeight(1.5);
	stroke(lineC);
	
	//Draw axis'es
	for(int i = 0; i < axisV.length; i ++){
		 //line(gridCenter.x, gridCenter.y, gridCenter.x + axisV[i].x * 200, gridCenter.y + axisV[i].y * 200);
	}

	//Draw rest
	 for(int u = 0; u < nodes.length; u++){
	 	stroke(lineC);
strokeWeight(1.5);
	 	if((u + animHard) % 12 == 0){
	 		stroke(oddLineTwoC);
strokeWeight(3.5);
	 	}
	 	if((u - 1 + animHard) % 12 == 0){
	 		stroke(oddLineC);
strokeWeight(2.5);
	 	}
	 	if((u + 1 + animHard) % 12 == 0){
	 		stroke(oddLineC);
strokeWeight(2.5);
	 	}
	 	int z = (u + numberOfLines) % nodes.length;
	 	line(gridCenter.x + nodes[u].x, gridCenter.y + nodes[u].y, gridCenter.x + nodes[z].x, gridCenter.y + nodes[z].y);
	 }
	 
	 frame++;
	 if(frame % animHintervall == 0)
	 	animHard++;
}

void DrawBackGround(int anim){
	//Clear background
	background(bgC);
	noStroke();
	fill(bgTwoC);


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

void DrawBGPixels(int p, float x,float y, float xsize, float ysize){
	if(p % 38 == 0){
					fill(bgC);
				}else{
					fill(bgTwoC);
				}
				rect(x, y, xsize, ysize);
}
