float step = 0.1f;
float climb = 20.0f;

float spiralStep = 0.1f;
float spiralExpand = 0.5f;
float animSpeed = 1.0f;



int numberOfPoints = 100;


color bgColor = color(48, 64, 32, 16);
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
}

void draw(){
	fill(bgColor);
	rect(0, 0, width, height);

  	animSpeed +=0.01f;


  	stroke(lineColorFor);
  	strokeWeight(4);
  	SineLine();

  	stroke(lineColorTre);
  	strokeWeight(3);
  	SineLine();

  	stroke(lineColorTwo);
  	strokeWeight(2);
  	SineLine();

  	stroke(lineColor);
  	strokeWeight(1);
  	SineLine();


  	pushMatrix();
  	translate(width * 0.5f, height * 0.5f);

  	Spiral();
  	popMatrix();

  
}

void SineLine(){
	int a = 0;

	for(int b = 1; b < numberOfPoints; b++){
		line(a * step, 240 + sin(a * step + animSpeed) * climb,
		b * step, 240 + sin(b * step + animSpeed) * climb);
		a=b;
	}
}

void Spiral(){
	int a = 0;

	for(int b = 1; b < numberOfPoints; b++){

		PVector pOne = new PVector(sin(spiralStep * a + animSpeed) * spiralExpand * a, cos(spiralStep * a + animSpeed) * spiralExpand * a);
		PVector pTwo = new PVector(sin(spiralStep * b + animSpeed) * spiralExpand * b, cos(spiralStep * b + animSpeed) * spiralExpand * b);

		line(pOne.x, pOne.y, pTwo.x, pTwo.y);
		a=b;
	}
}

