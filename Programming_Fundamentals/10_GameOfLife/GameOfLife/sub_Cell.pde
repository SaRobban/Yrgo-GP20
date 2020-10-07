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

	boolean checkIfAlive(){
		return isAlive;
	}

	void checkNumberOfAliveNeighbors(Cell[][] cellGrid){
		numberOfAliveNeighbors = 0;
		for(int x = 0; x < indexOfNeighbors.length; x+=2){
			if(cellGrid[indexOfNeighbors[x]][indexOfNeighbors[x+1]].isAlive)
				numberOfAliveNeighbors++;
		}
	}

	void setPopulationState(){

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

	void draw(int cSize){
		if(isAlive){
			rect(posX * cSize, posY * cSize, cSize, cSize);
		}
	}

	void drawFX(int cSize, int largeSize){
		if(isAlive){
			//fill(color(0,128,64,255));
			rect(posX * cSize - cSize, posY * cSize - cSize, largeSize, largeSize);
			//fill(color(0,255,128,255));
			rect(posX * cSize, posY * cSize, cSize, cSize);
		}
	}
}