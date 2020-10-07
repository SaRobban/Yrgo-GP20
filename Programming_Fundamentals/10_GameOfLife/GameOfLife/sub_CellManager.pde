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

	void reset(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		cellSize = cellSizeInPixels;
		lengthX = (int) (width / cellSize);
		lengthY = (int) (height / cellSize);
		print("X="+lengthX + "  Y=" + lengthY + "  totalcells = " + lengthY*lengthX +"\n");
		cells = new Cell[lengthX][lengthY];


		resetCellsArray(chanceOfLifeAtStart, wrapAround);
	}
	void toggelVisualFX(){
		toggelFX = ! toggelFX;
	}

	void resetCellsArray(int chanceOfLifeAtStart, boolean wrapAround){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				resetCell(x, y, chanceOfLifeAtStart);
			}
		}
	}

	void resetCell(int posX, int posY, int chanceOfLifeAtStart){
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

	void fillCell(int x, int y, int chanceOfLifeAtStart, int[] cellNeighbors ){
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

	void update(){
		checkCellNeighbors();
		setCellPopulation();
	}

	void checkCellNeighbors(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].checkNumberOfAliveNeighbors(cells);
			}
		}
	}

	void setCellPopulation(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].setPopulationState();
			}
		}
	}

	void draw(boolean drawFX){
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