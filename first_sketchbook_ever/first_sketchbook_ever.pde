import peasy.PeasyCam;
import java.lang.IllegalArgumentException;

//----------------------------------------------------------+
// define all global variables here:

PeasyCam cam;

int window_width = 640, window_height = 480;

Vector arbitraryRotationAxis = (new Vector(random(0, 20), random(0, 20), random(0,20))).normalize();


float rotationAngleX = 0f;
float rotationAngleY = 0f;
float rotationAngleZ = 0f;

float centX = window_width/2;
float centY = window_height/2;


//----------------------------------------------------------+

public void settings() {
  size(window_width, window_height, P3D);
}


public void setup() {
  // wenn cam==PeasyCam aktiv ist, dann NICHT translate(centX, centY). wenn cam auskommentiert ist, dann UNBEDINGT translate(centX, centY)!
  cam = new PeasyCam(this, 400);
  //translate(centX, centY);
  
  surface.setResizable(true);
    
  //setup_GrahpicsTesting();
  //setupBallin();
  setupSphereTesting();
}

float rotX=0f, rotY=0f, rotZ=0f;

public void draw() {
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  rotY = (rotY+0.01) % 360;
  
  //strokeWeight(1 / 10f);
  
  // wichtig: lights() und das zeichnen allg. erst NACH background() -> sonst ueberzeichnet background() alles wieder...
  background(0);
  lights(); 
  
  //scale(1.5f);
  
  drawAxis();
  
  //drawRotationTesting();
  //drawSphere3D_Testing();
  //drawVector_calc_Testing();
  //drawBallin();
  drawSphereTesting();
}


void drawVector(Vector vec, float strokeWeight, Vector col){
  pushMatrix();
  stroke(col.r(), col.g(), col.b());
  strokeWeight(strokeWeight);
  line(0,0,0, vec.x(), vec.y(), vec.z());
  popMatrix();
}
void drawSphere(float radius, Vector position, Vector col){
  drawSphere(radius, position, col, 0f);
}
void drawSphere(float radius, Vector position, Vector col, float rotation){
  pushMatrix();
  translate(position.x(), position.y(), position.z());
  rotate(rotation);
  fill(col.x(), col.y(), col.z());
  stroke(0, 0, 0, 150);
  sphere(radius);
  popMatrix();
}
void drawCube(float edge, Vector position, Vector col, boolean fill){
  drawCube(edge, position, col, 0.0f, fill);
}
void drawCube(float edge, Vector position, Vector col){
  drawCube(edge, position, col, 0.0f);
}
void drawCube(float edge, Vector position, Vector col, float rotation){
  drawCube(edge, position, col, rotation, true);
}
void drawCube(float edge, Vector position, Vector col, float rotation, boolean fill){
  pushMatrix();
  translate(position.x(), position.y(), position.z());
  rotate(rotation);
  
  float alpha = col.dims() >= 4 ? col.a() : 255f;

  if(fill){
    fill(col.r(), col.g(), col.b(), alpha);
    stroke(0.0f, 0.0f, 0.0f, 0.0f);
  }else{
    noFill();
    stroke(col.r(), col.g(), col.b(), alpha);
  }
  box(edge);
  popMatrix();
}
void drawEllipse(float radius, Vector center){
  pushMatrix();
  noFill();
  stroke(255, 0, 0);
  strokeWeight(4);
  ellipseMode(CENTER);
  ellipse(center.x(), center.y(), radius, radius);
  popMatrix();

}

void drawAxis(){
  int lineWidth = 200;
  float strokeWeight = 0.5f;
  
  // x: red
  pushMatrix();
  stroke(0,255,0);
  strokeWeight(strokeWeight);
  line(0,0,0, lineWidth,0,0);
  popMatrix();
  
  // y: pink
  pushMatrix();
  stroke(255, 0, 255);
  strokeWeight(strokeWeight);
  line(0,0,0, 0,lineWidth,0);
  popMatrix();
  
  // z: blue
  pushMatrix();
  stroke(0, 0, 255);
  strokeWeight(strokeWeight);
  line(0,0,0, 0,0,lineWidth);
  popMatrix();
}










