color TRUNK_COLOR = #814300;
color LEAF_COLOR = #04AF02;
float MAX_BRANCHES = 5;
float MIN_BRANCHES = 3;
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
  PVector rotation;
  Tree[] branches;

  int level;
  int max_level;
  int size;

  float branch_length;
  float branch_width;
  color branch_color;

  Tree(int max_level, int level, int size, PVector pos, PVector rotation) {
    this.level     = level;
    this.max_level = max_level;
    this.size      = size;
    this.pos       = pos;
    this.rotation  = rotation;

    this.branches  = mk_branches();

    branch_length = -size * pow(LENGTH_COEFF, level);
    branch_width  = size/4.5 * pow(WIDTH_COEFF, level);
    branch_color  = lerpColor( TRUNK_COLOR
                              , LEAF_COLOR
                              , (float)level / ((float)max_level + 2)
                              );
  }

  Tree(int max_level, int size, PVector pos) {
    this.level     = 0;
    this.max_level = max_level;
    this.size      = size;
    this.pos       = pos;
    this.rotation  = PVector.fromAngle(0);

    this.branches  = mk_branches();

    branch_length = -size * pow(LENGTH_COEFF, level);
    branch_width  = size/4.5 * pow(WIDTH_COEFF, level);
    branch_color  = lerpColor( TRUNK_COLOR
                              , LEAF_COLOR
                              , (float)level / ((float)max_level + 2)
                              );
  }

  Tree mk_branch() {
    return new Tree( max_level
                    , level + 1
                    , size
                    , pos
                    , PVector.fromAngle(random(-ROT_AMOUNT, ROT_AMOUNT)));
  }

  Tree[] mk_branches() {
    int n_branches = level <= max_level ?
      (int)random(MIN_BRANCHES, MAX_BRANCHES) : 0;

    Tree[] result = new Tree[n_branches];

    for (int i = 0; i < n_branches; i++)
      result[i] = mk_branch();

    return result;
  }

  void draw() {
    pushMatrix();
      if (level == 0)
        translate(pos.x, pos.y, pos.z);

      pushMatrix();
        if (level != 0) {
          rotateX(rotation.x);
          rotateY(rotation.y);
        }

        fill(branch_color);
        cylendar(branch_width, branch_length);
        translate(0, branch_length, 0);
        for (Tree branch: branches)
          branch.draw();
      popMatrix();
    popMatrix();
  }

}
