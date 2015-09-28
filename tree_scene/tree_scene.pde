int day_cycle;
boolean moon = true;
Tree test;
void setup() {
  size(800,600, P3D);
  noStroke();

  day_cycle = 0;
  test = new Tree(5, 160, new PVector());
}

void draw() {
  assert day_cycle >= 0 : "Day/night cycle was less than 0!";
  assert day_cycle <= 360 : "Day/night cycle count was greater than 360!";
  //If day_cycle goes above 360, don't we just want it to go back to 0?
  //like, if(day_cycle >= 360) day_cycle = 0;
  //and if(day_cycle <= -1) day_cycle = 359;
  background(0);
  //Day lights
  //directional light
  
  if(keyPressed) {
    if(key == 'q' || key == 'Q') {
      //decrease day_cycle
    }//q
    
    if(key == 'w' || key == 'W') {
      if(moon){
        moon = false;
      }//if moon
      else {
        moon = true;
      }//else moon
    }//w
    
    if(key == 'e' || key == 'E') {
      //increase day_cycle
    }//e
  }//keyPressed
  
  //if moon
  //Full moon
  //spotlight coming from moon
  ambientLight(18, 25, 31);
  spotLight(177, 192, 203, 0, 0, 200, 0, 0, -1, PI/2, 2);
  
  //if !moon
  //New moon
  //loooow ambient light with stars
  ambientLight(18, 25, 31); 
  directionalLight(69, 78, 85, 0, 1, -1);
  
  //Camera
  //Always looking at tree

  pushMatrix();
  translate(width/2, 700, -50);
  rotateY(radians(mouseY * (width / 360)));
  test.draw();
  popMatrix();


  //camera( 0, 0, 1000
  //   , mouseX, mouseY, -1000
  //   , 0, 1, 0
  //   );

}