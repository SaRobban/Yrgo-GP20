void HUD(int hp, int wave){
	textAlign(LEFT, UP);
	fill(255, 255, 255, 255);
	textSize(32);
	text("HP: " + hp, 10, 60); 
	text("Wave: " + wave, 10, 30); 


	fill(0, 0, 0, 32);
	text("HP: " + hp, 12, 64); 
	text("Wave: " + wave, 12, 34); 
}

