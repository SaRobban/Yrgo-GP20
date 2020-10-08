//Singel cell
class Cell{
	int numberOfAliveNeighbors = 0;
	int[] indexOfNeighbors;
	boolean isAlive = false;
	boolean wasAlive = false;
	int posX;
	int posY;

	Cell(int posX, int posY, int cellSize, boolean alive, int[] indexOfNeighbors){
		this.posX = posX * cellSize;
		this.posY = posY * cellSize;
		this.isAlive = alive;
		this.indexOfNeighbors = indexOfNeighbors;
	}

	boolean checkIfAlive(){
		return isAlive;
	}

	void checkNumberOfAliveNeighbors(Cell[][] cellGrid){
		numberOfAliveNeighbors = 0;
		for(int x = 0; x < indexOfNeighbors.length; x+=2){
			if(cellGrid[indexOfNeighbors[x]][indexOfNeighbors[x+1]].isAlive){
				numberOfAliveNeighbors++;
			}
		}
	}

	int setState(){
		//TODO: check if speed up is posseble, first by toggle order of if statements
		//Any live cell with fewer than two live neighbors dies, as if caused by underpopulation. 
		//Any live cell with two or three live neighbors lives on to the next generation. 2,3
		//Any live cell with more than three live neighbors dies, as if by overpopulation.
		//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

		if(numberOfAliveNeighbors == 3){
				isAlive = true;
				return 1;
		}else if(numberOfAliveNeighbors == 2){
			if(isAlive){
				isAlive = true;
				return 1;
			}
		}
		isAlive = false;
		return 0;
			
	}

	void draw(int cSize){
		if(isAlive){
			rect(posX, posY, cSize, cSize);
		}
	}

	void drawFX(int cSize, int largeSize){
		if(isAlive){
			rect(posX - cSize, posY - cSize, largeSize, largeSize);
		}
	}
}