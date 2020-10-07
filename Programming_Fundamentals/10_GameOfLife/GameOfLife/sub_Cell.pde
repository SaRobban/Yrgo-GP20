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

	boolean checkIfAlive(){
		return isAlive;
	}

	boolean expandSpaceX(int compX){
		if(isAlive)
			if(posX == compX)
				return true;

		return false;
	}

	boolean expandSpaceY(int compY){
		if(isAlive)
			if(posY == compY)
				return true;

		return false;
	}

	void update(Cell[][] cellGrid){
		setPopulationState();
		checkNumberOfNeighbors(cellGrid);
	}

	void checkNumberOfNeighbors(Cell[][] cellGrid){
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

	void setPopulationState(){
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

	void draw(int cSize, Cell[][] cellGrid){
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





	void colorNeighbors(Cell[][] cellGrid){
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