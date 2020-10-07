//Main Code

//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
//Any live cell with two or three live neighbors lives on to the next generation.
//Any live cell with more than three live neighbors dies, as if by overpopulation.
//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

int cellSizeInPixels = 4;
int chanceOfLifeAtStart = 5;
boolean wrapAround = true;

CellManager cellManager;
boolean autoPlay = false;


boolean showHelp = true;

boolean drawFX = true;
//startChance of life

void setup(){

	size(1900,1000);
	frameRate(120);
	colorMode(RGB, 255);
	noStroke();
	cellManager = new CellManager(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
}

void draw(){
	if(!drawFX){
		background(0);
	
	}else {
		fill(color(0, 0, 0, 8));
		rect(0, 0, width, height);
	}

	cellGenerationStep();
	if(showHelp)
		drawText();

	fill(color(255,200,0,255));
	text(frameRate, 100, 100);
}

void keyPressed() {
 	
	if(key == 'r'){
		cellManager.reset(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
		print("reset");
	}

	if(key == 's'){
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

	if(key == 'e'){
		cellManager.toggelVisualFX();
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
	fill(0,0,0,25);
	rect(0,0,width,200);
	fill(255,0,0,255);
	textSize(18);
	textAlign(LEFT, TOP);
	text(
		"Press/Hold S to step one generation forward \n" + 
		"Press A to autoplay generations \n" + 
		"Press R to restet\n" +
		"Press z/x to change chanceOfLifeAtStart\n" + 
		"Press q/w to change chanceOfLifeAtStart\n" +
		"Press H to hide menu\n" +
		"Press F to toggle FX"
		, 10, 10);

	textAlign(RIGHT, TOP);
	text(
		"chanceOfLifeAtStart = 1/" + chanceOfLifeAtStart + "\n" +
		"cell size = " + cellSizeInPixels + "\n" +
		"FXon = " + drawFX

		, width -10, 10);

}