void drawRotationTesting(){
  int offset = 50;
  Vector vec = new Vector(offset, offset, offset);
  drawSphere(10, vec, new Vector(0f, 255f, 0f));
  
  Matrix rotationX = createRotationMatrix3DAngleX(rotationAngleX);
  Vector rotatedVecX = rotationX.dot(vec);
  drawSphere(10, rotatedVecX, new Vector(0f, 255f, 255f));
  
  Matrix rotationY = createRotationMatrix3DAngleY(rotationAngleX);
  Vector rotatedVecY = rotationY.dot(vec);
  drawSphere(10, rotatedVecY, new Vector(0f, 255f, 255f));
  
  Matrix rotationZ = createRotationMatrix3DAngleZ(rotationAngleX);
  Vector rotatedVecZ = rotationZ.dot(vec);
  drawSphere(10, rotatedVecZ, new Vector(0f, 255f, 255f));
  
  
  drawVector(arbitraryRotationAxis.setLengthButKeepDirection(vec.length()), 2f, new Vector(255f, 200f, 200f));
  
  Matrix arbRotationMatrix = getRotationMatrixOfArbitraryAxis(arbitraryRotationAxis, rotationAngleX);
  Vector arbitrarilyRotatedVector = arbRotationMatrix.dot(vec);
  drawSphere(10, arbitrarilyRotatedVector, new Vector(200f, 255f, 255f));
  
  
  //Matrix rotationAroundSelfMatrix = getRotationMatrixOfArbitraryAxis(vec, rotationAngleX);
  //Vector selfRotationVector = rotationAroundSelfMatrix.dot(vec);
  drawCube(20, vec, new Vector(200f, 255f, 255f), radians(rotationAngleX));
  
  drawVector(vec, 2f, new Vector(255f, 0f, 255f));


  float d_angleX = 2f;
  rotationAngleX = (rotationAngleX + d_angleX) % 360;
}
