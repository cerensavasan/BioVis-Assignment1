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
  
  public void placeOnGrid() {
    stroke(255);
      if (state == true) {
      fill(255, 255, 255);
    } else {
      fill(0, 0, 0);
    }
    rect(x, y, CELL_WIDTH, CELL_HEIGHT);
  } 
  
  public boolean containsPoint(int x, int y) {
    boolean withinX = this.x <= x && x <= (this.x + CELL_WIDTH);
    boolean withinY = this.y <= y && y <= (this.y + CELL_HEIGHT);
    return withinX && withinY;
  }
  
}
