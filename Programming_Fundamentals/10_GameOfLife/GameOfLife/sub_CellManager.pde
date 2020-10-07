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

	void reset(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				if(x > 1 && x < lengthX-1 && y > 1 && y < lengthY-1){
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

	void update(){
		/*
		if(cellshasSpace()){
			itt++;
		}else{
			print("MAXSPACE REACHED. ENDED SIM AT: " + itt);
		}
*/
		if(oneLoopUpdate){
			cellUpdate();
		}else{
			checkCellNeighbors();
			setCellPopulation();
		}
	}

	void cellUpdate(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].update(cells);
			}
		}
	}

	void checkCellNeighbors(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].checkNumberOfNeighbors(cells);
			}
		}
	}

	void setCellPopulation(){
		for(int x = 1; x < lengthX -1; x++){
			for(int y = 1; y < lengthY -1; y++){
				cells[x][y].setPopulationState();
			}
		}
	}
/*
	boolean cellshasSpace(){
		//TODO: expand cellArray if no space
		boolean isSpace = false;
		if(hasSpaceUp() && hasSpaceDown() && hasSpaceLeft() && hasSpaceRight()){
			isSpace = true;
		}
		return isSpace;
	}

	boolean hasSpaceLeft(){
		for(int y = 0; y < lengthY; y++){
			if(cells[0][y].isAlive){
				return false;
			}
		}
		return true;
	}

	boolean hasSpaceRight(){
		for(int y = 0; y < lengthY; y++){
			if(cells[lengthX-1][y].isAlive){
				return false;
			}
		}
		return true;
	}

	boolean hasSpaceUp(){
		for(int x = 0; x < lengthY; x++){
			if(cells[x][0].isAlive){
				return false;
			}
		}
		return true;
	}

	boolean hasSpaceDown(){
		for(int x = 0; x < lengthX; x++){
			if(cells[x][lengthY-1].isAlive){
				return false;
			}
		}
		return true;
	}
*/
	void draw(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].draw(cellSize, cells);
			}
		}
	}

}