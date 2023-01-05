//Tic Tac Toe Client
//Make X
import processing.net.*;
//all info transfered across internet/network by strings--> reading in string ofo text

//2variables
Client myClient;//variable

//Tic Tac Toe Server
int [][]grid; //2d Array

void setup() {
  size(600, 600);
  //            r c (0,1,2)   r=row, c=col(umn)
  grid= new int[3][3];
  //grid[0][1]=5; //sett certain row and column to 5
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(50);

  //incoming = "";

  //INSTANTIATE???
  //             sketch              //Must match port numbers client #
  myClient = new Client (this, "10.32.46.151", 34567);
}

void draw() {
  background(255);
  stroke(0);
  line(0, 200, 600, 200);
  line(0, 400, 600, 400);
  line(200, 0, 200, 600);
  line(400, 0, 400, 600);




  //drawing X's adn O's
  int row=0;
  int col=0;
  while (row<3) {
    //print(grid[row][col]);
    drawXO(row, col);//This translating to here:read fr/column.ro
    col++;
    if  (col==3) {
      col=0;
      row++;
    }
  }
  fill(0);
  text(mouseX+"," +mouseY, mouseX, mouseY);

  //listening/reading code
  if (myClient.available()>0) {//are messages available(???)
    String incoming = myClient.readString();//will print nothign when start skentch
    int r= int (incoming.substring(0, 1));//makes string to int, right?
    int c= int (incoming.substring(2, 3));
    grid[r][c]=1;
  }
}


void drawXO (int row, int col) {
  pushMatrix();
  translate(row*200, col*200);//putting there numnber back into cordinates--it was divided into array #, we multiply back into x/y cordintate, which'l be translated
  if  (grid[row][col]==1) circ();
  if (grid[row][col]==2) ex();//not 100%, this might be problkem


  popMatrix();
}
void circ() {
  fill(255);
  ellipse(100, 100, 180, 180);
}
void ex() {
  line(20, 20, 180, 180);
  line(180, 20, 20, 180);
}

//assign X and O's
void mouseReleased() {
  int row=mouseX/200;//ex, 500/200 =2.5, round up to 3. This because row cordinate is 500. 3 is the row number which it is supposed to be at
  int col = mouseY/200;
  if (grid [row][col]==0)
  grid[row][col]=2; //X
      myClient.write(row +","+col);

  //println(row +","+col);//cnfrm what send for debug
}
