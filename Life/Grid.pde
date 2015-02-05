//CS4802 - Assignment 1
//Written by Ceren Savasan
//username: csavasan

//100 rows & 100 columns
static int gridWidth = 100;
static int gridHeight = 100;

//REFERENCE: colors for active & inactive cells
color alive = color(255); //white
color dead = color (0);  //black

public class Grid {
  int numRows = gridWidth;  //100 rows
  int numColumns = gridHeight;  //100 columns
 
  //grid decleration
  Cell[][] grid;
  
  //grid creation
  public Grid(int numRows, int numColumns){
    this.numRows = numRows;
    this.numColumns = numColumns;
    grid = new Cell[numRows][numColumns];
  }
  
  //initalize grid
  public void init(){
    for(int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        grid[i][j] = new Cell(i*Cell.CELL_WIDTH, j*Cell.CELL_HEIGHT);
      }
    }
  }
  
  //iterate through rows and columns and place all cells (dead or alive)
  public void display(){
    for(int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        grid[i][j].placeOnGrid();
      }
    }
  }
  
  //main function that checks for neighbors and decides on birth/death situations
  public void update() {
    for (int i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {   //iterates for each cell
        ArrayList<Cell> neighbors = getAliveNeighbors(i,j);
        Cell currentCell = grid[i][j];
        if (currentCell.getState() == true){
         if(currentCell.getState() == true && (neighbors.size() < 1 || neighbors.size() > 3) ) {
          currentCell.setTempState(false); //die if no neighbors or  too many
         }
         if (currentCell.getState() == true && (neighbors.size() == 3 || neighbors.size() == 2)){    //birth if enough neighbors
            currentCell.setTempState(true);
        } 
        else {
         if (currentCell.getState() == false && neighbors.size() == 3){    //birth if enough neighbors
            currentCell.setTempState(true);
         } else {                         
            currentCell.setTempState(false); //dead if dead an not enough or too many neighbors
          }
        }
      }
    }
    
    i = 0;
    
    //double check neighbors for new state (to reduce spread rate)
    
    for (i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {   //iterates for each cell
        ArrayList<Cell> newNeighbors = getAliveNeighbors(i,j);
        Cell newCurrentCell = grid[i][j];
        if (newCurrentCell.getState() == true){
         if(newCurrentCell.getState() == true && (newNeighbors.size() < 1 || newNeighbors.size() > 3) ) {
          newCurrentCell.setTempState(false); //die if no neighbors or  too many
         }
          if (newCurrentCell.getState() == true && (newNeighbors.size() == 3 || newNeighbors.size() == 2)){    //birth if enough neighbors
            newCurrentCell.setTempState(true);
          }
        } 
        else {
         if (newCurrentCell.getState() == false && newNeighbors.size() == 3){    //birth if enough neighbors
            newCurrentCell.setTempState(true);
         } else {                         
            newCurrentCell.setTempState(false); //dead if dead an not enough or too many neighbors
          }
        }
      }
    }
    
    i = 0;
    
    //set the actual states of cells to those temp states decided above
    for (i=0; i<numColumns; i++) {
      for (int j=0; j<numRows; j++) {
        grid[i][j].updateState();  //set current state to the new state
      }
    }
  }
  }
  

  //mouse click to kill/give birth to cell
  public void toggleCell() {
    for (int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) {
        if (grid[i][j].containsCell(mouseX, mouseY)) {
          grid[i][j].changeState();
        }
      }
    }
  }
  
  //press r to randomize board, also this is the initial config
  public void randomBoard() {
    for (int i = 0; i < numColumns; i++) {
      for (int j = 0; j < numRows; j++) { //for each cell
        if (int(random(100)) % 15  == 0) {
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
  
  
  //now many alive neighbors? this is a helper function RETURNS INT
  private  int numAliveNeighbors(int x, int y) { 
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
    return numNeighbors;  //total amt of neighbors
    }
    
  //Returns actual array of neighbors
  private ArrayList<Cell> getAliveNeighbors(int x, int y) { 
      // And visit all the neighbours of each cell
      ArrayList<Cell> neighbors = new ArrayList<Cell>();
      
      for (int xx=x-1; xx<=x+1;xx++) {
        for (int yy=y-1; yy<=y+1 ;yy++) {  
          if (((xx>=0)&&(xx<100))&&((yy>=0)&&(yy<100))) { // Make sure you are not out of bounds
            if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
              if (grid[xx][yy].getState() == true){
                neighbors.add(grid[xx][yy]); // add alive neighbor to array
              }
            } // End of if
          } // End of if
        } // End of yy loop
      } //End of xx loop
    return neighbors;  //all of neighbors in an array
    }
}
