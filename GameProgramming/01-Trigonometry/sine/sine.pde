float step = 0.1f;
float climb = 20.0f;

float spiralStep = 0.1f;
float spiralExpand = 0.5f;
float spiralRadius = 200;

float animSpeed = 1.0f;



int numberOfPoints = 100;


color bgColor = color(48, 64, 32, 4);
color lineColor = color(0, 255,0, 128);
color lineColorTwo = color(0, 255,0, 64);
color lineColorTre = color(0, 255,0, 32);
color lineColorFor = color(0, 255,0, 16);


void setup(){
	size(640, 480);
	background(bgColor);

	strokeWeight(1);
	stroke(255);
  step = width / (numberOfPoints-1);

  spiralExpand = spiralRadius / numberOfPoints;
}

void draw(){
	fill(bgColor);
	rect(0, 0, width, height);
	background(bgColor);

  	animSpeed +=0.01f;


  	stroke(lineColorFor);
  	strokeWeight(16);
  	SineLine();

  	stroke(lineColorTre);
  	strokeWeight(8);
  	SineLine();

  	stroke(lineColorTwo);
  	strokeWeight(4);
  	SineLine();

  	stroke(lineColor);
  	strokeWeight(1);
  	SineLine();


  	//pushMatrix();
  	//translate(width * 0.5f, height * 0.5f);
  	//Spiral();

  	//popMatrix();

  
}

void SineLine(){
	int a = 0;

//	while b< whidth
	for(int b = 1; b < numberOfPoints; b++){
		line(a * step, 240 + sin(a * step + animSpeed) * climb,
			 b * step, 240 + sin(b * step + animSpeed) * climb);

		if(a == 50){
			float angleOne = (sin(a * step + animSpeed));
			float angleTwo = (cos(a * step + animSpeed));
			PVector normal = new PVector(a * step - b *step, 
										 sin(a * step + animSpeed) * climb - sin(b * step + animSpeed) * climb);
			normal.set(normal.y, normal.x * -1);

			SpiralFromAnchor(1, a * step, 240 + sin(a * step + animSpeed) * climb, normal.x, normal.y);
		}

		a=b;
	}
}

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

void SpiralFromAnchor(float curveing, float offX, float offY, float normalX, float normalY){
	int a = 0;

	float shrinkS;
	PVector pOne = new PVector();
	PVector pTwo = new PVector();

	for(int b = 1; b < numberOfPoints; b++){
	

		shrinkS = spiralRadius - spiralExpand * a;
		pOne.x = sin(spiralStep * a + normalX + animSpeed) * spiralExpand * a;
		pOne.y = cos(spiralStep * a + normalY + animSpeed) * spiralExpand * a;

		shrinkS = spiralRadius - spiralExpand * b;
		pTwo.x = sin(spiralStep * b + normalX + animSpeed) * spiralExpand * b;
		pTwo.y = cos(spiralStep * b + normalY + animSpeed) * spiralExpand * b;


		pOne.add(offX + normalX, offY + normalY);

		pTwo.add(offX + normalX, offY + normalY);

		line(pOne.x, pOne.y, pTwo.x, pTwo.y);
		a=b;
	}
}


