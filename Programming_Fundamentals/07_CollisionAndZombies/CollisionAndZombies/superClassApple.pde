class Apple extends GameObject{
  color colApple = color(255,0,0,255);
  int radius;
  Apple(float x, float y, int r){
     super(x,y);
    this.radius = r;
  }  
  
  void draw(){
    fill(colApple);
    circle(position.x, position.y, radius);
  }
}
