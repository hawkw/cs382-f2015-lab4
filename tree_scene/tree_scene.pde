int day_cycle;
boolean moon = true;

void setup() {
  size(800,600, P3D);
  noStroke();
  day_cycle = 0;
}

void draw() {
  assert day_cycle >= 0 : "Day/night cycle was less than 0!";
  assert day_cycle <= 360 : "Day/night cycle count was greater than 360!";
  //If day_cycle goes above 360, don't we just want it to go back to 0?
  //like, if(day_cycle >= 360) day_cycle = 0;
  //and if(day_cycle <= -1) day_cycle = 359;
  
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

}