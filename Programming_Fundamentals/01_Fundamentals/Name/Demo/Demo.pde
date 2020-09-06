//Rober Sandh

//Animation variables
float anim = 0;
float animGrid = 0;
int maxAnimF = 10;
boolean rewerse = false;

//ScreenSize in pixels
int screenSizeX = 768;
int screenSizeY = 432;



void setup()
{ 
  //Set screen size (in pixels) for some reason does not take variables from above 
  size(768, 432);
  //loop(); Turns out i dont need this WHY??? How long between frames!??! GWHAAAAAAA!!!!!!!!
}

//This is somehow constantly auto updated unknown how long between updates and output.
void draw()
{
  color bgC = color(20, 70, 50);
  color gridC = color(20, 255, 128,32);
  color textC = color(0, 0, 0,255);
 // color textOutC = color(32, 128, 32,255);
  color uLineC = color(32, 128, 64,255);
  
	//Setup basic attrebutes for Scene
	SetupBasics(bgC, textC);

	//Start Text at...
	float screenOffX = 45;
	float screenOffY = 125;

	//Common Letter attrebutes
	float letterSpace = 85;
	int letterNum = 0;
	float letterHight = 140;
	float letterWidth = 61;
	float letterThick = 10;
	float letterOutL = 20;
  
	//This is where the animation variable rules are set
	AnimationController();
   
 	//put Very Cool animations here:
  	//-:Draw Grid:-
  	GridFX(animGrid, gridC);

 	//Prevent lines to be drawn with zero length
	if(anim > 0.0){
	   
	    //Create animation variable for letters
		float f = anim;
		
		float rOne = constrain(f,0,1);
	    float o = constrain(f-1,0,1);
	    float b = constrain(f-2,0,1);
	    float e = constrain(f-3,0,1);
	    float r = constrain(f-4,0,1);
	    float t = constrain(f-5,0,1);

	    float fxOne = constrain(f-6,0,2);
	    float fxTwo = constrain(f-6.25,0,2);
	    float fxTre = constrain(f-6.5,0,2);
	    float fxFor = constrain(f-6.75,0,2);
	    float fxFiv = constrain(f-7,0,2);

	    //-:Draw Name:-
	    //Set Color for letters
		//Draw Letters
		LetterLineBG(rOne);
		DrawCapitalR(letterSpace * letterNum + screenOffX, screenOffY, letterWidth *rOne, letterHight);	
		LetterLine(rOne);
		DrawCapitalR(letterSpace * letterNum + screenOffX, screenOffY, letterWidth *rOne, letterHight);

		letterNum++;

		if(o>0){
			LetterLineBG(o);
			DrawO(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * o, letterHight);
			LetterLine(o);
			DrawO(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * o, letterHight);
		}
			letterNum++;
		if(b>0){
			LetterLineBG(b);
			DrawB(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * b, letterHight);
			LetterLine(b);
			DrawB(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * b, letterHight);
		}
			letterNum++;

		if(e>0){
			LetterLineBG(e);
			DrawE(letterSpace * letterNum + screenOffX, screenOffY, letterWidth *e, letterHight);
			LetterLine(e);
			DrawE(letterSpace * letterNum + screenOffX, screenOffY, letterWidth *e, letterHight);
		}
			letterNum++;
		if(r>0){
			LetterLineBG(r);
			DrawR(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * r, letterHight);
			LetterLine(r);
			DrawR(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * r, letterHight);
		}
			letterNum++;
		if(t>0){
			LetterLineBG(t);
			DrawT(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * t, letterHight);
			LetterLine(t);
			DrawT(letterSpace * letterNum + screenOffX, screenOffY, letterWidth * t, letterHight);		
		}


		//-:Draw Special:-
		int row = 0;
		float lineH = letterHight / 4;
		float lineOf = -lineH * 0.5;//lineH * 0.25;
		letterNum++;
		
		//-:Draw Stripes:-
		if(fxOne > 0){
			FxRect(screenOffX + letterSpace * letterNum, screenOffY + lineOf + lineH * row, fxOne * letterSpace, lineH, color(255, 0, 0));
		}
		row++;
		if(fxTwo > 0){
			FxRect(screenOffX + letterSpace * letterNum, screenOffY + lineOf  + lineH * row, fxTwo * letterSpace, lineH, color(255, 128, 0));
		}
		row++;
		if(fxTre > 0){
			FxRect(screenOffX + letterSpace * letterNum, screenOffY + lineOf  + lineH * row, fxTre * letterSpace, lineH, color(255, 255, 0));
		}
		row++;
		if(fxFor > 0){
			FxRect(screenOffX + letterSpace * letterNum, screenOffY + lineOf  + lineH * row, fxFor * letterSpace, lineH, color(0, 255, 0));
		}
		row++;
		if(fxFiv > 0){
			FxRect(screenOffX + letterSpace * letterNum, screenOffY + lineOf  + lineH * row, fxFiv * letterSpace, lineH, color(0, 128, 255));
		}
		row++;

		//-:Draw UnderLine:-
		letterNum+=2;
		FxUnderLine(screenOffX, screenOffY + letterHight + 40, f * 0.1 * letterSpace * letterNum, uLineC);
	}
}



