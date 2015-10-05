int day_cycle;
boolean moon = true;
Tree tree0, tree1;
<<<<<<< HEAD
float cam_x, cam_y, cam_z
    , look_x, look_y, look_z;
float angle, angleV;
final int WALK_SPEED = 5;

=======
float camX, camY, camZ
    , lookX, lookY, lookZ;
float angle, angleV;
>>>>>>> moon
void setup() {
  size(800,600, P3D);
  noStroke();

  day_cycle = 0;
  tree0 = new Tree(4, 160, new PVector());
  tree1 = new Tree(4, 200, new PVector(500, 0, 200));

  cam_x = 0;
  cam_y = -100;
  cam_z = 1000;
  look_x = 0;
  look_y = 0;
  look_z = -100000;
  angle = 0;
  angleV = 0;
} //setup

void draw() {
  assert day_cycle >= 0 : "Day/night cycle was less than 0!";
  assert day_cycle <= 360 : "Day/night cycle count was greater than 360!";
  //If day_cycle goes above 360, don't we just want it to go back to 0?
  //like, if(day_cycle >= 360) day_cycle = 0;
  //and if(day_cycle <= -1) day_cycle = 359;
  background(0);
  //Day lights
  //directional light
  ambientLight(106,104,68);
  directionalLight(255,249,134,0,1,0);

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

  if(moon) {
    //Full moon
    //spotlight coming from moon
    PVector moon_pos = PVector.fromAngle(radians(day_cycle));
    ambientLight(18, 25, 31);
    spotLight( 177, 192, 203
              , moon_pos.x, moon_pos.y, 2000
              , 0, 0, -1, PI/2, 1);
    // draw the moon
    pushMatrix();
    translate(moon_pos.x, moon_pos.y, 2000);
    sphere(30);
    popMatrix();
  } else {
    //New moon
    //loooow ambient light with stars
    ambientLight(18, 25, 31);
    directionalLight(69, 78, 85, 0, 1, -1);
  }

  pushMatrix();
  translate(0,2500,0);
  fill(57, 245, 70);
  box(5000);
  popMatrix();
  //pushMatrix();
  //translate(width/2, 700, -50);
  //rotateY(radians(mouseY * (width / 360)));
  tree0.draw();
  tree1.draw();
  //popMatrix();

  if (keyPressed && (key == CODED))
    keyboardInput();

  //Camera
  update_camera(angle_h(), angle_v());
  camera( cam_x, cam_y, cam_z
        , look_x, look_y, look_z
        , 0, 1, 0
        );

}//draw

void keyboardInput() {
  switch (keyCode) {
     case LEFT:
       cam_x += WALK_SPEED *
                sin(radians(angle_h() - 90));
       cam_z += WALK_SPEED *
                -cos(radians(angle_h() - 90));
       break;
     case RIGHT:
       cam_x += WALK_SPEED *
                -sin(radians(angle_h() - 90));
       cam_z += WALK_SPEED *
                cos(radians(angle_h() - 90));
       break;
     case UP:
       cam_x += WALK_SPEED *
                sin(radians(angle_h()));
       cam_z += WALK_SPEED *
                -cos(radians(angle_h()));
       break;
     case DOWN:
       cam_x += WALK_SPEED *
                -sin(radians(angle_h()));
       cam_z += WALK_SPEED *
                cos(radians(angle_h()));
       break;
     default: break;
   }
 }

float angle_h() { return ((float)mouseX /
                           (float)width - 0.5) * 360; }

float angle_v() { return ((float)mouseY /
                          (float)height - 0.5) * 180; }


void update_camera(float theta_h, float theta_v) {
  look_x = 100000 * sin(radians(theta_h));
  look_y = 100000 * sin(radians(theta_v));
  look_z = -100000 * cos(radians(theta_h));
}
