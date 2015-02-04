//CS4802 - Assignment 1
//Written by Ceren Savasan
//username: csavasan

void setup() {
       size(600, 600);  //Window dimensions
       background(125);  //Cyan
     }


class Cell{
  int x;  //x-coord
  int y;  //y-coord
  int[] rgb, rgb_next;
  Cell[] aroundMe; //keep track of neighbors
}
