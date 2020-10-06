//Main Code

//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
//Any live cell with two or three live neighbors lives on to the next generation.
//Any live cell with more than three live neighbors dies, as if by overpopulation.
//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

CellManager cellManager;
int frameRateSpeed = 0;

int rainbow = 0;
void setup(){

	size(800,800);
	colorMode(HSB, 50);
	cellManager = new CellManager();
}

void draw(){
	background(0);
	cellGenerationStep();
	drawText();
}

void keyPressed() {
 	
	if(key == 'r'){
		cellManager.reset();
		print("reset");
	}

	if(key == 'o'){
		cellManager.oneLoopUpdate = !cellManager.oneLoopUpdate;
		print("oneLoopUpdate = " + cellManager.oneLoopUpdate);
	}

	if(key == 's'){
		cellManager.update();

		rainbow++;
		rainbow = rainbow % 50;
	}

	if (key == CODED) {
		if (keyCode == UP) {
			frameRateSpeed++;
		} else if (keyCode == DOWN) {
			frameRateSpeed--;
		} 
  }
  if(frameRateSpeed < 0){
  	frameRateSpeed = 1;
  	print("framerate" + frameRateSpeed);
  }
}

void cellGenerationStep(){
	//frameRate(frameRateSpeed);
	
	cellManager.draw();
}

void drawText(){
	textSize(32);
	textAlign(RIGHT, TOP);
	text("word", 10, 30); 
	fill(50,50,50);
	text("press S to step generation forward \n" + "press R to restet", width -10, 10);
}