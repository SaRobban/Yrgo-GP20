//Modyfied copypaste from assingment

//Create our timing variable
int frame = 0;
int animStep = 0;

int offsetFromCorner = 20;
//Background
color bgC = color(128,128,128,255);
color bgTwoC = color(255,255,255,64);

//Lines
int spaceBetweenLines = 10;
int colorIntervall = 3;
color lineC = color(255,255,255,128);
color oddLineC = color(0,0,0,255);



void setup()
{
	size(640, 480);
}

void draw()
{
	//THX. Simon J, for convert to float
	float xAspect = (float)width / (float)height;

	DrawBackGround();


	//Draw our scan lines.
	strokeWeight(2);
	for (int y = offsetFromCorner; y < height -offsetFromCorner; y += spaceBetweenLines) {
		//Multiply x axis by aspext to fill screen
		float x = xAspect * y;

		//Line Color by number
		stroke(lineC);
		if((y + animStep) % colorIntervall == 0){
			stroke(oddLineC);
		}

		//Draw line 
		line(offsetFromCorner, y % height, x % width, height -offsetFromCorner);

	}
	//Increment our frame count
	frame++;
  
  if(frame % 10 == 0){
    animStep++;
  }
}

void DrawBackGround(){
	//Clear background
	background(bgC);
	noStroke();
	fill(bgTwoC);

	//Draw our art, or in this case a rectangle
	rect(40, 40, width -80, height -80);
}
