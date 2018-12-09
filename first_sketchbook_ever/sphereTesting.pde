// mit folgendem Algorithmus werden die punkte berechnet, die eine sphere approximieren.
// die relevanten Werte hierfuer sind:
double radius = 1.0;
double m = 5.0; // anzahl latitudes
double n = 5.0; // anzahl longitudes
Polygon[] polygons; // schlussendlich werden die polygone erstellt und in polygons gespeichert. es sind genau: (m-1) * n * 4

Vector3[][] vecs;

void setupSphereTesting()
{
  vecs = new Vector3[(int)m][(int)n];
  polygons = new Polygon[(int)((m-1)*n*4)]; // wieso (m-1)*n*4? kein plan, selbst ausm arsch gezogen und funktioniert halt...
  initVecs();
  genPolygons();
  System.out.printf("vecs.length: %s%n", vecs.length);
  System.out.printf("vecs[0].length: %s%n", vecs[0].length);
  System.out.printf("polygons.length: %s%n", polygons.length);
  for(int i=0; i < 10; ++i){
    System.out.printf("%s%n", polygons[i].toArrString());
  }
}

void drawSphereTesting(){
  for(int i=0; i < polygons.length; ++i)
  {
    ColorBD col = (i % 2) == 0 ?
                  new ColorBD(255, 0, 0, 255) :
                  new ColorBD(0, 0, 255, 255);
    polygons[i].drawPolygon(col);
  }
}

Vector3 flipVectorY(Vector3 vec)
{
  return new Vector3(vec.x,
                     vec.y * -1.0f,
                     vec.z);
}

void genPolygons()
{
  int cntr = 0;
  
  for(int a=0; a < 2; ++a)
  {    
    for(int i=0; i < vecs.length-1; ++i)
    {
      int rowSuccessor = i+1;
      
      for(int j=0; j < vecs[i].length; ++j)
      {
        int colSuccessor = j==vecs[i].length-1 ? 0 : j+1;
        
        Vector3 vec1 = vecs[i][j];
        Vector3 vec2 = vecs[i][colSuccessor];
        
        Vector3 vec3 = vecs[rowSuccessor][j];
        Vector3 vec4 = vecs[rowSuccessor][colSuccessor];
        
        if(a == 0)
        {
          vec1 = flipVectorY(vec1);
          vec2 = flipVectorY(vec2);
          vec3 = flipVectorY(vec3);
          vec4 = flipVectorY(vec4);
        }
        
        Polygon poly1 = new Polygon(vec1, vec2, vec4);
        Polygon poly2 = new Polygon(vec1, vec3, vec4);
        System.out.printf("vec1: %s%n", vec1);
        System.out.printf("vec2: %s%n", vec2);
        System.out.printf("vec3: %s%n", vec3);
        System.out.printf("vec4: %s%n", vec4);
        System.out.printf("poly1: %s%npoly2: %s%n%n", poly1, poly2);
        
        polygons[cntr++] = poly1;
        polygons[cntr++] = poly2;
      }
    }
  }
}

void initVecs()
{
  double heightAngle = 90.0 / m;
  
  for(int i=0; i < m-1; ++i)
  {        
    double i_ = i;
    double y = Math.sin(Math.toRadians(heightAngle * i_)) * radius; //h * i_;
    double angleDeg = Math.toDegrees(Math.asin(y/radius));
    double latitudeRadius = Math.cos(Math.toRadians(angleDeg)) * radius;
        
    double n_ = (double)n;
    double sliceAngle = 360.0 / n_;
    
    for(int j=0; j < n; ++j){
      double curSliceAngle = sliceAngle * (double)j;
      double x = getX(curSliceAngle, latitudeRadius);
      double z = getZ(curSliceAngle, latitudeRadius);
      System.out.printf("x: %s  y: %s  z: %s%n", x, y, z);
              
      Vector3 vec = new Vector3(x, y, z);
      vecs[i][j] = vec;
    }
  }
    
  Vector3 pole = new Vector3(0.0, radius, 0.0);
  point(0f, pole.y ,0f);
  int poleId = vecs.length-1;
  for(int i=0; i < n; ++i)
    vecs[poleId][i] = pole;
    
  for(int i=0; i < vecs.length; ++i){
    for(int j=0; j < vecs[i].length; ++j){
      System.out.printf("vec[%s][%s]: %s%n", i, j, vecs[i][j]);
    }
  }
}

void drawPoint(Vector3 vec)
{
  point(vec.x, vec.y, vec.z);
}
void drawLine(Vector3 vec1, Vector3 vec2)
{
  line(vec1.x, vec1.y, vec1.z,
       vec2.x, vec2.y, vec2.z);
}

double getX(double angle, double latitudeRadius)
{
  double x = Math.sin(Math.toRadians(angle)) * latitudeRadius;
  return x;
}
double getZ(double angle, double latitudeRadius)
{
  double z = Math.cos(Math.toRadians(angle)) * latitudeRadius;
  return z;
}

double cos(double x)
{
  return Math.cos(Math.toRadians(x));
}
double sin(double x)
{
  return Math.sin(Math.toRadians(x));
}
