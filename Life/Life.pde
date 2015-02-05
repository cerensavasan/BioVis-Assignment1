//CS4802 - Assignment 1
//Written by Ceren Savasan
//username: csavasan

//window size
static int windowWidth = 600;
static int windowHeight = 600;

boolean start;

Grid grid;

//initialize program
void setup() {
  size(windowWidth, windowHeight);  //Window dimensions
  grid = new Grid(100,100);
  grid.init();
  grid.randomBoard();
  start = true;
}

void draw(){
  background(0);  //black
  grid.display();
  if(start){
    delay(200);
    grid.update();
  }
}


//pause function
void keyPressed(){
  if(key == 'p'){
     start = !start;
  }
  if(key == 'c'){
     grid.clear();
  }
  if(key == 'r'){
     grid.randomBoard();
  }  
}

void mousePressed(){
  grid.toggleCell();
}
