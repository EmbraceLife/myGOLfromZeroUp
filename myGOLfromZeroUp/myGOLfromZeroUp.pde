// global variables
Cell cell1, cell2;
Cell[][] board1;
int colsBoard, rowsBoard, wCell;
boolean debugAllToggle, watcherToggle, randomizeBoardToggle;

void setup() {
  
  debugAllToggle = true;
  watcherToggle = false;
  randomizeBoardToggle = false;
  colsBoard = 60;
  rowsBoard = 60;
  wCell = 10;
  size(600, 600);
  simpleCheck("create canvas 600:600");
  
  background(0);

  cell1 = new Cell(int(random(width-10)), int(random(height-10)), 10);
  cell2 = new Cell(int(random(width-10)), int(random(height-10)), 10);
  board1 = new Cell[colsBoard][rowsBoard];
  
  createBoard(colsBoard, rowsBoard, wCell, board1);
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

/*****
randomize every cell in the board1
*****/
  randomizeBoard(colsBoard, rowsBoard, board1);
  simpleCheck("board1 is randomized");
  
/*****
let every cell in board1 evolve
*****/
  evolveBoard(colsBoard, rowsBoard, board1);
  displayBoard(colsBoard, rowsBoard, board1);
  simpleCheck("board1 is displayed");
  
  
  noLoop();
}



void keyPressed() {
  drawAnotherFrame();
  drawContinue();
  
/*****
press r to trigger 
*****/
  randomizeBoardControl();
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
 
void displayBoard(int colsBoard, int rowsBoard, Cell[][] board) {
    for (int i = 0; i < colsBoard; i++) {
     for (int j = 0; j < rowsBoard; j++) {
         board[i][j].display();
     }
    }
} 


/*******
if randomizeBoardToggle is true, 
randomize every cell in the board
*******/
void randomizeBoard(int colsBoard, int rowsBoard, Cell[][] board) {
  
  if (randomizeBoardToggle) {
    for (int i = 0; i < colsBoard; i++) {
     for (int j = 0; j < rowsBoard; j++) {
         board[i][j].randomizeState();
     }
    }
    
    randomizeBoardToggle = !randomizeBoardToggle;
  }
} 

/*****
let every cell evolve
*****/
void evolveBoard(int colsBoard, int rowsBoard, Cell[][] board) {
  
  
 for (int i = 0; i < colsBoard; i++) {
    for (int j = 0; j < rowsBoard; j++) {
      board[i][j].previous = board[i][j].now;
      int aliveNeighbours = 0;
      
      for (int x = -1; x <= 1; x++) { // note x<=1, y<=1
        for (int y = -1; y <=1; y++) {
          if (board[(i+x+colsBoard)%colsBoard][(j+y+rowsBoard)%rowsBoard].now == 1) { //note: i+x+colsBoard
             aliveNeighbours++; 
          }
        }
      }
      
      aliveNeighbours = aliveNeighbours - board[i][j].now;
      
      if (board[i][j].previous == 1) {
         if (aliveNeighbours < 2 || aliveNeighbours > 3) {
            board[i][j].now = 0; 
         } // otherwise, no change to its state
      } else {
         if (aliveNeighbours == 3) {
            board[i][j].now = 1; 
         }
      }
      
      board[i][j].previous = board[i][j].now;
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

/*****
randomize board:
-- press r to trigger randomizeBoardToggle 
******/
void randomizeBoardControl() {
  if (key == 'r') {
    randomizeBoardToggle = !randomizeBoardToggle;
  }
}