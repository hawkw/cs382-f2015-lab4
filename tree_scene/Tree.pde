color TRUNK_COLOR  = #814300;
color LEAF_COLOR   = #04AF02;
int   LEAF_ALPHA   = 140;
float MAX_BRANCHES = 5;
float MIN_BRANCHES = 3;
float LENGTH_COEFF = 0.75;
float WIDTH_COEFF  = 0.6;
float ROT_AMOUNT   = 15;
float TRUNK_POLYS  = 16;
float TRUNK_INCR   = TWO_PI/TRUNK_POLYS;

/**
 * Draw a trunk segment with the specified starting radius
 * and the specified length.
 *
 * All trunk segments are cones; this could be generalised
 * into a function for drawing cones.
 *
 * @param  radius the thickest radius of the trunk segment
 * @param  length the segment's length
 * @author Hawk Weisman
 */
void trunk_sgmt(float radius, float length) {
  float theta = 0;
  noStroke();
  pushMatrix();
  rotateX(PI);
  translate(0, -length, 0);
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= TRUNK_POLYS; i++) {
    // draw the top vertex
    float top_rad = 3 * (radius/4);
    vertex ( top_rad * cos(theta)
           , 0
           , top_rad * sin(theta)
           );
    // draw the bottom vertex
    vertex( radius * cos(theta)
          , length
          , radius * sin(theta)
          );
    theta = theta + TRUNK_INCR;
  }
  endShape();
  popMatrix();
}

/**
 * A recursive, randomly-generated tree.
 * @author Hawk Weisman
 */
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

  /**
   * Constructs a new Tree representing a branch from an existant tree.
   */
  Tree(int max_level, int level, int size, PVector pos, PVector rotation) {
    this.level     = level;
    this.max_level = max_level;
    this.size      = size;
    this.pos       = pos;
    this.rotation  = rotation;

    this.branches  = mk_branches();

    this.branch_length = -this.size * pow(LENGTH_COEFF, level);
    this.branch_width  = this.size/4.5 * pow(WIDTH_COEFF, level);
    //this.branch_color  = lerpColor( TRUNK_COLOR
    //                          , LEAF_COLOR
    //                          , (float)level / ((float)max_level + 2)
    //                          );
  }

  /**
   * Constructs a new Tree at the specified position,
   * and creates all its branches.
   *
   * @param max_level the maximum number of branches for the tree (5 is safe)
   *                  if this is too high, your frame rate will suffer...
   * @param size the size of the tree
   * @param pos a PVector representing the position of the tree's base
   */
  Tree(int max_level, int size, PVector pos) {
    this.level     = 0;
    this.max_level = max_level;
    this.size      = size;
    this.pos       = pos;
    this.rotation  = PVector.fromAngle(0);

    this.branches  = mk_branches();

    this.branch_length = -this.size * pow(LENGTH_COEFF, level);
    this.branch_width  = this.size/4.5 * pow(WIDTH_COEFF, level);
    //this.branch_color  = lerpColor( TRUNK_COLOR
    //                          , LEAF_COLOR
    //                          , (float)level / ((float)max_level + 2)
    //                          );
  }

  /**
   * Make a new Tree as a branch from this tree.
   * @return a new Tree that is a branch from this Tree
   * @author Hawk Weisman
   */
  Tree mk_branch() {
    return new Tree( max_level
                    , level + 1
                    , size
                    , pos
                    , PVector.fromAngle(random(-ROT_AMOUNT, ROT_AMOUNT)));
  }

  /**
   * Make all the branches of this Tree, returning a Tree array.
   * @return an array of Trees representing the branches of this tree.
   * @author Hawk Weisman
   */
  Tree[] mk_branches() {
    int n_branches = level < max_level ?
      (int)random(MIN_BRANCHES, MAX_BRANCHES) : 0;

    Tree[] result = new Tree[n_branches];

    for (int i = 0; i < n_branches; i++)
      result[i] = mk_branch();

    return result;
  }

  /**
   * Draw this tree
   * @return nothing
   * @author Hawk Weisman
   */
  void draw() {
    pushMatrix();
      if (level == 0)
        translate(pos.x, pos.y, pos.z);

      pushMatrix();
        if (level != 0) {
          rotateX(rotation.x);
          rotateY(rotation.y);
        }

        fill(TRUNK_COLOR);
        trunk_sgmt(branch_width, branch_length);
        translate(0, branch_length, 0);
        if (level == max_level) {
          fill(LEAF_COLOR, LEAF_ALPHA);
          sphere(size/6);
        } else {
          for (Tree branch: branches)
            branch.draw();
        }
      popMatrix();
    popMatrix();
  }

}
