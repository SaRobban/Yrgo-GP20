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

	void update(){
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

	void draw(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].draw(cellSize, cells);
			}
		}
	}
}