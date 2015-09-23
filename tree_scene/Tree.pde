color TRUNK_COLOR = #814300;
color LEAF_COLOR = #04AF02;
float MAX_BRANCHES = 4;
float MIN_BRANCHES = 2;
float LENGTH_COEFF = 0.75;
float WIDTH_COEFF  = 0.4;
float ROT_AMOUNT = 15;
float TRUNK_POLYS = 16;
float TRUNK_INCR = TWO_PI/TRUNK_POLYS;

void cylendar(float radius, float length) {
  float theta = 0;
  noStroke();
  pushMatrix();
  rotateX(PI);
  translate(0, -length, 0);
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= TRUNK_POLYS; i++) {
    // draw the top vertex
    vertex ( radius * cos(theta)
           , length
           , radius * sin(theta)
           );
    // draw the bottom vertex
    vertex( radius * cos(theta)
          , 0
          , radius * sin(theta)
          );
    theta = theta + TRUNK_INCR;
  }
  endShape();
  popMatrix();
}

class Tree {
  PVector pos;
  PVector[] rotations;

  int max_level;
  int size;

  Tree(int max_level, int size, PVector pos) {
    this.max_level = max_level;
    this.size      = size;
    this.pos       = pos;

    rotations = new PVector[max_level];
    for (int i = 0; i < max_level; i++)
      rotations[i] 
        = PVector.fromAngle(random(-ROT_AMOUNT, ROT_AMOUNT));

  }

  void branch(int level) {
    if (level <= max_level) {
      float branch_length = -size * pow(LENGTH_COEFF, level);
      float branch_width  = size/4.5 * pow(WIDTH_COEFF, level);
      float lerp_amount = (float)level / ((float)max_level + 2);
      fill(lerpColor( TRUNK_COLOR
                    , LEAF_COLOR
                    , lerp_amount
                    ));
      cylendar(branch_width, branch_length);
      translate(0, branch_length, 0);
      for (PVector r: rotations) {
        //println(r);
        pushMatrix();
          rotateX(r.x);
          //rotateY(r.y);
          rotateZ(r.y);
          branch(level + 1);
        popMatrix();
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    branch(1);
    popMatrix();
  }

}