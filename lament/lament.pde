float angle=0;
PShader ascii;
PShape s;

void setup() {
  size(600, 600, P3D);
  background(0);
  ascii = loadShader("ascii.glsl");
  ascii.set("iResolution", float(width), float(height));
  s = loadShape("heart.obj");
}

void draw() {
  background(0);
  
  //Lighting
  directionalLight(100, 100, 0, 0, 1, 0);
  directionalLight(100, 100, 0, 0, -1, 0);
  ambientLight(200, 100, 0);
  
  //Background Noise
  for(int x = 0; x < width+8; x += 8) {
    for(int y = 0; y < height+8; y += 8) {
      float n = noise(x * 0.003, y * 0.003, frameCount * 0.003);
      pushMatrix();
      translate(x, y);
      if(n>.5) {
        int weight = (int) Math.pow(n+1,11)-30;
        if(weight>245) {
          weight = 205;
        }
        point(0,0,0);
        strokeWeight(10);
        stroke(weight/1.3,weight/2,0);
      }
      popMatrix();
    }
  }
  
  //Heart
  pushMatrix();
  translate(width/2, height/2,50);  
  //float sc = (float) Math.pow(sin(angle*4), 63) * sin(angle*4+1.5)*8;  
  //scale(4+sc/2);
  
  scale(4);
  
  rotateY(angle);
  rotateX(PI/3);
  angle+=.01;
  shape(s, 0, 0);
  color c = color(255,255,255);
  s.setFill(c);
  popMatrix();
  
  filter(ascii);

}
