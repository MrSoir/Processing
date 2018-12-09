class Rect2{
  float xmin, xmax,
        ymin, ymax;
  Rect2(){};
  Rect2(float xmin, float xmax, float ymin, float ymax){
    this.xmin = xmin;
    this.xmax = xmax;
    this.ymin = ymin;
    this.ymax = ymax;
  }
}


class Rect3{  
  float xmin, xmax,
        ymin, ymax,
        zmin, zmax;
  Rect3(){};
  Rect3(float xmin, float xmax, float ymin, float ymax, float zmin, float zmax){
    this.xmin = xmin;
    this.xmax = xmax;
    this.ymin = ymin;
    this.ymax = ymax;
    this.zmin = zmin;
    this.zmax = zmax;
  }
}
