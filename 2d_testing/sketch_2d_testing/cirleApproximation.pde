
int steps = 3;
float radius = 1f;
Vector3[] vecs;

void setupCircleApproximation(){
  vecs = new Vector3[(steps+1) * 3];
  generateCircleVertices();
}
void drawCircleApproximation(){
  fill(0, 255, 0, 255);
  stroke(0,255,0, 0);
  
  for(int a=0; a <= steps; ++a){
    Vector3 v0 = vecs[a*3 + 0];
    Vector3 v1 = vecs[a*3 + 1];
    Vector3 v2 = vecs[a*3 + 2];
    
    triangle(v0.x, v0.y,
             v1.x, v1.y,
             v2.x, v2.y);
  }
}
void generateCircleVertices(){
  Vector3 lastVec = new Vector3(1f,0f,0f);
  float stepSize = (float)((Math.PI * 2f) / (float)steps);
  Vector3 zeroVec = new Vector3(0f,0f,0f);
  
  for(int a=0; a <= steps; ++a){
    float radians = a * stepSize;
    Vector3 curVec = new Vector3( (float)(Math.cos(radians) * radius), (float)(Math.sin(radians) * radius) , 0);
    
    radians += 0.01;
    Vector3 curVec_ = new Vector3( (float)(Math.cos(radians) * radius), (float)(Math.sin(radians) * radius) , 0);
    
    vecs[a*3 + 0] = lastVec;
    vecs[a*3 + 1] = curVec_;
    vecs[a*3 + 2] = zeroVec;
    lastVec = curVec;
  }
  for(int i=0; i < vecs.length; ++i){
    System.out.printf("vecs[%s]: %s%n", i, vecs[i]);
  }
}
