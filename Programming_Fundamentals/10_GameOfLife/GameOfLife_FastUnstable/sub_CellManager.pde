//Manager of cells
class CellManager{
	Cell[][] cells;

	int halfLengthX;
	int halfLengthY;

	

	int lengthX;
	int lengthY;

	Cell[] aliveCells;
	int numberOfAliveCells;
	int totalNumberOfCells;

	Cell[] drawAliveCells;
	int drawNumberOfAliveCells;

	int cellSize = 5;
	

	CellManager(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		reset(cellSizeInPixels, chanceOfLifeAtStart, wrapAround);
	}

	void reset(int cellSizeInPixels, int chanceOfLifeAtStart, boolean wrapAround){
		cellSize = cellSizeInPixels;
		lengthX = (int) (width / cellSize);
		lengthY = (int) (height / cellSize);

		halfLengthX = lengthX / 2;
		halfLengthY = lengthY / 2;

		cells = new Cell[lengthX][lengthY];
		aliveCells = new Cell[lengthX * lengthY];
		drawAliveCells = new Cell[lengthX * lengthY];
		numberOfAliveCells = 0;
		drawNumberOfAliveCells = 0;
		resetCellsArray(chanceOfLifeAtStart, wrapAround);
		totalNumberOfCells = lengthY * lengthX;

		print("X="+lengthX + "  Y=" + lengthY + "  totalcells = " + lengthY*lengthX +"\n");
		print("numberOfAliveCells = " + numberOfAliveCells + "\n"+"length of alive = " + aliveCells.length + "\n");
	}
	
	void resetCellsArray(int chanceOfLifeAtStart, boolean wrapAround){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				resetCell(x, y, chanceOfLifeAtStart);
			}
		}
		
	}

	void resetCell(int posX, int posY, int chanceOfLifeAtStart){
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

	void fillCell(int x, int y, int chanceOfLifeAtStart, int[] cellNeighbors ){
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

	public void thredTest(){
		done = false;
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].checkNumberOfAliveNeighbors(cells);
			}
		}

		numberOfAliveCells = 0;
		fill(color (255));
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				aliveCells[numberOfAliveCells] = cells[x][y];
				numberOfAliveCells += cells[x][y].setState();
				//TODO: Draw here?
			}
		}

		//delay(1);
		done = true;
	}

	void copyToDraw(){
		arrayCopy(aliveCells ,drawAliveCells);
		drawNumberOfAliveCells = numberOfAliveCells;	
	}

	void checkCellNeighbors(){
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				cells[x][y].checkNumberOfAliveNeighbors(cells);
			}
		}
	}

	void setCellState(){
		numberOfAliveCells = 0;
		fill(color (255));
		for(int x = 0; x < lengthX; x++){
			for(int y = 0; y < lengthY; y++){
				aliveCells[numberOfAliveCells] = cells[x][y];
				numberOfAliveCells += cells[x][y].setState();
				//TODO: Draw here?
			}
		}
	}


	void draw(boolean drawFX){
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

		//drawText();
	}
}