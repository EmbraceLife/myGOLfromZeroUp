// global variables
Cell cell1;


void setup() {
  size(600, 600);
  println("canvas is created");

  background(0);

  cell1 = new Cell(int(random(width-10)), int(random(height-10)), 10);
  println("cell1 location: ", cell1.xCell, ":", cell1.yCell);
  println("cell1 color: ", cell1.deathColor, ":", cell1.lifeColor);
  println("cell1 state: ", cell1.now, ":", cell1.previous);
}


void draw() {
  
  cell1.display();
}


void keyPressed() {
}