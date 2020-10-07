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

public void setup(){

	
	frameRate(120);
	colorMode(RGB, 255);
	noStroke();
	cellManager = new CellManager(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
}

public void draw(){
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

public void keyPressed() {
 	
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

public void cellGenerationStep(){
	if(autoPlay)
		cellManager.update();

	cellManager.draw(drawFX);
}

public void drawText(){
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
//Singel cell
class Cell{
	int numberOfAliveNeighbors = 0;
	int[] indexOfNeighbors;
	boolean isAlive = false;
	boolean wasAlive = false;
	int posX;
	int posY;

	int age = 0;
	int colHue = 0;
	int colBright = 0;

	Cell(int posX, int posY, boolean alive, int[] indexOfNeighbors){
		this.posX = posX;
		this.posY = posY;
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

	public void setPopulationState(){

		//TODO: check if speed up is posseble
		//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
		//Any live cell with two or three live neighbors lives on to the next generation.
		//Any live cell with more than three live neighbors dies, as if by overpopulation.
		//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
		if(isAlive){
			if(numberOfAliveNeighbors < 2){
				isAlive = false;
				return;
			}else if(numberOfAliveNeighbors < 4){
				isAlive = true;
				return;
			}else{ 
				isAlive = false;
				return;
			}
		}else{
			if(numberOfAliveNeighbors == 3){
				isAlive = true;
				return;
			}
		}
	}

	public void draw(int cSize){
		if(isAlive){
			rect(posX * cSize, posY * cSize, cSize, cSize);
		}
	}

	public void drawFX(int cSize, int largeSize){
		if(isAlive){
			//fill(color(0,128,64,255));
			rect(posX * cSize - cSize, posY * cSize - cSize, largeSize, largeSize);
			//fill(color(0,255,128,255));
			rect(posX * cSize, posY * cSize, cSize, cSize);
		}
	}
}
//Cell Manager
class CellManager{
	Cell[][] cells;
	int lengthX;
	int lengthY;

	int itt = 0;
	int cellSize = 5;

	boolean toggelFX = false;
	
	CellManager(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		reset(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
	}

	public void reset(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		cellSize = cellSizeInPixels;
		lengthX = (int) (width / cellSize);
		lengthY = (int) (height / cellSize);
		print("X="+lengthX + "  Y=" + lengthY + "  totalcells = " + lengthY*lengthX +"\n");
		cells = new Cell[lengthX][lengthY];


		resetCellsArray(chanceOfLifeAtStart, wrapAround);
	}
	public void toggelVisualFX(){
		toggelFX = ! toggelFX;
	}

	public void resetCellsArray(int chanceOfLifeAtStart, boolean wrapAround){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				resetCell(x, y, chanceOfLifeAtStart);
			}
		}
	}

	public void resetCell(int posX, int posY, int chanceOfLifeAtStart){
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
		//Set nolife on edges of array, set random life inside
		if(x > 1 && x < lengthX -2 && y > 1 && y < lengthY -2){
			if((int)random(chanceOfLifeAtStart) == 0){
				cells[x][y] = new Cell(x, y, true, cellNeighbors);
			}else{
				cells[x][y] = new Cell(x,y,false,cellNeighbors);	
			}
		}else {
			cells[x][y] = new Cell(x,y,false,cellNeighbors);
		}
	}

	public void update(){
		checkCellNeighbors();
		setCellPopulation();
	}

	public void checkCellNeighbors(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].checkNumberOfAliveNeighbors(cells);
			}
		}
	}

	public void setCellPopulation(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].setPopulationState();
			}
		}
	}

	public void draw(boolean drawFX){
		fill(color(0,255,128,255));
		if(!drawFX){
			for(int x = 0; x < lengthX; x++){
				for(int y = 0; y < lengthY; y++){
					cells[x][y].draw(cellSize);
				}
			}
			return;
		}else{
			int largeSize = cellSize *3;
			for(int x = 0; x < lengthX; x++){
				for(int y = 0; y < lengthY; y++){
					cells[x][y].drawFX(cellSize, largeSize);
				}
			}
			/*
			for(int x = 0; x < lengthX; x++){
				for(int y = 0; y < lengthY; y++){
				}
			}*/
			return;
		}
	}
}
  public void settings() { 	size(1900,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GameOfLife" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
