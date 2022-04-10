int zoom = 30;
final static byte inc = 2;

int ELEMENT_WIDTH = 75;
int ELEMENT_HEIGHT = 50;

int[] polynomeL = {0, 1, 0};
int[] polynomeR = {0, 1, 0};

int TOTAL_NUMBERS = 100;

int[] numbersListL;
int[] numbersListR;

ArrayList<Integer> listS = new ArrayList<Integer>();
void setup(){

  size(1280, 720, P3D);
  smooth();
  rectMode(CENTER);
  
  numbersListL = new int[TOTAL_NUMBERS];
  calculateNumbers(numbersListL, polynomeL);
  
  numbersListR = new int[TOTAL_NUMBERS];
  calculateNumbers(numbersListR, polynomeR);
  
  scale(1, -1); //Copied from online, flipping y axis
  translate(0, -height);
}



int frameCounter = 0;
void draw() {
   
  lights();
  background(0);
  noStroke();
  
  pushMatrix();
  translate(-500, -300, 0);
  drawPolynomeInterface(polynomeL);
  translate(0, 300, 0);
  rotateY(float(frameCounter)/100);
  shape(makeShape(numbersListL)); //Makes the shape n°1
  popMatrix();
  
  pushMatrix();
  translate(500, -300, 0);
  drawPolynomeInterface(polynomeR);
  translate(0, 300, 0);
  rotateY(float(frameCounter)/100);
  shape(makeShape(numbersListR)); //Makes the shape n°2
  popMatrix();
  
  //Place the camera
  //camera(5, 15, 5, 0, 0, 0, 0, 1, 0);
  camera(0, -height, (height*0.75) / tan(PI/6), 0, 0, 0, 0, 1, 0);
  
  frameCounter++;
}



void keyPressed() {
  if(key == 'a') {polynomeL[0]++; calculateNumbers(numbersListL, polynomeL);}
  if(key == 'z') {polynomeL[1]++; calculateNumbers(numbersListL, polynomeL);}
  if(key == 'e') {polynomeL[2]++; calculateNumbers(numbersListL, polynomeL);}
  if(key == 'q') {polynomeL[0]--; calculateNumbers(numbersListL, polynomeL);}
  if(key == 's') {polynomeL[1]--; calculateNumbers(numbersListL, polynomeL);}
  if(key == 'd') {polynomeL[2]--; calculateNumbers(numbersListL, polynomeL);}
  
  if(key == 'i') {polynomeR[0]++; calculateNumbers(numbersListR, polynomeR);}
  if(key == 'o') {polynomeR[1]++; calculateNumbers(numbersListR, polynomeR);}
  if(key == 'p') {polynomeR[2]++; calculateNumbers(numbersListR, polynomeR);}
  if(key == 'k') {polynomeR[0]--; calculateNumbers(numbersListR, polynomeR);}
  if(key == 'l') {polynomeR[1]--; calculateNumbers(numbersListR, polynomeR);}
  if(key == 'm') {polynomeR[2]--; calculateNumbers(numbersListR, polynomeR);}
}
