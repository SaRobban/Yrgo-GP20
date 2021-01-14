float step = 0.1f;
float climb = 20.0f;
float animSpeed = 1.0f;

int numberOfPoints = 100;


color bgColor = color(48, 64, 32, 255);
color lineColor = color(0, 255,0, 128);

void setup(){
	size(640, 480);

	strokeWeight(1);
	stroke(255);
  step = width / (numberOfPoints-1);
}

void draw(){
	background(bgColor);

  	animSpeed +=0.01f;


  int a = 0;

  for(int b = 1; b < numberOfPoints; b++){
    line(a * step, 240 + sin(a * step + animSpeed) * climb,
    	b * step, 240 + sin(b * step + animSpeed) * climb);
   a=b;
  }
}
