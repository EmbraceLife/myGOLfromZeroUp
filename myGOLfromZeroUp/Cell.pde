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

    if (int(random(100)) < 15) {
      now = 1;
    } else {
      now = 0;
    }

    previous = now;
  }


  void display() {

    stroke(50);


    if (now == 1 && previous == 1) {
      fill(#FF0318);
    } else if (previous == 1 && now == 0 ) {
      fill(#FFEDEE);
    } else if (previous == 0 && now == 1) {
      fill(#F093FF);
    } else if (previous == 0 && now == 0) {
      fill(0);
    }


    rect(xCell, yCell, wCell, wCell);
  }

  void randomizeState() {
    if (int(random(100)) < 20) {
      now = 1;
    } else {
      now = 0;
    }
  }
}