int day_cycle;
boolean moon = true;
Tree tree0, tree1;

float cam_x, cam_y, cam_z
    , look_x, look_y, look_z;
float angle, angleV;
float moon_posx, moon_posy;
final int WALK_SPEED = 5;
final float MOON_Z = 2000;
final float MOON_COEFF = 5000;

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
  background(0);
  //Day lights
  //directional light
  ambientLight(106,104,68);
  directionalLight(255,249,134,0,1,0);

  if(keyPressed) {
    switch (key) {
      case CODED: arrow_key();
      case 'q':
      case 'Q': day_cycle--;
                break;
      case 'e':
      case 'E': day_cycle++;
               break;
      case 'w':
      case 'W': if(moon){
                  moon = false;
                }//if moon
                else {
                  moon = true;
                }//else moon
                break;
      default: break;
    }
  }
   
  if(moon) {
    //Full moon
    //spotlight coming from moon
    moon_posx= -MOON_COEFF * cos(radians(day_cycle));
    moon_posy= MOON_COEFF * sin(radians(day_cycle));
    ambientLight(18, 25, 31);
    spotLight( 177, 192, 203
              , moon_posx, moon_posy, MOON_Z
              , 0, 0, -1, PI/2, 1);
    // draw the moon
    pushMatrix();
    translate(moon_posx, moon_posy, MOON_Z);
    fill(255);
    sphere(300);
    popMatrix();
  } else {
    //New moon
    //loooow ambient light with stars
    ambientLight(18, 25, 31);
    directionalLight(69, 78, 85, 0, 1, -1);
  }
  
  // sun
  float sun_x, sun_y;
  sun_x = MOON_COEFF * cos(radians(day_cycle));
  sun_y = -MOON_COEFF * sin(radians(day_cycle));
  pushMatrix();
  translate(sun_x, sun_y, 3000);
  fill(255,255,0);
  sphere(600);
  popMatrix();

  pushMatrix();
  translate(0,2500,0);
  fill(57, 245, 70);
  box(5000);
  popMatrix();
  tree0.draw();
  tree1.draw();

  //Camera
  update_camera(angle_h(), angle_v());
  camera( cam_x, cam_y, cam_z
        , look_x, look_y, look_z
        , 0, 1, 0
        );

}//draw

void arrow_key() {
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