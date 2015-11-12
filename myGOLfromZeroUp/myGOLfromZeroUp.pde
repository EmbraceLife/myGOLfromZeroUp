// global variables

Cell[][] board1;
int colsBoard, rowsBoard, wCell;
boolean debugAllToggle, watcherToggle, randomizeBoardToggle;

void setup() {
  
  debugAllToggle = true;
  watcherToggle = false;
  randomizeBoardToggle = false;
  colsBoard = 120;
  rowsBoard = 120;
  wCell = 5;
  size(600, 600);
  simpleCheck("create canvas 600:600");
  
  background(0);

  board1 = new Cell[colsBoard][rowsBoard]; 
  createBoard(colsBoard, rowsBoard, wCell, board1);
  simpleCheck("board1 is formed");
}



void draw() {
  

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

  
  //noLoop();
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
      
      aliveNeighbours = aliveNeighbours - board[i][j].previous;
      
      //if (board[i][j].previous == 1) {
      //   if (aliveNeighbours < 2 || aliveNeighbours > 3) {
      //      board[i][j].now = 0; 
      //   } // otherwise, no change to its state
      //} else {
      //   if (aliveNeighbours == 3) {
      //      board[i][j].now = 1; 
      //   }
      //}
      if ((board[i][j].previous == 1) && aliveNeighbours <2) board[i][j].now = 0;
      else if ((board[i][j].previous == 1) && aliveNeighbours >3) board[i][j].now = 0;
      else if ((board[i][j].previous == 1) && (aliveNeighbours == 2 || aliveNeighbours == 3)) board[i][j].now = 1;
      else if ((board[i][j].previous == 0) && aliveNeighbours == 3) board[i][j].now = 1;
      else if (board[i][j].previous == 0 && aliveNeighbours != 3 ) board[i][j].now = 0;
      //board[i][j].previous = board[i][j].now;
    }
 }
}

void evolveBoard1(int colsBoard, int rowsBoard, Cell[][] board) {

  for (int i = 0; i < colsBoard; i++) {
    for (int j = 0; j < rowsBoard; j++) {
      int aliveNeighbours = 0;
  
      for ( int x = -1; x <=1; x++)  {
        for (int y = -1; y <= 1; y++ ) {
          aliveNeighbours += board[(i+x+colsBoard)%colsBoard][(j+y+rowsBoard)%rowsBoard].now;
          
         }
      }
      aliveNeighbours -= board[i][j].now;
      println("cell", i, ":", j, "-> ", aliveNeighbours);
      
      if (aliveNeighbours == 3 && board[i][j].now == 0) {
        stroke(50);
        fill(#FAA45D);
        rect(i*wCell, j*wCell, wCell, wCell);
      } else if (aliveNeighbours ==3 && board[i][j].now ==1) {
        stroke(50);
        fill(#FF0318);
        rect(i*wCell, j*wCell, wCell, wCell); 
      }
    }
  }
}



void evolveBoard2(int colsBoard, int rowsBoard, Cell[][] board) {
  for (int i = 0; i < colsBoard; i++) {
    for (int j = 0; j < rowsBoard; j++) {
      board[i][j].previous = board[i][j].now;
      int aliveNeighbours = 0;
      
      for ( int x = -1; x <=1; x++)  {
        for (int y = -1; y <= 1; y++ ) {
        aliveNeighbours += board[(i+x+colsBoard)%colsBoard][(j+y+rowsBoard)%rowsBoard].previous;
        
        }
      }
      aliveNeighbours -= board[i][j].now;
      //println("cell", i, ":", j, "-> ", aliveNeighbours);
      
      if ( (aliveNeighbours == 3 || aliveNeighbours == 2 ) && board[i][j].previous == 1) {
        board[i][j].now = 1; 
      } else if ( (aliveNeighbours > 3 || aliveNeighbours < 2) && board[i][j].previous == 1) {
        board[i][j].now = 0; 
      } else if ( aliveNeighbours == 3 && board[i][j].previous == 0 ) {
         board[i][j].now = 1;
      } else if ( aliveNeighbours != 3 && board[i][j].previous == 0) {
        board[i][j].now = 0;
      }
    
      
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