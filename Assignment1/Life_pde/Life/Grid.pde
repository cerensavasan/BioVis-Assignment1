//100 rows & 100 columns
static int gridWidth = 100;
static int gridHeight = 100;

//colors for active & inactive cells
color alive = color(255); //white
color dead = color (0);  //black

public class Grid {
  int numRows = gridWidth;
  int numColumns = gridHeight;
  //grid decleration
  Cell[][] grid;
  
  public Grid(int numRows, int numColumns){
    this.numRows = numRows;
    this.numColumns = numColumns;
    grid = new Cell[numRows][numColumns];
  }
  
  public void init(){
    for(int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        grid[i][j] = new Cell(i*Cell.CELL_WIDTH, j*Cell.CELL_HEIGHT);
      }
    }
  }
  
  public void display(){
    for(int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        grid[i][j].placeOnGrid();
       
      }
      print("out of the second for loop");
    }
    print("out of the first for loop");
  }
  
  public void update() {
    for (int i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {
        int neighbors = numAliveNeighbors(i, j);
        Cell currentCell = grid[i][j];
        if (currentCell.getState() == true && neighbors < 2 || neighbors > 3 ) {
          currentCell.setTempState(false);
        } else {
          if (neighbors == 3 || neighbors == 2) {
            currentCell.setTempState(true);
          } else {
            currentCell.setTempState(false);
          }
        }
      }
    }

    for (int i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {
        grid[i][j].updateState();
      }
    }
  }


  public void toggleCell() {
    for (int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        if (grid[i][j].containsPoint(mouseX, mouseY)) {
          grid[i][j].changeState();
        }
      }
    }
  }
  
  public void randomBoard() {

    for (int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        if (int(random(100)) % 5 == 0) {
          grid[i][j].setAlive();
        } else {
          grid[i][j].setDead();
        }
      }
    }
  }
  
  

  public void clear() {
    for (int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        grid[i][j].setDead();
      }
    }
  }
  
  private int numAliveNeighbors(int x, int y) {
    int numNeighbors = 0;

    for (int i = x - 1; i <= x + 1; i++) {
      for (int j = y - 1; j <= y + 1; j++) {
        if (i != x && j != y) {
          numNeighbors += doesGridContainLiveCell(i, j) ? 1: 0;
        }
      }
    }

    return numNeighbors;
  }
  
  private boolean doesGridContainLiveCell(int x, int y) {
    if (outOfBounds(x, y)) {
      return false;
    } else {
      return grid[x][y].getState() == true;
    }
  }
  
  private boolean outOfBounds(int x, int y) {
    return x < 0 || x >= numColumns || y < 0 || y >= numRows;
  }
}
