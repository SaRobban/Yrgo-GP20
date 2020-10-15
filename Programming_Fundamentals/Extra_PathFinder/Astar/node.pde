class Node{
	int score;
	int[] neighbours;
	boolean blocked = false;

	int posX;
	int posY;
	Node(int x, int y, boolean blocked){
		this.posX = x;
		this.posY = y;
		this.blocked = blocked;
	}

	void draw(){

		rect(posX, posY, size, size);
	}
}