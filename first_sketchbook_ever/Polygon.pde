
class Polygon{
  public Vector3 vec1, vec2, vec3;
  public Polygon(Vector3 vec1, Vector3 vec2, Vector3 vec3)
  {
    this.vec1 = vec1;
    this.vec2 = vec2;
    this.vec3 = vec3;
  }
  
  void drawPolygon()
  {
      drawLine(vec1, vec2);
      drawLine(vec1, vec3);
      drawLine(vec2, vec3);
  }
  void drawPolygon(ColorBD col)
  {
    stroke(col.r, col.g, col.b);
    drawLine(vec1, vec2);
    drawLine(vec1, vec3);
    drawLine(vec2, vec3);
  }
  String toString(){
    return String.format("Polygon[(x: %s  y: %s  z: %s), (x: %s  y: %s  z: %s), (x: %s  y: %s  z: %s)]", 
                    vec1.x, vec1.y, vec1.z,
                    vec2.x, vec2.y, vec2.z,
                    vec3.x, vec3.y, vec3.z);
  }
    String toArrString(){
    return String.format("  [%s, %s,  %s],\n  [%s, %s, %s],\n  [%s, %s, %s],", 
                    vec1.x, vec1.y, vec1.z,
                    vec2.x, vec2.y, vec2.z,
                    vec3.x, vec3.y, vec3.z);
  }
}
