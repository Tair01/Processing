PShape p;
PShader myShader;

void setup(){
  myShader = loadShader("myFragmentShader.glsl", "myVertexShader.glsl");
  size(800, 1200, P3D);
  p = createShape();
  p.beginShape(QUADS);
  float Rext = 150;
  float Rint = 50;
  float dA = PI/36;
  float re = 1.0;
  p.noStroke();
  for (float a=-8*PI; a<8*PI; a+=dA){
    for (float b=0; b<2*PI; b+=dA){
      p.fill(128+a*10, 128-a*10, 255-a*10);
      
      float R02 = Rext*(1+cos((a+0 )/16))/2;
      float R13 = Rext*(1+cos((a+dA)/16))/2;
      
      float Ri02 = Rint*cos((a+0 )/16);
      float Ri13 = Rint*cos((a+dA)/16);
      
      PVector  p0, p1, p2, p3 ;
      PVector p02 = new PVector(R02*cos(a),                    R02*sin(a),            a/PI*(Rint+Ri02)/2*re);
      p0 = PVector.add(p02, new PVector(Ri02*sin(b)*cos(a),    Ri02*sin(b)*sin(a),    Ri02*cos(b)));
      p2 = PVector.add(p02, new PVector(Ri02*sin(b+dA)*cos(a), Ri02*sin(b+dA)*sin(a), Ri02*cos(b+dA)));
      
      PVector p13 = new PVector(R13*cos(a+dA),                     R13*sin(a+dA),            (a+dA)/PI*(Rint+Ri13)/2*re);
      p1  = PVector.add(p13, new PVector(Ri13*sin(b)*cos(a+dA),    Ri13*sin(b)*sin(a+dA),    Ri13*cos(b)));
      p3  = PVector.add(p13, new PVector(Ri13*sin(b+dA)*cos(a+dA), Ri13*sin(b+dA)*sin(a+dA), Ri13*cos(b+dA)));
     
      PVector n0, n1, n2, n3;
      n0 = PVector.sub(p0,p02);
      n0.normalize();
      n1 = PVector.sub(p1,p13);
      n1.normalize();
      n2 = PVector.sub(p2,p02);
      n2.normalize();
      n3 = PVector.sub(p3,p13);
      n3.normalize();
      p.normal(n0.x, n0.y, n0.z);
      p.vertex(p0.x, p0.y, p0.z, (a)/(4.0*PI), 200*a+16*b);
      p.normal(n1.x, n1.y, n1.z);
      p.vertex(p1.x, p1.y, p1.z, (a+dA)/(4.0*PI), 200*(a+dA)+16*b);
      p.normal(n3.x, n3.y, n3.z);
      p.vertex(p3.x, p3.y, p3.z, (a+dA)/(4.0*PI), 200*(a+dA)+16*(b+dA));
      p.normal(n2.x, n2.y, n2.z);
      p.vertex(p2.x, p2.y, p2.z, (a)/(4.0*PI), 200*a+16*(b+dA));
    }
  }
  p.endShape();  
}


void draw(){
  shader(myShader);
  background(192);
  myShader.set("fraction", 2.5); 
  myShader.set("deform", 100*cos(frameCount/100.0)*cos(frameCount/100.0)); 
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  
  directionalLight(204, 204, 204, -dirX, -dirY, -1);

  translate (width/2, height/2);
  rotateX(PI/2-frameCount*PI/1500);
  rotateZ(frameCount*PI/1000);
 
  shape(p);
}

void keyPressed(){
  noLoop();
}
