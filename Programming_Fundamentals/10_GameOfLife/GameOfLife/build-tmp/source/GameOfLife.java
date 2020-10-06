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

CellManager cellManager;
int frameRateSpeed = 0;

int rainbow = 0;
public void setup(){

	
	colorMode(HSB, 50);
	cellManager = new CellManager();
}

public void draw(){
	background(0);
	cellGenerationStep();
	drawText();
}

public void keyPressed() {
 	
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

public void cellGenerationStep(){
	//frameRate(frameRateSpeed);
	
	cellManager.draw();
}

public void drawText(){
	textSize(32);
	textAlign(RIGHT, TOP);
	text("word", 10, 30); 
	fill(50,50,50);
	text("press S to step generation forward \n" + "press R to restet", width -10, 10);
}
//Singel cell
class Cell{
	int numberOfNeighbors = 0;
	boolean isAlive = false;
	boolean wasAlive = false;
	int posX;
	int posY;

	int age = 0;
	int colHue = 0;
	int colBright = 0;

	Cell(int posX, int posY, boolean alive){
		this.posX = posX;
		this.posY = posY;
		this.isAlive = alive;
	}

	public void update(Cell[][] cellGrid){
		setPopulationState();
		checkNumberOfNeighbors(cellGrid);
	}

	public boolean checkIfAlive(){
		return isAlive;
	} 

	public boolean expandSpaceX(int compX){
		if(isAlive)
			if(posX == compX)
				return true;

		return false;
	}

	public boolean expandSpaceY(int compY){
		if(isAlive)
			if(posY == compY)
				return true;

		return false;
	}

	public void checkNumberOfNeighbors(Cell[][] cellGrid){
		numberOfNeighbors = 0;
		//Explanation of Intent:
		//I do this matrix instead of loop to prevent extra checkup (if cell is self)
		//XXX
		//X X
		//XXX
		if(cellGrid[posX -1][posY +1].isAlive)
			numberOfNeighbors++;

		if(cellGrid[posX]	[posY +1].isAlive)
			numberOfNeighbors++;
		
		if(cellGrid[posX +1][posY +1].isAlive)
			numberOfNeighbors++;
		
		if(cellGrid[posX -1][posY].isAlive)
			numberOfNeighbors++;
		
		if(cellGrid[posX +1][posY].isAlive)
			numberOfNeighbors++;
		
		if(cellGrid[posX -1][posY -1].isAlive)
			numberOfNeighbors++;
		
		if(cellGrid[posX]	[posY -1].isAlive)
			numberOfNeighbors++;

		if(cellGrid[posX +1][posY -1].isAlive)
			numberOfNeighbors++;
	}

	public void setPopulationState(){
		//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
		//Any live cell with two or three live neighbors lives on to the next generation.
		//Any live cell with more than three live neighbors dies, as if by overpopulation.
		//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
		if(isAlive){
			if(numberOfNeighbors < 2){
				isAlive = false;
			}else if(numberOfNeighbors < 4){
				isAlive = true;
			}else{ 
				isAlive = false;
			}
		}else{
			if(numberOfNeighbors == 3){
				isAlive = true;
			}
		}
	}

	public void draw(int cSize, Cell[][] cellGrid){
		if(isAlive){
			age++;
			if(wasAlive != isAlive){
				colHue = rainbow;
				wasAlive = isAlive;
				colorNeighbors(cellGrid);
			}
			colBright = 50;
			fill(color(colHue,255,colBright,255));
			
		}else{
			//colHue --;
			//colHue = colHue % 50;
			colBright--;
			fill(colHue,255,colBright,255);
		}
		rect(posX * cSize, posY * cSize, cSize, cSize);
	}


	public void colorNeighbors(Cell[][] cellGrid){
		numberOfNeighbors = 0;
		//Explanation of Intent:
		//I do this matrix instead of loop to prevent extra checkup (if cell is self)
		//XXX
		//X X
		//XXX

		if(!cellGrid[posX -1][posY +1].isAlive){
			cellGrid[posX -1][posY +1].colHue = colHue;
			cellGrid[posX -1][posY +1].colBright = 25; 
		}
		if(!cellGrid[posX][posY +1].isAlive){
			cellGrid[posX][posY +1].colHue = colHue;
			cellGrid[posX][posY +1].colBright = 25; 
		}
		if(!cellGrid[posX +1][posY +1].isAlive){
			cellGrid[posX +1][posY +1].colHue = colHue;
			cellGrid[posX +1][posY +1].colBright = 25; 
		}

		if(!cellGrid[posX -1][posY].isAlive){
			cellGrid[posX -1][posY].colHue = colHue;
			cellGrid[posX -1][posY].colBright = 25; 
		}
		if(!cellGrid[posX +1][posY].isAlive){
			cellGrid[posX +1][posY].colHue = colHue;
			cellGrid[posX +1][posY].colBright = 25; 
		}

		if(!cellGrid[posX -1][posY -1].isAlive){
			cellGrid[posX -1][posY -1].colHue = colHue;
			cellGrid[posX -1][posY -1].colBright = 25; 
		}
		if(!cellGrid[posX][posY -1].isAlive){
			cellGrid[posX][posY -1].colHue = colHue;
			cellGrid[posX][posY -1].colBright = 25; 
		}
		if(!cellGrid[posX +1][posY -1].isAlive){
			cellGrid[posX +1][posY -1].colHue = colHue;
			cellGrid[posX +1][posY -1].colBright = 25; 
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
	
	boolean oneLoopUpdate = false;

	CellManager(){
		cellSize = 5;
		lengthX = (int) (width / cellSize);
		lengthY = (int) (height / cellSize);
		print("X="+lengthX + "  Y=" + lengthY + "\n");
		cells = new Cell[lengthX][lengthY];
		reset();
	}

	public void reset(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				if(x > 60 && x < 100 && y > 60 && y < 100){
					if((int)random(5) == 0){
						cells[x][y] = new Cell(x,y,true);
					}else{
						cells[x][y] = new Cell(x,y,false);	
					}
				}else {
					cells[x][y] = new Cell(x,y,false);
				}
			}
		}
	}

	public void update(){
		if(cellshasSpace()){
			itt++;
		}else{
			print("MAXSPACE REACHED. ENDED SIM AT: " + itt);
		}

		if(oneLoopUpdate){
			cellUpdate();
		}else{
			checkCellNeighbors();
			setCellPopulation();
		}
	}

	public void cellUpdate(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].update(cells);
			}
		}
	}

	public void setCellPopulation(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].setPopulationState();
			}
		}
	}

	public void checkCellNeighbors(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].checkNumberOfNeighbors(cells);
			}
		}
	}

	public boolean cellshasSpace(){
		//TODO: expand cellArray if no space
		boolean isSpace = false;
		if(hasSpaceUp() && hasSpaceDown() && hasSpaceLeft() && hasSpaceRight()){
			isSpace = true;
		}
		return isSpace;
	}

	public boolean hasSpaceLeft(){
		for(int y = 0; y < lengthY; y++){
			if(cells[0][y].isAlive){
				return false;
			}
		}
		return true;
	}

	public boolean hasSpaceRight(){
		for(int y = 0; y < lengthY; y++){
			if(cells[lengthX-1][y].isAlive){
				return false;
			}
		}
		return true;
	}

	public boolean hasSpaceUp(){
		for(int x = 0; x < lengthY; x++){
			if(cells[x][0].isAlive){
				return false;
			}
		}
		return true;
	}

	public boolean hasSpaceDown(){
		for(int x = 0; x < lengthX; x++){
			if(cells[x][lengthY-1].isAlive){
				return false;
			}
		}
		return true;
	}

	public void draw(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].draw(cellSize, cells);
			}
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