//-----------------------------------------------------------------------
// matrix und vektoren-berechnungen:

class Vector{
  float[] vals;
  Vector(float x, float y){
    vals = new float[2];
    vals[0] = x;
    vals[1] = y;
  }
  Vector(float x, float y, float z){
    vals = new float[3];
    vals[0] = x;
    vals[1] = y;
    vals[2] = z;
  }
  Vector(float x, float y, float z, float w){
    vals = new float[4];
    vals[0] = x;
    vals[1] = y;
    vals[2] = z;
    vals[3] = w;
  }
  Vector(float[] values){
    vals = values; 
  }
  Vector(int dim){
    vals = new float[dim];
  }
  
  int dims(){return vals.length;}
  
  float x(){return vals[0];}
  float y(){return vals[1];}
  float z(){return vals[2];}
  void x(float val){vals[0] = val;}
  void y(float val){vals[1] = val;}
  void z(float val){vals[2] = val;}

  
  float r(){return vals[0];}
  float g(){return vals[1];}
  float b(){return vals[2];}
  float a(){return vals[3];}
  void r(float val){vals[0] = val;}
  void g(float val){vals[1] = val;}
  void b(float val){vals[2] = val;}
  void a(float val){vals[3] = val;}

  float get(int id){return vals[id];}
  void set(int id, float val){vals[id] = val;}
  
  Vector cross(Vector vec){
    // cross macht nur fuer 3d-vectoren sinn:
    Vector retVec = new Vector(3);
    retVec.vals[0] = this.vals[1] * vec.vals[2] - this.vals[2]*vec.vals[1];
    retVec.vals[1] = this.vals[2] * vec.vals[0] - this.vals[0]*vec.vals[2];
    retVec.vals[2] = this.vals[0] * vec.vals[1] - this.vals[1]*vec.vals[0];
    
    return retVec;
  }
  
  Vector divide(Vector vec){
    Vector retVec = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      retVec.vals[row] = vals[row] / vec.vals[row];
    }
    return retVec;
  }
  Vector divide(float divisor){
    Vector dividedVector = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      dividedVector.vals[row] = vals[row] / divisor;
    }
    return dividedVector;
  }
  Vector multiply(Vector vec){
    Vector retVec = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      retVec.vals[row] = vals[row] * vec.vals[row];
    }
    return retVec;
  }
  Vector multiply(float multiplicator){
    Vector multiplyVector = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      multiplyVector.vals[row] = vals[row] * multiplicator;
    }
    return multiplyVector;
  }
  Vector add(Vector vec){
    Vector retVec = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      retVec.vals[row] = vals[row] + vec.vals[row];
    }
    return retVec;
  }
  Vector add(float additor){
    Vector additorVector = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      additorVector.vals[row] = vals[row] + additor;
    }
    return additorVector;
  }
  Vector subtract(Vector vec){
    Vector retVec = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      retVec.vals[row] = vals[row] - vec.vals[row];
    }
    return retVec;
  }
  Vector subtract(float subtractor){
    Vector subtractedVector = new Vector(this.vals.length);
    for(int row=0; row < vals.length; row++){
      subtractedVector.vals[row] = vals[row] + subtractor;
    }
    return subtractedVector;
  }
  
  float length(){
    float length = 0f;
    for(int row=0; row < vals.length; row++){
      float rowVal = vals[row];
      length += rowVal * rowVal;
    }
    return sqrt(length);
  }
  
  Vector normalize(){
    float length = length();

    Vector vec = new Vector(vals.length);    
    for(int row=0; row < vals.length; row++){
      vec.vals[row] = vals[row] / length;
    }
    return vec;
  }
  Vector setLengthButKeepDirection(float targetLength){
    // ist dasselbe wie: this.normalize().multiply(targetlength);
    float length = length();
    
    Vector vec = new Vector(vals.length);    
    for(int row=0; row < vals.length; row++){
      vec.vals[row] = vals[row] / length * targetLength;
    }
    return vec;
  }
  
  void draw(float diameter){
    if(vals.length == 2){
      ellipse(vals[0], vals[1], diameter, diameter);
    }
  }  
  void print(){
    (new Matrix(this)).print();
  }
  void print_short(){
    StringBuilder strB = new StringBuilder("( ");
    for(int i=0; i < vals.length; i++){
      strB.append(vals[i] + (i == vals.length-1 ? "" : "  "));
    }
    strB.append(" )");
    println(strB);
  }
}






