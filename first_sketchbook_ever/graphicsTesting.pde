import java.util.List;

//_____________________________________________________________
// put global variables here:

List<List<Vector>> polygon_mesh;
float scaleFactor = 6f;
float scaleCounter = 0f;

float rotationAngle = 0f;

float translationX = 100f;
float translationAngle = 0f;

//_____________________________________________________________

void setup_GrahpicsTesting(){
  polygon_mesh = loadSTL_ASCII("/home/bigdaddy/workspace_processing/sphere.stl");
  polygon_mesh = scalePolygonMesh(polygon_mesh, 3); // mash um faktor 10 skalieren, da sonst zu klein
  print_polygon_mesh( polygon_mesh );
}

void drawSphere3D_Testing(){
  //polygon_mesh = scalePolygonMesh(polygon_mesh, 10); // wirkt direkt auf die zu skalierenden vektoren ein, ohne eine skalierungs-matrix zu verwenden 
                                                       // (schneller als skalierungsmatrix, aber weniger einfach das dann zu handhaben z.B. skalierung 
                                                       // mit anderern transformationen zu kombinieren!)
                                                       
  float curScaleFactor = getCurScaleFactor();
  Matrix scaleMatrix = getScaleMatrix(new Vector(curScaleFactor, curScaleFactor, curScaleFactor));
  List<List<Vector>> scaled_poly_mesh = applyTransformationMatix_to_PolygonMesh(scaleMatrix, this.polygon_mesh);
  
  Matrix rotationMatrixX = createRotationMatrix3DAngleX( getRotationAngle() );
  List<List<Vector>> rotated_poly_mesh = applyTransformationMatix_to_PolygonMesh(rotationMatrixX, scaled_poly_mesh);
  
  float translationX = 100f,
        translationY = 0f,
        translationZ = 0f;
        
  drawEllipse(translationX*2f, new Vector(0f,0f,0f));
  stroke(0, 255, 0);
  fill(0, 255, 0);
  Vector translationVector = new Vector(translationX, translationY, translationZ);
  Matrix translationRotationMatrix = createRotationMatrix3DAngleZ( getTranslationAngle() );
  translationVector = translationRotationMatrix.dot(translationVector);
  
  List<List<Vector>> translated_poly_mesh = applyTranslation_to_PolygonMesh(translationVector, rotated_poly_mesh);
  draw_polygon_mesh( translated_poly_mesh );
  
  drawSphere(20, translationVector, new Vector(255, 200, 200));
}

float getRotationAngle(){
  float curRotAngl = rotationAngle;
  rotationAngle = (rotationAngle + 0.5) % 360;
  return curRotAngl;
}
float getTranslationAngle(){
  float curTransAngl = translationAngle;
  translationAngle = (translationAngle + 0.1f) % 360;
  return curTransAngl;
}


float getCurScaleFactor(){
  float x = scaleCounter;
  float curScaleFctr = (sin(x +3./2. *PI) +1) /4. *scaleFactor +1;
  
  scaleCounter = (scaleCounter + 0.1f) % (PI * 2f);
    
  return curScaleFctr;
}

List<List<Vector>> applyTranslation_to_PolygonMesh(Vector translationVector, List<List<Vector>> polygon_mesh){
  List<List<Vector>> transformed_polygon_mesh = new ArrayList<List<Vector>>(polygon_mesh.size());
  for(List<Vector> triangle: polygon_mesh){
    List<Vector> transformed_triangle = new ArrayList<Vector>(3);
    for(Vector vector: triangle){
      transformed_triangle.add( vector.add(translationVector) );
    }
    transformed_polygon_mesh.add( transformed_triangle );
  }
  
  return transformed_polygon_mesh;
}

List<List<Vector>> applyTransformationMatix_to_PolygonMesh(Matrix transformationMatrix, List<List<Vector>> polygon_mesh){
  List<List<Vector>> transformed_polygon_mesh = new ArrayList<List<Vector>>(polygon_mesh.size());
  for(List<Vector> triangle: polygon_mesh){
    List<Vector> transformed_triangle = new ArrayList<Vector>(3);
    for(Vector vector: triangle){
      transformed_triangle.add( transformationMatrix.dot(vector) );
    }
    transformed_polygon_mesh.add( transformed_triangle );
  }
  
  return transformed_polygon_mesh;
}

List<List<Vector>> scalePolygonMesh(List<List<Vector>> polygon_mesh, float scaleFactor){
  List<List<Vector>> scaled_polygon_mesh = new ArrayList<List<Vector>>(polygon_mesh.size());
  for(List<Vector> triangle: polygon_mesh){
    List<Vector> scaled_triangle = new ArrayList<Vector>(3);
    for(Vector vector: triangle){
      scaled_triangle.add( vector.multiply( scaleFactor ) );
    }
    scaled_polygon_mesh.add( scaled_triangle );
  }
  
  return scaled_polygon_mesh;
}

void draw_triangle(List<Vector> triangle){
  pushMatrix();
  noStroke();
  beginShape();
  
  Vector vecI   = triangle.get(0);
  Vector vecII  = triangle.get(1);
  Vector vecIII = triangle.get(2);

  vertex(vecI.x()  , vecI.y()  , vecI.z()  );
  vertex(vecII.x() , vecII.y() , vecII.z() );
  vertex(vecIII.x(), vecIII.y(), vecIII.z());

  
  endShape();
  popMatrix();
}

void print_polygon_mesh(List<List<Vector>> polygon_mesh){
  int i=0;
  for(List<Vector> triangle: polygon_mesh){
    println("    triangle: " + i++ + " :");
    for(Vector vertex: triangle){
      vertex.print_short();
    }
  }
}

void draw_polygon_mesh(List<List<Vector>> polygon_mesh){
  for(List<Vector> triangle: polygon_mesh){
    draw_triangle(triangle);
  }
}

List<List<Vector>> loadSTL_ASCII(String filepath){
  List<List<Vector>> polygon_mesh = new ArrayList<List<Vector>>();
  
  String[] lines = loadStrings(filepath);
  println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) {
    String line = lines[i].trim();
    if(line.startsWith("vertex")){
      
      List<Vector> currentTriangle = new ArrayList<Vector>(3);
      currentTriangle.add(parse_STL_line(lines[i+0]));
      currentTriangle.add(parse_STL_line(lines[i+1]));
      currentTriangle.add(parse_STL_line(lines[i+2]));

      polygon_mesh.add(currentTriangle);
      
      i += 2;
    }
  }
  
  return polygon_mesh;
}

Vector parse_STL_line(String line){
  // line sieht so aus: 'vertex 3.618000 -2.628600 -2.236075'
  // -> erster index daher bei 1: line.split(" ")[0] == 'vertex'
  Vector vec = new Vector(3);
  String[] values = line.trim().split("\\s+"); // "\\s+" <- regex: split all whitespace
  
  vec.x(Float.parseFloat(values[1]));
  vec.y(Float.parseFloat(values[2]));
  vec.z(Float.parseFloat(values[3]));

  return vec;
}

void printStringArray(String[] strs){
  StringBuilder strB = new StringBuilder();
  for(int i=0; i < strs.length; i++){
    strB.append("'" + strs[i] + (i == strs.length-1 ? "'" : "'  "));
  }
  println(strB);
}