void SetupBasics(color bgC, color tC){
    background(bgC);
    stroke(tC);
    strokeWeight(20.5);
    noFill();
}

void AnimationController(){
//Move	
	animGrid += 0.2;
	if( animGrid > maxAnimF){
		animGrid = 0;
	}
//Pingpong
	if(rewerse){
		anim -= 0.1;
	}else{
		anim += 0.01;
	}

  	if (anim <= 0) { 
  		anim = 0;
    	rewerse = false; 
	}

	if(anim >= maxAnimF){
		anim = maxAnimF;
		rewerse = true;
	}
	//For prtscr
	//anim = 10;
}

void GridFX(float animations, color gC){
	stroke(gC);
    strokeWeight(2.5);
    noFill();

	float middle = screenSizeX * 0.5;
	float xJump = screenSizeX * 0.1;

	//Draw perspective
	for(int i = 0; i< 10; i++){
		line(middle + (i - 5) * xJump, 0, middle + (i - 5) * 4 * xJump, screenSizeY);
	}

  	//Draw Movement
 	float f = animations * 0.1;
	for(int i = 0; i< 10; i++){
		float ft = i+f;
		float y = ft * ft * 0.05 * screenSizeY; 
		line(0, y, screenSizeX, y);
	}
}

void LetterLine(float animations){
	stroke(lerp(20,64, animations), lerp(70, 255, animations), lerp(20, 128, animations), 255);
	//stroke(255,255,255, lerp(0, 255, animations));
    strokeWeight(15);
}

void LetterLineBG(float animations){
	stroke(lerp(20, 32, animations), lerp(70, 128, animations), lerp(50, 64, animations), 255);
	//stroke(255,255,255, lerp(0, 255, animations));
    strokeWeight(20);
}

void DrawCapitalR(float x, float y, float lw, float lh){
  	line(x, y, x, y + lh);
  	line(x , y + lh * 0.5f, x + lw, y + lh);
  	//Circle center X,Y, length, hight, startArc, endArc...
  	arc(x, y + lh * 0.25, lw * 2, lh * 0.5, HALF_PI *3 , HALF_PI *5);
}

void DrawO(float x, float y, float lw, float lh){
  	ellipse(x + lw *0.5, y + lh*0.75, lw, lh *0.5);
}

void DrawB(float x, float y, float lw, float lh){

  	line(x,y,x,y + lh);
   	arc(x + lw *0.5, y + lh*0.75, lw, lh * 0.5, HALF_PI *2 , HALF_PI *5);
}

void DrawE(float x, float y, float lw, float lh){
   	arc(x + lw *0.5, y + lh * 0.75, lw, lh * 0.5, HALF_PI, HALF_PI* 4);
   	line(x, y + lh * 0.75, x+lw, y + lh * 0.75);
}

void DrawR(float x, float y, float lw, float lh){
  	arc(x + lw * 0.5, y + lh * 0.75, lw, lh * 0.5, HALF_PI *2, HALF_PI* 4);
   	line(x, y + lh * 0.5, x, y + lh);
}

void DrawT(float x, float y, float lw, float lh){
  	line(x, y + lh * 0.5, x + lw, y + lh*0.5);
  	line(x + lw * 0.5, y, x + lw * 0.5, y+lh);
}

void FxRect(float x, float y, float animation, float h, color c){
    strokeWeight(0);
    fill(c);
	rect(x, y, animation, h - 10,5);
}

void FxUnderLine(float x, float y ,float animation, color ulineC){
	  stroke(ulineC);
    strokeWeight(10);
	line(x,y ,x + animation, y);
}
