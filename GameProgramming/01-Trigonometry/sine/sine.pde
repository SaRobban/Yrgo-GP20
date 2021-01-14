float sinCurvestep = 7f;
float sinCurveFreq = 0.2;
float sinCurveClimb = 20.0f;

int spiralEvery = 10;

float spiralStep = 0.1f;
float spiralExpand = 0.5f;
float spiralRadius = 100;
float spiralBias = 2.5;

float animSpeed = 1.0f;
int animConstant = 0;


int numberOfPoints = 100;


color bgColor = color(16, 0, 64, 16);
color lineColor = color(255, 0,32, 128);
color lineColorTwo = color(255, 0,255, 128);

void setup(){
	size(600, 400);
	background(bgColor);
	fill(lineColor);
	rect(0, 0, width, height);

	strokeWeight(6);
	stroke(255);
  	spiralExpand = spiralRadius / numberOfPoints;
}

void draw(){
	fill(bgColor);
	rect(-10, -10, width+10, height+10);
	//background(bgColor);

  	animSpeed +=0.01f;
  	animConstant +=1;
  	if(animConstant > spiralEvery){
  		animConstant = 0;
  	}

  	stroke(lineColor);
  	strokeWeight(3);
  	SineLine(new PVector(0,100), animSpeed);
  	SineLine(new PVector(0,300), animSpeed + PI *0.5);

  	stroke(lineColorTwo);
  	SineLines(new PVector(0,200), -animSpeed + PI *0.25f, 0);
  	SineLines(new PVector(0,200), -animSpeed + PI *0.25f, PI *0.75);
}

void SineLines(PVector pos, float animValue, float off){
	PVector pOne = new PVector();
	PVector pTwo = new PVector();

	PVector moveStep= new PVector(0.1,0);
	PVector exStep= new PVector(0,1.1);

	int offsett = 10;

	float longSine = PI/width;
	float bStep = 4;

	float rC = 255;
	float gC = 0;
	float bC = 255;
	float alphaC = 255;
	color c = color(rC,gC,bC,alphaC);

	for(int a = 0; a < width; a += offsett){
		alphaC = 255;
		bC = 128;
		float waveStr = sin(longSine * a * bStep);
		pOne.set(a * bStep, 0);

		pOne.y += sin(off + a * 0.025 + animValue) * 40 * waveStr;

		for(int b = 0; b < 32; b+= 6){
			alphaC -= b*4;
			bC -= b *2;
			c = color(rC, gC, bC, alphaC);
			stroke(c);
			pTwo.set(pOne.x + b * waveStr, pOne.y * 1.2);
			line(pOne.x + pos.x, pOne.y + pos.y, pTwo.x + pos.x, pTwo.y + pos.y);
			pOne.set(pTwo.x, pTwo.y);

			
		}
	}
}

void SineLine(PVector pos, float animValue){
	int a = 0;

	PVector pOne = new PVector();
	PVector pTwo = new PVector();

	int flip = 1;

	for(int b = 1; b < numberOfPoints; b++){
		pOne.set(a*sinCurvestep, sin(a * sinCurveFreq - animValue) * sinCurveClimb);
		pTwo.set(b*sinCurvestep, sin(b * sinCurveFreq - animValue) * sinCurveClimb);

		pOne.add(pos);
		pTwo.add(pos);

		line(pOne.x, pOne.y, pTwo.x, pTwo.y);

		//Spiral down
		if(a % spiralEvery == 1){
			
			PVector normal = new PVector(pOne.x - pTwo.x, pOne.y -pTwo.y); 
			normal.set(normal.y, normal.x * -1);
			normal.normalize();

			if(flip > 0){
				normal.x *=-1;
				normal.y *=-1;
			}	
			SpiralFromAnchor(1 - cos(sin(animValue)), pOne.x, pOne.y, normal.x, normal.y, flip);
			flip *=-1;
		}

		a=b;
	}
}
/*
void Spiral(){
	int a = 0;

	float shrinkS;
	PVector pOne = new PVector();
	PVector pTwo = new PVector();


	for(int b = 1; b < numberOfPoints; b++){
		shrinkS = spiralExpand * a - spiralRadius;
		pOne.x = sin(spiralStep * a + animSpeed) * shrinkS;
		pOne.y = cos(spiralStep * a + animSpeed) * shrinkS;

		shrinkS = spiralExpand * b - spiralRadius;
		pTwo.x = sin(spiralStep * b + animSpeed) * shrinkS;
		pTwo.y = cos(spiralStep * b + animSpeed) * shrinkS;

		line(pOne.x, pOne.y, pTwo.x, pTwo.y);

		a=b;
	}
}
*/
void SpiralFromAnchor(float curveing, float offX, float offY, float normalX, float normalY, int flip){
	int a = 0;

	float shrinkS;
	PVector pOne = new PVector(0, 0);
	PVector pTwo = new PVector(normalX * spiralExpand, normalY * spiralExpand);

	PVector nMod = new PVector(0, 1);
	PVector n = new PVector(normalX, normalY);

	float angle = new PVector().angleBetween(nMod, n);
	if(n.x > 0){
		angle *=-1;
  	}

	pushMatrix();
	translate(offX + n.x * spiralRadius * curveing, offY + n.y * spiralRadius * curveing); 
  	rotate(angle);

	for(int b = 1; b < numberOfPoints; b++){
		shrinkS = spiralExpand * a - spiralRadius;
		pOne.x = sin(spiralStep * a * spiralBias * flip * curveing) * shrinkS * curveing;
		pOne.y = cos(spiralStep * a * spiralBias * flip * curveing) * shrinkS * curveing;

		shrinkS = spiralExpand * b - spiralRadius;
		pTwo.x = sin(spiralStep * b * spiralBias * flip * curveing) * shrinkS * curveing;
		pTwo.y = cos(spiralStep * b * spiralBias * flip * curveing) * shrinkS * curveing;

		line(pOne.x, pOne.y, pTwo.x, pTwo.y);
		a=b;
	}
	popMatrix();
}
