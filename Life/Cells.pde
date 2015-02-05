//CS4802 - Assignment 1
//Written by Ceren Savasan
//username: csavasan

//Class decleration and sub-routines
public class Cell{
  int x;                   //x-coord
  int y;                   //y-coord
  
  public static final boolean ALIVE = true;
  public static final boolean DEAD = false;
  
  private boolean state;   //false = dead, true = alive
  private boolean tempState;
  
  //one cell is 6x6
  public static final int CELL_WIDTH = 6;
  public static final int CELL_HEIGHT = 6;
  
  public Cell(int tempX, int tempY){
    x = tempX;
    y = tempY;
    
    state = false;
  }



  //GETTERS AND SETTERS
  public void changeState(){
    state = !state;
  }
  
  public boolean getState(){
    return state;
  }
  
  public void setTempState(boolean newstate){
    tempState = newstate;
  }
  
  public void updateState(){
    state = tempState;
  }
  
  public void setAlive(){
    state = true;
  }
  
  public void setDead(){
    state = false;
  }
  
  
  
  //DRAW CELL ON GRID
  public void placeOnGrid() {
    stroke(255);
      if (state == true) {  //WHITE IF ALIVE
      fill(255, 255, 255);
    } else {
      fill(0, 0, 0);   //BLACK IF DEAD
    }
    rect(x, y, CELL_WIDTH, CELL_HEIGHT);   //SIZE OF CELL
  } 
  
  public boolean containsCell(int x, int y) {
    boolean withinX = this.x <= x && x <= (this.x + CELL_WIDTH);
    boolean withinY = this.y <= y && y <= (this.y + CELL_HEIGHT);
    return withinX && withinY;
  }
  
}
