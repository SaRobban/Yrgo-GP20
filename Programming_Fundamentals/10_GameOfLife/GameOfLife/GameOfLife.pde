//Main Code

//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
//Any live cell with two or three live neighbors lives on to the next generation.
//Any live cell with more than three live neighbors dies, as if by overpopulation.
//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

CellManager cellManager;
int frameRateSpeed = 0;
boolean autoPlay = false;

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
	}

	if(key == 'a'){
		autoPlay = !autoPlay;
	}
}

void cellGenerationStep(){
	if(autoPlay)
		cellManager.update();

	cellManager.draw();
}

void drawText(){
	textSize(12);
	textAlign(RIGHT, TOP);
	text("word", 10, 30); 
	fill(0,0,50);
	text("press S to step one generation forward \n" + "press A to autoplay generations \n" + "press R to restet", width -10, 10);
}