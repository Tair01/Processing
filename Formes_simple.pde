PShape cone0;
float rotationSpeeds[] = {0.02, 0.03, 0.04, 0.05, 0.06, 0.07}; 
PShape[] hourGlassBases = new PShape[6]; 

void setup(){
  size(800, 800, P3D);
  cone0 = myCone(90, 13);
  
  for (int i = 0; i < 6; i++) {
    hourGlassBases[i] = createShape(RECT, -50, -200, 100, 100); 
    hourGlassBases[i].translate(160 * (i - 2), height / 2); 
    hourGlassBases[i].rotateX(PI / 4); 
  }
}

PShape myCone(float sideSize, int nbSide) {
  PShape shape0 = createShape();
  shape0.beginShape(TRIANGLE_FAN);
  shape0.fill(0, 0, 255); 
  shape0.stroke(0);
  shape0.vertex(0, 0, 0);
  for (int i = 0; i <= nbSide; i++) {
    shape0.vertex(sideSize/2 * cos(i * TWO_PI / nbSide),
                  sideSize/2 * sin(i * TWO_PI / nbSide),
                  sideSize);
  }
  shape0.endShape();
  return shape0;
}

void draw(){
  background(255);
  
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  ortho(-width/2, width/2, -height/2, height/2, cameraZ/10.0, cameraZ*10.0);
  
  translate(width/2, height/4);
  
  pushMatrix();
  rotateX(frameCount/50.0);
  fill(255, 128, 128);
  sphere(100);
  popMatrix();
  
  pushMatrix();
  translate(145,0);
  fill(0, 255, 128);
  rotateX(frameCount/-50.0);
  box(90);
  popMatrix();
 
  translate(-145,-45);
  pyramide(90);
  translate(0,175);
  pyramide(90);
  
  for(int i = 0; i < 5; i++){
    pushMatrix();
    translate(-220 + i * 110, -100);
    hourGlass();
    popMatrix();
  }
  
  translate(-145,-180);
  hourGlass();
}

void pyramide(float taille) {
  float dTaille = taille / 2.0;
  float hauteur = taille;
  fill(0, 0, 255);
  rotateX(frameCount/-50.0);
  beginShape(TRIANGLES);
  vertex(-dTaille, 0, dTaille); 
  vertex(dTaille, 0, dTaille);  
  vertex(0, hauteur, 0);              
  
  vertex(-dTaille, 0, dTaille); 
  vertex(-dTaille, 0, -dTaille);  
  vertex(0, hauteur, 0);               
  
  vertex(-dTaille, 0, -dTaille); 
  vertex(dTaille, 0, -dTaille);  
  vertex(0, hauteur, 0);               
  
  vertex(dTaille, 0, -dTaille); 
  vertex(dTaille, 0, dTaille);  
  vertex(0, hauteur, 0);               
  
  endShape();
}

void hourGlass(){
  pushMatrix();
  translate(145, -45);
  shape(cone0);
  popMatrix();
  
  pushMatrix();
  translate(145, 45);
  rotateX(PI);
  shape(cone0);
  popMatrix();
}
