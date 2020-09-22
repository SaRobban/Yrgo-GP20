void HUD(int hp, int wave){
	textAlign(LEFT, UP);
	fill(255, 102, 153,255);
	textSize(32);
	text("HP: " + hp, 10, 60); 
	text("Wave: " + wave, 10, 30); 
}

