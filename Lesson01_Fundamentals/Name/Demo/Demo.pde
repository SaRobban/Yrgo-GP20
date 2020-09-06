//Rober Sandh

float anim = 0;
float animTwo = 0;
boolean rewerse = false;


void setup()
{
  size(768, 432);
  //loop(); Turns out i dont need this WHY??? How long between frames!??! GWHAAAAAAA!!!!!!!!
  //////////////////////////DO NOT QUESTION///////////////////////
}

void draw()
{
  float letterSpace = 120;
  int letterNum = 0;
  
  float screenOffX = 40;
  float screenOffY = 100;

  float letterHight = 200;
  float letterWidth = 100;
  
  //put V´Cool animations here
  animation();

//letterSpace *= anim;
letterWidth *= anim;
letterHight *= anim * anim;

	if(anim > 0.0){

		setupLine(anim);

		float  f = (anim * anim);

		stroke(lerp(255, 255, f), lerp(128, 255, f), lerp(192, 255, f));


		drawCapitalR(letterSpace * letterNum + screenOffX, screenOffY, letterWidth, letterHight);
		letterNum++;

		drawO(letterSpace * letterNum + screenOffX, screenOffY, letterWidth, letterHight);
		letterNum++;

		drawB(letterSpace * letterNum + screenOffX, screenOffY, letterWidth, letterHight);
		letterNum++;

		drawE(letterSpace * letterNum + screenOffX, screenOffY, letterWidth, letterHight);
		letterNum++;

		drawR(letterSpace * letterNum + screenOffX, screenOffY, letterWidth, letterHight);
		letterNum++;

		drawT(letterSpace * letterNum + screenOffX, screenOffY, letterWidth, letterHight);		
	}

	if(animTwo > 0.1){

		stroke(255, animTwo * 255, animTwo * 255);
		draUnderLine(screenOffX, screenOffY + letterHight + 40* anim * anim, letterSpace * animTwo*6);
	}

}

void setupLine(float a){
    background(255, 128, 192);
    stroke(255, 179, 242);
    strokeWeight(a * 20.5);
    noFill();
    //fill(1, 0, 100);
}

void animation(){
	
	if(rewerse){
		anim -= 0.01;
	}else{
		anim += 0.01;
	}
	

  if (anim <= 0) { 
    	animTwo = 0;
    	rewerse = false; 
	}

	if(anim >= 1){
		anim = 1;
		animTwo +=0.01;
	}

	if(animTwo > 1){
		rewerse = true;
	}
}

void drawCapitalR(float x, float y, float lw, float lh){
	line(x, y, x, y + lh);
	line(x , y + lh * 0.5f, x + lw, y + lh);
	//Circle center X,Y, length, hight, startArc, endArc...
	arc(x, y + lh * 0.25, lw * 2, lh * 0.5, HALF_PI *3 , HALF_PI *5);
}

void drawO(float x, float y, float lw, float lh){
	ellipse(x + lw *0.5, y + lh*0.75, lw, lh *0.5);
}

void drawB(float x, float y, float lw, float lh){

	line(x,y,x,y + lh);
 	arc(x + lw *0.5, y + lh*0.75, lw, lh * 0.5, HALF_PI *2 , HALF_PI *5);
}

void drawE(float x, float y, float lw, float lh){
 //ellipse(320, 220, 55, 55);
 	arc(x + lw *0.5, y + lh * 0.75, lw, lh * 0.5, HALF_PI, HALF_PI* 4);
 	line(x, y + lh * 0.75, x+lw, y + lh * 0.75);
}

void drawR(float x, float y, float lw, float lh){
	arc(x + lw * 0.5, y + lh * 0.75, lw, lh * 0.5, HALF_PI *2, HALF_PI* 4);
 	line(x, y + lh * 0.5, x, y + lh);
}

void drawT(float x, float y, float lw, float lh){
	line(x, y + lh * 0.5, x + lw, y + lh*0.5);
  	line(x + lw * 0.5, y, x + lw * 0.5, y+lh);
}

void draUnderLine(float x, float y,float xTwo){
	line(x,y,xTwo,y);
}
