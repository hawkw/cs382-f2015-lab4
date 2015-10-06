int day_cycle;
boolean moon = true;
Tree tree0, tree1;

// camera x, y, and z position and view direction
float cam_x, cam_y, cam_z
    , look_x, look_y, look_z;

// increase/decrease this constant to make the
// "player" walk faster or slower
final int WALK_SPEED = 5;
// Z positions for the sun and moon
final float MOON_Z = 2000;
final float SUN_Z = 3000;
// IMPORTANT SPACE COEFFICIENT DO NOT DELETE
// controls how far away 'space' (i.e., where the sun & moon are)
// is from our sad, cubic 'earth'
final float SPACE_COEFF = 5000;

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
} //setup

void draw() {
  background(0);
  ambientLight(18, 25, 31);

  // Handle key presses.
  // KJ wrote this but I re-wrote it to be cleaner (i.e. to use `switch`).
  if(keyPressed) {
    switch (key) {
      case CODED: arrow_key();
                  break;
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
      default:  break;
    }
  }

  // important! do not delete!
  if(day_cycle<=0) {
    day_cycle = 359;
  }
  else if (day_cycle>=360) {
    day_cycle = 0;
  }
  // Draw the sun or moon depending on the day/night cycle.
  // KJ wrote most of this.
  if(moon && day_cycle > 179) {
    float moon_x = -SPACE_COEFF * cos(radians(day_cycle));
    float moon_y = SPACE_COEFF * sin(radians(day_cycle));
    // Full moon
    // spotlight coming from moon
    spotLight( 177, 192, 203,
               0, -1, 0,
               moon_x, moon_y, MOON_Z,
               PI/2, 1); //lights the moon
    spotLight( 177, 192, 203,
               moon_x, moon_y, MOON_Z,
               0, 0, -1,
               PI/2, 1);
    // draw the moon
    pushMatrix();
    translate(moon_x, moon_y, MOON_Z);
    fill(255);
    sphere(300);
    popMatrix();
  } else {
    // sun
    float sun_x, sun_y;
    sun_x = SPACE_COEFF * cos(radians(day_cycle));
    sun_y = -SPACE_COEFF * sin(radians(day_cycle));

    //Day lights
    //directional light
    ambientLight(106,104,68);
    // light coming from the sun
    directionalLight(255,249,134,-sun_x, -sun_y, SUN_Z);

    spotLight( 252, 234, 64,
               0, -1, 0,
               sun_x, sun_y, SUN_Z,
               PI/2, 1); //lights the sun

    // draw the sun
    pushMatrix();
    translate(sun_x, sun_y, 3000);
    fill(255,255,0);
    sphere(600);
    popMatrix();
  }

  // draw the horizon (which is a giant box?)
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

/**
 * Handle arrow key presses.
 *
 * This function is called only if a coded (arrow) key was pressed,
 * so we can assume that there's a valid key code.
 *
 * Based on the code from class, but cleaned up slightly (I added constants!).
 *
 * @author Hawk Weisman
 */
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

/**
 * Calculate the horizontal angle for the mouse X position
 * @author Hawk Weisman
 */
float angle_h() { return ((float)mouseX / (float)width - 0.5) * 360; }
/**
 * Calculate the vertical angle for the mouse Y position
 * @author Hawk Weisman
 */
float angle_v() { return ((float)mouseY / (float)height - 0.5) * 180; }

/**
 * Updates the camera angle based on the mouse position.
 *
 * This is based on the code from class but modified
 * slightly by me.
 *
 * @author Hawk Weisman
 */
void update_camera(float theta_h, float theta_v) {
  look_x = 100000 * sin(radians(theta_h));
  look_y = 100000 * sin(radians(theta_v));
  look_z = -100000 * cos(radians(theta_h));
}
