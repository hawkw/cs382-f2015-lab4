int day_cycle;
Tree test;

void setup() {
  size(1000,800,OPENGL);
  day_cycle = 0;
  test = new Tree(5, 160, new PVector());
}

void draw() {
  lights();
  assert day_cycle >= 0 : "Day/night cycle was less than 0!";
  assert day_cycle <= 360 : "Day/night cycle count was greater than 360!";
  background(0);
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