class Matrix{
  final int dimX, dimY;
  float[][] vals;
  Matrix(int rowCount, int colCount){
    vals = new float[rowCount][colCount];  
    dimX = rowCount;
    dimY = colCount;
  }
  Matrix( float I,   float II,   float III,
          float IV,  float V,    float VI,
          float VII, float VIII, float IX){
    dimY = 3;
    dimX = 3;
    vals = new float[3][3];
    vals[0][0] = I;
    vals[0][1] = II;
    vals[0][2] = III;
    vals[1][0] = IV;
    vals[1][1] = V;
    vals[1][2] = VI;
    vals[2][0] = VII;
    vals[2][1] = VIII;
    vals[2][2] = IX;
  }
  Matrix( float I,     float II,   float III,  float IV, 
          float V,     float VI,   float VII,  float VIII,
          float IX,    float X,    float XI,   float XII,
          float XIII,  float XIV,  float XV,   float XVI){
    dimY = 4;
    dimX = 4;
    vals = new float[4][4];
    vals[0][0] = I;
    vals[0][1] = II;
    vals[0][2] = III;
    vals[0][3] = IV;
    vals[1][0] = V;
    vals[1][1] = VI;
    vals[1][2] = VII;
    vals[1][3] = VIII;
    vals[2][0] = IX;
    vals[2][1] = X;
    vals[2][2] = XI;
    vals[2][3] = XII;
    vals[3][0] = XIII;
    vals[3][1] = XIV;
    vals[3][2] = XV;
    vals[3][3] = XVI;
  }
  Matrix( float I,   float II,   
          float III, float IV){
    dimY = 2;
    dimX = 2;
    vals = new float[2][2];
    vals[0][0] = I;
    vals[0][1] = II;
    vals[1][0] = III;
    vals[1][1] = IV;
  }
  Matrix(float I){
    dimY = 1;
    dimX = 1;
    vals = new float[1][1];
    vals[0][0] = I;
  }
  Matrix(float[][] vals){
    this.vals = vals;
    dimX = vals.length;
    dimY = vals[0].length;
  }
  Matrix(Vector vec){
    vals = new float[vec.vals.length][1];
    for(int row=0; row < vec.vals.length; row++){
      vals[row][0] = vec.vals[row];
    }
    dimX = 1;
    dimY = vec.vals.length;
  }
  
  Vector dot(Vector vec){
    Vector retVal = new Vector(dimY);
    for (int row=0; row < dimX; row++){
      float sum = 0f;
        for(int col=0; col < dimY; col++){
          sum += vals[row][col] * vec.get(col);
        }
        retVal.set(row, sum);
    }
    return retVal;
  }
  Matrix dot(Matrix mat){
    Matrix retVal = new Matrix(vals[0].length, mat.rows());
    for(int x=0; x < retVal.vals.length; x++){
      for(int y=0; y < retVal.vals[x].length; y++){
        float curValue = 0f;
        for(int id=0; id < mat.vals.length; id++){
          curValue += this.vals[x][id] * mat.vals[id][y]; 
        }
        retVal.vals[x][y] = curValue;
      }
    }
    return retVal;
  }
  
  Matrix combine2RotationMatrices(Matrix mat){
    Matrix combinedRotMat = new Matrix(dimX, dimY);
    for(int row=0; row < dimY; row++){
      for(int col=0; col < dimX; col++){
        combinedRotMat.vals[row][col] = this.vals[row][col] * mat.vals[row][col];
      }
    }
    return combinedRotMat;
  }
  
  float get(int rowId, int colId){return vals[rowId][colId];}
  void set(int rowId, int colId, float value){vals[rowId][colId] = value;}
  
  int rows(){return vals.length;}
  int cols(){return vals[0].length;}
  
  Vector row(int rowId){return new Vector(vals[rowId]);}
  
  Vector column(int colId){
    Vector vec = new Vector(vals[0].length);
    for(int row=0; row < dimY; row++){
      vec.set(row, vals[row][colId]);
    }
    return vec;
  }
  
