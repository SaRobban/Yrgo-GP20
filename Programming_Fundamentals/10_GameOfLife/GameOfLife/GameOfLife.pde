//Main Code
//TODO: Toggle wraparound
//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
//Any live cell with two or three live neighbors lives on to the next generation.
//Any live cell with more than three live neighbors dies, as if by overpopulation.
//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

int cellSizeInPixels = 2;
int chanceOfLifeAtStart = 5;
CellManager cellManager;

boolean showHelp = true;
boolean wrapAround = true;
boolean autoPlay = false;
boolean drawFX = true;

void setup(){
	size(800,800);
	frameRate(120);
	colorMode(RGB, 255);
	noStroke();

	cellManager = new CellManager(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
}

void draw(){
	if(!drawFX){
		//Set BG
		background(0);
	
	}else{
		//Fade BG
		fill(color(0, 0, 0, 4));
		rect(0, 0, width, height);
	}

	cellGenerationStep();


	if(showHelp)
		drawText();

	fpsCounter();
}

void keyPressed() {
 	
	if(key == 'r'){
		cellManager.reset(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
		print("reset");
	}

	if(key == 's'){
		autoPlay = false;
		cellManager.update();
	}

	if(key == 'a'){
		autoPlay = !autoPlay;
	}

	if(key == 'f'){
		drawFX = !drawFX;
	}

	if(key == 'z'){
		chanceOfLifeAtStart--;
		if(chanceOfLifeAtStart < 1)
			chanceOfLifeAtStart = 1;
	}
	if(key == 'x'){
		chanceOfLifeAtStart++;
		if(chanceOfLifeAtStart > 100)
			chanceOfLifeAtStart = 100;
	}
	if(key == 'q'){
		cellSizeInPixels--;
		if(cellSizeInPixels < 1)
			cellSizeInPixels = 1;
	}
	if(key == 'w'){
		cellSizeInPixels++;
		if(cellSizeInPixels > 100)
			cellSizeInPixels = 100;
	}

	if(key == 'h'){
		showHelp = !showHelp;
	}
}

void cellGenerationStep(){
	if(autoPlay)
		cellManager.update();

	cellManager.draw(drawFX);
}

void drawText(){
	fill(0,0,0,200);
	rect(0,0,width,260);
	fill(255,220,0,255);
	textSize(18);
	textAlign(LEFT, TOP);
	text(
		"Press R to reset\n" +
		"Press/Hold S to step forward \n" + 
		"Press A to toggle autoplay\n\n" + 
		"Press Q/W to change cell Size at reset\n" +
		"Press Z/X to change chance of life at reset\n\n" + 
		"Press F to toggle FX\n" +
		"Press H to hide/show menu\n"
		, 10, 10);

	textAlign(RIGHT, TOP);
	text(
		"Chance of life at start = 1/" + chanceOfLifeAtStart + "\n" +
		"Cell size = " + cellSizeInPixels + "\n" +
		"Number of live cells = " + cellManager.numberOfAliveCells +"\n" +
		"FX on = " + drawFX

		, width -10, 10);
}

void fpsCounter(){
	textAlign(RIGHT, BOTTOM);
	fill(color(0,0,0,255));
	rect(width-95, height-30, 90, 20);
	fill(color(255,200,0,255));
	text("FPS: " + nf(frameRate,0,1), width -10, height -10);
}