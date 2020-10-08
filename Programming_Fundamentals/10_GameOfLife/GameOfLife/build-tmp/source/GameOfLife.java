import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GameOfLife extends PApplet {

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

public void setup(){
	
	frameRate(120);
	colorMode(RGB, 255);
	noStroke();

	cellManager = new CellManager(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
}

public void draw(){
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

public void keyPressed() {
 	
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

public void cellGenerationStep(){
	if(autoPlay)
		cellManager.update();

	cellManager.draw(drawFX);
}

public void drawText(){
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

public void fpsCounter(){
	textAlign(RIGHT, BOTTOM);
	fill(color(0,0,0,255));
	rect(width-95, height-30, 90, 20);
	fill(color(255,200,0,255));
	text("FPS: " + nf(frameRate,0,1), width -10, height -10);
}
//Singel cell
class Cell{
	int numberOfAliveNeighbors = 0;
	int[] indexOfNeighbors;
	boolean isAlive = false;
	int posX;
	int posY;

	Cell(int posX, int posY, int cellSize, boolean alive, int[] indexOfNeighbors){
		this.posX = posX * cellSize;
		this.posY = posY * cellSize;
		this.isAlive = alive;
		this.indexOfNeighbors = indexOfNeighbors;
	}

	public boolean checkIfAlive(){
		return isAlive;
	}

	public void checkNumberOfAliveNeighbors(Cell[][] cellGrid){
		numberOfAliveNeighbors = 0;
		for(int x = 0; x < indexOfNeighbors.length; x+=2){
			if(cellGrid[indexOfNeighbors[x]][indexOfNeighbors[x+1]].isAlive)
				numberOfAliveNeighbors++;
		}
	}

	public int setState(){
		//TODO: check if speed up is posseble, first by toggle order of if statements
		//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
		//Any live cell with two or three live neighbors lives on to the next generation.
		//Any live cell with more than three live neighbors dies, as if by overpopulation.
		//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
		if(isAlive){
			if(numberOfAliveNeighbors < 2){
				isAlive = false;
				return 0;
			}else if(numberOfAliveNeighbors < 4){
				isAlive = true;
				return 1;
			}else{ 
				isAlive = false;
				return 0;
			}
		}else{
			if(numberOfAliveNeighbors == 3){
				isAlive = true;
				return 1;
			}
		}
		return 0;
	}

	public void draw(int cSize){
		if(isAlive){
			rect(posX, posY, cSize, cSize);
		}
	}

	public void drawFX(int cSize, int largeSize){
		if(isAlive){
			rect(posX - cSize, posY - cSize, largeSize, largeSize);
		}
	}
}
//Manager of cells
class CellManager{
	Cell[][] cells;
	int lengthX;
	int lengthY;

	Cell[] aliveCells;
	int numberOfAliveCells;

	int cellSize = 5;
	

	CellManager(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		reset(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
	}

	public void reset(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		cellSize = cellSizeInPixels;
		lengthX = (int) (width / cellSize);
		lengthY = (int) (height / cellSize);

		cells = new Cell[lengthX][lengthY];
		aliveCells = new Cell[lengthX * lengthY];
		numberOfAliveCells = 0;

		resetCellsArray(chanceOfLifeAtStart, wrapAround);

		print("X="+lengthX + "  Y=" + lengthY + "  totalcells = " + lengthY*lengthX +"\n");
		print("numberOfAliveCells = " + numberOfAliveCells + "\n"+"length of alive = " + aliveCells.length + "\n");
	}
	
	public void resetCellsArray(int chanceOfLifeAtStart, boolean wrapAround){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				resetCell(x, y, chanceOfLifeAtStart);
			}
		}
		
	}

	public void resetCell(int posX, int posY, int chanceOfLifeAtStart){
		//WARNING: You are inside a loop. 
		int minX = posX-1;
		int maxX = posX+1;
		int minY = posY-1;
		int maxY = posY+1;

		if(minX < 0){
			minX = lengthX-1;
		}
		if(maxX > lengthX-1){
			maxX = 0;
		}
		if(minY < 0){
			minY = lengthY-1;
		}
		if(maxY > lengthY-1){
			maxY = 0;
		}

		int[] cellNeighbors = {
			minX, minY, 
			posX, minY,
			maxX, minY,
			minX, posY,
			maxX, posY,
			minX, maxY,
			posX, maxY,
			maxX, maxY
		};
		fillCell(posX, posY, chanceOfLifeAtStart, cellNeighbors);
	}

	public void fillCell(int x, int y, int chanceOfLifeAtStart, int[] cellNeighbors ){
		//WARNING: You are inside a loop.
		//Set nolife on edges of array, set random life inside
		if(x > 1 && x < lengthX -2 && y > 1 && y < lengthY -2){
			if((int)random(chanceOfLifeAtStart) == 0){
				cells[x][y] = new Cell(x, y, cellSize, true, cellNeighbors);
				aliveCells[numberOfAliveCells] = cells[x][y];
				numberOfAliveCells++;
			}else{
				cells[x][y] = new Cell(x, y, cellSize, false, cellNeighbors);	
			}
		}else {
			cells[x][y] = new Cell(x, y, cellSize, false, cellNeighbors);
		}
	}


	public void update(){
		checkCellNeighbors();
		setCellState();
	}

	public void checkCellNeighbors(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].checkNumberOfAliveNeighbors(cells);
			}
		}
	}

	public void setCellState(){
		numberOfAliveCells = 0;
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				aliveCells[numberOfAliveCells] = cells[x][y];
				numberOfAliveCells += cells[x][y].setState();
			}
		}
	}


	public void draw(boolean drawFX){
		if(drawFX){
			fill(color(0,128,128,255));
			int largeSize = cellSize * 3;
			for(int i = 0; i < numberOfAliveCells; i++){
				aliveCells[i].drawFX(cellSize, largeSize);
			}
		}

		fill(color(0,255,128,255));
		for(int i = 0; i < numberOfAliveCells; i++){
			aliveCells[i].draw(cellSize);
		}
	}
}
  public void settings() { 	size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GameOfLife" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
