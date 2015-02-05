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
    }
  }
  
  public void update() {
    for (int i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {   //iterates for each cell
        int neighbors = numAliveNeighbors(i, j);
        Cell currentCell = grid[i][j];
        if (currentCell.getState() == true){
         if(neighbors < 1 || neighbors > 3 ) {
          currentCell.setTempState(false); //die if no neighbors or too many
         }
        } 
        else {
         if (neighbors == 3 || neighbors == 2) { //birth if enough neighbors
            currentCell.setTempState(true);
         } else {                         
            currentCell.setTempState(false); //dead if dead an not enough or too many neighbors
          }
        }
      }
    }

    for (int i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {
        grid[i][j].updateState();  //set current state to the new state
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
      for (int j = 0; j < numRows; j++) { //for each cell
        if (int(random(100)) % 35  == 0) {
          grid[i][j].setAlive();
        } else {
          grid[i][j].setDead();
        }
      }
    }
  }
  
  
  //set everything to dead
  public void clear() {
    for (int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        grid[i][j].setDead();
      }
    }
  }
  
  private int numAliveNeighbors(int x, int y) { 
      // And visit all the neighbours of each cell
      int numNeighbors = 0; // We'll count the neighbours
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1 ;yy++) {  
          if (((xx>=0)&&(xx<100))&&((yy>=0)&&(yy<100))) { // Make sure you are not out of bounds
            if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
              if (grid[xx][yy].getState() == true){
                numNeighbors ++; // Check alive neighbours and count them
              }
            } // End of if
          } // End of if
        } // End of yy loop
      } //End of xx loop
    print(numNeighbors);
    return numNeighbors;  //total amt of neighbors
    }
   
   
   
   
   
   
    //int numNeighbors = 0;
    
    //for (int i = x - 1; i <= x + 1; i++) { //whats next to the cell in x axis
    //  for (int j = y - 1; j <= y + 1; j++) { //whats above and below cell in y axis
    //    if (i != x && j != y) {
    //      numNeighbors += doesGridContainLiveCell(i, j) ? 1: 0; //if there is a neighbor, add
    //    }
    //  }
    //}
  
  
  //checks if the the cell is live
  private boolean doesGridContainLiveCell(int x, int y) {
    if (outOfBounds(x, y)) {
      return false;
    } else {
      return grid[x][y].getState() == true;
    }
  }
  
  
  //checks if x and y coordinates are on the grid 
  private boolean outOfBounds(int x, int y) {
    return x < 0 || x >= numColumns || y < 0 || y >= numRows;
  }
}
