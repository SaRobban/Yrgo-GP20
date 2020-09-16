Ball ball;
BoxCollider2D colliders[];

PVector midScreen;
PVector mouseuoi;


PVector hitVector = new PVector();

int scoreMultiplyer = 0;


void setup(){
    size(640, 480);
    ball = new Ball(40, 320, 240);

    colliders = new BoxCollider2D[6];
    //room
    colliders[0] = new BoxCollider2D(320,560,640,100, 0.0);
    colliders[1] = new BoxCollider2D(-80,320,100,360, 0.0);
    colliders[2] = new BoxCollider2D(720,320,100,360, 0.0);
    colliders[3] = new BoxCollider2D(320,-80,640,100, 0.0);

//deco
    colliders[4] = new BoxCollider2D(0,40,80,80, -0.523599);
    colliders[5] = new BoxCollider2D(640,40,80,80, 0.523599);
//basket
    //colliders[6] = new BoxCollider2D(100,400,0,40, -0.1);
    //colliders[7] = new BoxCollider2D(200,400,0,40, 0.1);





    midScreen = new PVector(width * 0.5, height * 0.5);
    mouseuoi = new PVector(mouseX, mouseY);

}

void draw(){
    background(0);

    ball.Draw();


    if(mousePressed){
        mouseuoi.set(mouseX, mouseY);
        PVector force = AddForce(midScreen, mouseuoi);

        stroke(255);
        line(mouseX, mouseY, mouseX + force.x, mouseY + force.y);
        force.mult(0.1);

        ball.SetForce(force.x, force.y);
        ball.SetPosition(mouseX, mouseY);

        CollidersDrawOnly();
    }else{
        CheckCollitions();
        ball.AddForces(0.1, 0.01);
    }

    //ball.SetColor(color (0,128,64,255));
    ball.CalculateStep();

    //print(scoreMultiplyer);
}


PVector AddForce(PVector v1, PVector v2){
    PVector force = new PVector(v1.x - v2.x, v1.y - v2.y);
    return force;
}

void CollidersDrawOnly(){
     for(int i = 0; i < colliders.length; i++){
        colliders[i].Draw(color(0, 0, 255, 255));
    }
}
void CheckCollitions(){

    //Check ball aginst all colliders
    PVector hitNormal = new PVector(0,0);
    PVector hitPoint = new PVector(0,0);
    PVector cutTrough = new PVector(0,0);

    boolean hits = false;
    for(int i = 0; i < colliders.length; i++){
        if(colliders[i].CircleCheckIfCollision(ball)){
            hitNormal.add(colliders[i].GetHitNormal());
            hitPoint.add(colliders[i].GetHitPoint());
            cutTrough.add(colliders[i].GetCut());

            hits = true;
        }

         colliders[i].Draw(color(0, 0, 255, 255));
    }

    if(hits){
        hitNormal = hitNormal.normalize();
        stroke(255);
        line(ball.GetPositionX(), ball.GetPositionY(), ball.GetPositionX() + hitNormal.x *50, ball.GetPositionY() + hitNormal.y *50);
        ball.Collided(hitNormal, hitPoint, cutTrough);

        scoreMultiplyer++;
    }
}