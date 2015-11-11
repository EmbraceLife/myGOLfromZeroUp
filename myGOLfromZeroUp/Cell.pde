class Cell {
 
  int xCell, yCell, wCell;
  int lifeColor, deathColor;
  int now, previous;
  
  Cell(int x, int y, int w) {
    
   xCell = x;
   yCell = y;
   wCell = w;
   
   lifeColor = #EA5905;
   deathColor = #050200;
   
   now = round(random(1));
   previous = now;
  }
  
}