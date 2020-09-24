Apple myApple;
Pear myPear;
void setup(){
  size(512, 512);
   myApple = new Apple(100,100,5);
   myPear = new Pear(200,100,5);
}

void draw(){
  background(0);
  
  myApple.draw();
  myPear.draw();
}