  void print(){
    println("--------------------");
    for(int row=0; row < dimY; row++){
      StringBuilder curRowStr = new StringBuilder("| ");
      for(int col=0; col < dimX; col++){
          curRowStr.append(vals[row][col] + (col == dimX-1 ? "" : "  ") );
      }
      curRowStr.append(" |");
      println(curRowStr);
    }
    println("--------------------");
  }
}

Matrix createRotationMatrix2DAngle(float angle){
  float radians = radians(angle);
  return new Matrix(cos(radians), -sin(radians),
                    sin(radians), cos(radians));
}
Matrix createRotationMatrix2DRadians(float radians){
  return new Matrix(cos(radians), -sin(radians),
                    sin(radians), cos(radians));
}

Matrix createRotationMatrix3DAngleX(float angle){
  float radians = radians(angle);
  return new Matrix(1f,   0f,             0f,
                    0f,   cos(radians),   -sin(radians),
                    0f,   sin(radians),   cos(radians));
}
Matrix createRotationMatrix3DAngleY(float angle){
  float radians = radians(angle);
  return new Matrix(cos(radians),   0f,              sin(radians),
                    0f,             1f,              0f,
                    -sin(radians),  0f,              cos(radians));
}
Matrix createRotationMatrix3DAngleZ(float angle){
  float radians = radians(angle);
  return new Matrix(cos(radians),   -sin(radians),    0f,
                    sin(radians),   cos(radians),     0f,
                    0f,             0f,               1f);
}

Matrix getRotationMatrixOfArbitraryAxis(Vector axis, float angle){
  float radians = radians(angle);
  float rcos = cos(radians);
  float rsin = sin(radians);
  
  float u = axis.x();
  float v = axis.y();
  float w = axis.z();
  
  Matrix rotationMatrix = new Matrix(3,3);
  rotationMatrix.vals[0][0] =       rcos + u*u * (1-rcos);
  rotationMatrix.vals[1][0] =   w * rsin + v*u * (1-rcos);
  rotationMatrix.vals[2][0] =  -v * rsin + w*u * (1-rcos);
  rotationMatrix.vals[0][1] =  -w * rsin + u*v * (1-rcos);
  rotationMatrix.vals[1][1] =       rcos + v*v * (1-rcos);
  rotationMatrix.vals[2][1] =   u * rsin + w*v * (1-rcos);
  rotationMatrix.vals[0][2] =   v * rsin + u*w * (1-rcos);
  rotationMatrix.vals[1][2] =  -u * rsin + v*w * (1-rcos);
  rotationMatrix.vals[2][2] =       rcos + w*w * (1-rcos);

  return rotationMatrix;
}

Matrix getScaleMatrix(Vector scaleFactors){
  float scaleX = scaleFactors.x();
  float scaleY = scaleFactors.y();
  if(scaleFactors.vals.length == 0){
    return new Matrix(scaleX,      0f,
                          0f,  scaleY);
  }else{
    float scaleZ = scaleFactors.z();
    
    return new Matrix(scaleX,      0f,      0f,
                      0f    ,  scaleY,      0f,
                      0f    ,      0f,  scaleZ);
  }
}

Matrix getTranslationMatrix(Vector translationFactors){
  float transX = translationFactors.x();
  float transY = translationFactors.y();
  if(translationFactors.vals.length == 0){
    return new Matrix(transX,      0f,
                          0f,  transY);
  }else{
    float transZ = translationFactors.z();
    
    return new Matrix(1f,      0f,      0f,     transX,
                      0f,      1f,      0f,     transY,
                      0f,      0f,      1f,     transZ,
                      0f,      0f,      0f,         1f);
  }
}
Vector translateVector(Vector sourceVec, Vector translationFactors){
  Matrix translationMatrix = getTranslationMatrix(translationFactors);
  Vector adjustedVector = new Vector(sourceVec.x(), sourceVec.y(), sourceVec.z(), 1f);
  
  Vector translatedVec = translationMatrix.dot(adjustedVector);
  return new Vector(translatedVec.x(), translatedVec.y(), translatedVec.z());
}
