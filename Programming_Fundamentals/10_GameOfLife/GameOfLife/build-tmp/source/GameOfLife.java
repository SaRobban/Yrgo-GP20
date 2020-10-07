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
boolean autoPlay = false;

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
	}

	if(key == 'a'){
		autoPlay = !autoPlay;
	}
}

public void cellGenerationStep(){
	if(autoPlay)
		cellManager.update();

	cellManager.draw();
}

public void drawText(){
	textSize(12);
	textAlign(RIGHT, TOP);
	text("word", 10, 30); 
	fill(0,0,50);
	text("press S to step one generation forward \n" + "press A to autoplay generations \n" + "press R to restet", width -10, 10);
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

	public void update(Cell[][] cellGrid){
		setPopulationState();
		checkNumberOfNeighbors(cellGrid);
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
				colHue = 2;
				colBright = 50;
				wasAlive = isAlive;
			}
			colorNeighbors(cellGrid);
		}else{
			if(wasAlive != isAlive){
				colHue = 0;
				colBright = 25;
				wasAlive = isAlive;
			}
			if(colBright > 25)
				colBright = 25;
			colBright--;
		}
		fill(color(colHue,50,colBright,255));
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
			cellGrid[posX -1][posY +1].colBright++; 
		}
		if(!cellGrid[posX][posY +1].isAlive){
			cellGrid[posX][posY +1].colHue = colHue;
			cellGrid[posX][posY +1].colBright++; 
		}
		if(!cellGrid[posX +1][posY +1].isAlive){
			cellGrid[posX +1][posY +1].colHue = colHue;
			cellGrid[posX +1][posY +1].colBright++; 
		}

		if(!cellGrid[posX -1][posY].isAlive){
			cellGrid[posX -1][posY].colHue = colHue;
			cellGrid[posX -1][posY].colBright++; 
		}
		if(!cellGrid[posX +1][posY].isAlive){
			cellGrid[posX +1][posY].colHue = colHue;
			cellGrid[posX +1][posY].colBright++; 
		}

		if(!cellGrid[posX -1][posY -1].isAlive){
			cellGrid[posX -1][posY -1].colHue = colHue;
			cellGrid[posX -1][posY -1].colBright++; 
		}
		if(!cellGrid[posX][posY -1].isAlive){
			cellGrid[posX][posY -1].colHue = colHue;
			cellGrid[posX][posY -1].colBright++; 
		}
		if(!cellGrid[posX +1][posY -1].isAlive){
			cellGrid[posX +1][posY -1].colHue = colHue;
			cellGrid[posX +1][posY -1].colBright++; 
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
				if(x > 1 && x < lengthX -2 && y > 1 && y < lengthY -2){
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

	public void checkCellNeighbors(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].checkNumberOfNeighbors(cells);
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
