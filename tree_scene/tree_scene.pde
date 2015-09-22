int day_cycle;


void setup() {
  day_cycle = 0;
}

void draw() {
  assert day_cycle >= 0 : "Day/night cycle was less than 0!"
  assert day_cycle <= 360 : "Day/night cycle count was greater than 360!"

}
