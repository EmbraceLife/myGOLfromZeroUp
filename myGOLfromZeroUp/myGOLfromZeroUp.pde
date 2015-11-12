// global variables
Cell cell1, cell2;
Cell[][] board1;
boolean debugAllToggle, watcherToggle;

void setup() {
  
  debugAllToggle = true;
  watcherToggle = false;
  
  size(600, 600);
  simpleCheck("create canvas 600:600");
  
  background(0);

  cell1 = new Cell(int(random(width-10)), int(random(height-10)), 10);
  cell2 = new Cell(int(random(width-10)), int(random(height-10)), 10);
  board1 = new Cell[10][10];
  
  createBoard(10, 10, 10, board1);
  simpleCheck("board1 is formed");
}



void draw() {
  
  cell1.display();
  
  simpleCheck("cell1 is displayed");
  check2Values("cell1-x:y", cell1.xCell, cell1.yCell);
  check2Values("cell1-deadColor:lifeColor", cell1.deathColor, cell1.lifeColor);
  check2Values("cell1-now:previous", cell1.now, cell1.previous);
  
  
  cell2.display();
  
  simpleCheck("cell2 is displayed");
  check2Values("cell2-x:y", cell2.xCell, cell2.yCell);
  check2Values("cell2-deadColor:lifeColor", cell2.deathColor, cell2.lifeColor);
  check2Values("cell2-now:previous", cell2.now, cell2.previous);
  
  randomizeBoard(10, 10, board1);
  simpleCheck("board1 is randomized");
  
  displayBoard(10, 10, board1);
  simpleCheck("board1 is displayed");
  
  
  noLoop();
}



void keyPressed() {
  drawAnotherFrame();
  drawContinue();
  
  debugAllControl();
  watcherControl();
}


//*****************************************
// board functions
//*****************************************

void createBoard(int colBoard, int rowBoard, int wCell, Cell[][] board) {
    for (int i = 0; i < colBoard; i++) {
     for (int j = 0; j < rowBoard; j++) {
         board[i][j] = new Cell(i*wCell, j*wCell, wCell);
     }
    }
}
 
void displayBoard(int colBoard, int rowBoard, Cell[][] board) {
    for (int i = 0; i < colBoard; i++) {
     for (int j = 0; j < rowBoard; j++) {
         board[i][j].display();
     }
    }
} 

void randomizeBoard(int colBoard, int rowBoard, Cell[][] board) {
    for (int i = 0; i < colBoard; i++) {
     for (int j = 0; j < rowBoard; j++) {
         board[i][j].randomizeState();
     }
    }
} 

//****************************************
// debug functions
//******************************************

void drawContinue() {
  if (key == ' ') {
    loop(); 
  }
}


void drawAnotherFrame() {
   if (key == 'n') {
      redraw();
   }
}

void simpleCheck(String words) {
  if (debugAllToggle) {
     print("frame", frameCount, "-> ");
     println(words); 
  }
}


void checkValue(String words, int value) {
  if (debugAllToggle) {
   print("frame", frameCount, "-> ");
   print(words, "-> ");
   println(value);
  }
}
 
void check2Values(String words, int value1, int value2) {
  if (debugAllToggle) {
   print("frame", frameCount, "-> ");
   print(words, "-> ");
   println(value1, ":", value2);
  }
} 


//****************************************
// Toggle Keys
//****************************************
void debugAllControl() {
   if (key == 'd') {
      debugAllToggle = !debugAllToggle; 
   }
}


void watcherControl() {
  if (key == 'w') {
     watcherToggle = !watcherToggle;
  }
}