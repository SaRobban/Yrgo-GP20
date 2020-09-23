
//GameObject myObject;
Apple myApple;
Pear myPear;
void setup(){
  size(512, 512);
   //myObject = new GameObject(100, 100);
   myApple = new Apple(100,100,5);
   myPear = new Pear(200,100,5);
}

void draw(){
  background(0);
  
  //instanceof Apple
  myApple.draw();
  myPear.draw();
}
