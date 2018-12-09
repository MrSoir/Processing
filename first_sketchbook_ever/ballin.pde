Ball3[] balls;
Rect3 court;

void setupBallin() {  
  float courtRect = 80.0f;
  
  balls = new Ball3[10];
  court = new Rect3(-courtRect,courtRect, -courtRect, courtRect, -courtRect, courtRect);
  
  background(0);
  fill(255);
  
  frameRate(90);
  
  generateRandomBalls();
}

void generateRandomBalls(){
  float minMass = 1.0f, maxMass = 5.0f;
  float maxVel = 40.0f;
  
  for(int i=0; i < balls.length; i++){
    float mass = random(minMass, maxMass);
    float radius =  mass * 4.0;
    balls[i] = new Ball3(new Vector3(random(court.xmin + radius, court.xmax - radius),  // positionX
                                     random(court.ymin + radius, court.ymax - radius),  // positionY
                                     random(court.zmin + radius, court.zmax - radius)), // positionZ
                                     
                         new Vector3(random(-maxVel, maxVel),                           // velocityX
                                     random(-maxVel, maxVel),                           // velocityY
                                     random(-maxVel, maxVel)),                          // velocityZ
                                     
                         radius,                                                        // radius
                         mass);                                                         // mass
  }
}

float lastTime = -1.0f;
void drawBallin() {  
  clear();
  
  lights();
  //spotLight(51, 102, 126, 80, 20, 40, -1, 0, 0, PI/2, 0);
  //spotLight(51, 102, 126, 80, 20, 40, 0, -1, 0, PI/2, 0);
  
  float curTime = (float)millis() / 1000.0; // in seconds!
  
  float dt = lastTime >= 0 ? curTime-lastTime :  0.0f;
  
  lastTime = curTime;
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  
  for(int i=0; i < balls.length; i++){
    Ball3 ball = balls[i];
    ball.move(dt, court);
  }
  for(int i=0; i < balls.length; i++){
    Ball3 ball = balls[i];
    boolean iscolliding = false;
    for(int j=i+1; j < balls.length; j++){
      if(i != j){
        Ball3 ballOther = balls[j];
        boolean collission = ball.collission(ballOther);
        if(collission)
          iscolliding = collission;
      }
    }
    ColorBD col = iscolliding ? new ColorBD(255, 0, 0, 255) :
                                new ColorBD(255, 255, 255, 255);
    drawSphere(ball.radius, ball.pos, col);
  }
  
  drawCube(court.xmax-court.xmin, new Vector(0.0f, 0.0f, 0.0f), new Vector(255f, 255f, 255f, 20f), true);
  println();
}

void drawSphere(float radius, Vector3 vec, ColorBD col){
  drawSphere(radius, new Vector(vec.x, vec.y, vec.z), new Vector(col.r, col.g, col.b, col.a));
}
void drawEllipse(float radius, Vector2 center, ColorBD col)
{
  fill(col.r, col.g, col.b, col.a);
  ellipse(center.x, center.y, radius, radius);
}
