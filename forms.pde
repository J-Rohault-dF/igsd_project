int zoom = 30;
final static byte inc = 2;

int ELEMENT_WIDTH = 50;
int ELEMENT_HEIGHT = 50;

int[] numbersList;
ArrayList<Integer> listS = new ArrayList<Integer>();
void setup(){

  size(1280, 720, P3D);
  smooth();
  rectMode(CENTER);
  
  numbersList = new int[100];
  for(int i=0; i<100; i++) {
    numbersList[i] = i;
  }
  
  scale(1, -1); //Copied from online, flipping y axis
  translate(0, -height);
 
}


//int testingCounter = 0; //debugging

void draw() {
  
  // rotate l'objet pour mieux voir ce que ca donne 
  lights();
  background(0);
  /*float mX = (mouseX-1000.0)/500.0;
  float mY = (mouseY-1000.0)/500.0;
  translate(mouseX,mouseY);
  rotateX(PI*(mX));
  rotateZ(PI*(mY));*/
  
  //background(0);
  //lights();
  
 
  shape(makeShape(numbersList));
  
  //fill(color(255, 255, 255));
  //box(100); //debugging
  
  //Place the camera
  //camera(5, 15, 5, 0, 0, 0, 0, 1, 0);
  camera(width/2, -height/2, (height/2) / tan(PI/6), 0, 0, 0, 0, 1, 0);
  
  //testingCounter++; //debugging
}



int sumDivisors(int n) {
  int s = 0;
  for(int i=0; i<pow(n, 1/2); i++) {
    if((float(n)/float(i))%1 == 0) {s += i;}
  }
  return s;
}

color getColor(int n) {
  int sd = sumDivisors(n) - n; //Substract n to avoid the doubling later
  
  switch(n) { //Debugging
    case 0: return color(255, 0, 0);
    case 1: return color(255, 127, 127);
    case 2:
    case 3:
    case 4:
    case 5:
    case 6: return color(255, 191, 191);
    case 7: return color(255, 255, 0);
    case 8: return color(255, 255, 127);
    default: return color(255, 255, 255);
  }
  
  /*if(sd == 1) { //Prime
    return color(0, 255, 0);
  } else if(sd == n) { //Perfect
    return color(255, 0, 255);
  } else if(sd < n) { //Deficient
    return color(255, 0, 0);
  } else { //Abundant
    return color(0, 0, 255);
  }*/
}



PShape makeShape(int[] numbers) {
  PShape structure = createShape();
  structure.beginShape(TRIANGLES);
  
  int level = 0;
  int index = 0;
  while(index <= numbers.length) {
    
    float centerY = level*ELEMENT_WIDTH;

      for(int cell=0; cell<((level == 0) ? 1 : 6*level); cell++) { //Get the n° of the cell
        
        if(index >= numbers.length) {break;}
        int n = numbers[index];
        
        //Number of the section, and number of the cell in section
        //Splitting the hexagon into 6 sections, one for each side
        //Number of cells in each section = level n°
        int nbCellsInSection = level;
        int nbCellsInsideSection = 3*(level-1)*((level-1)+1)+1; //See sheet for details
        
        int noSection = (index-nbCellsInsideSection) / 6;
        int noCellInSection = (index-nbCellsInsideSection) % 6;
        
        //Extrapolate the coords
        float centerX = sin(2*PI*(1*noSection)) * (level*ELEMENT_WIDTH) + (ELEMENT_WIDTH*noCellInSection);
        float centerZ = cos(2*PI*(1*noSection)) * (level*ELEMENT_WIDTH) + (ELEMENT_WIDTH*noCellInSection);
        
        //Get the level
        //Take the direction
        //Use trigo to calculate the direction
        //Multiply by the level to get the distance
        //Get the centers
        //Add the index in level (in the righty direction)
        
        //Get color
        color c = getColor(n);
        c = getColor(index); //Debugging
        //c = color(255, 255, 255); //debugging
        //noStroke();
        fill(c);
        
        //Draw hexagon
        
        float ewi = (1*ELEMENT_WIDTH)/2;
        float ehh = (1*ELEMENT_HEIGHT)/2;
        
        for(int i=0; i<6; i++) { //Draw one (1) hexagon
          structure.vertex(centerX + 0, ehh, centerZ + 0); //Triangle 1: top
          structure.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
          structure.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
          
          structure.vertex(centerX + 0, -ehh, centerZ + 0); //Triangle 2: bottom
          structure.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), -ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
          structure.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), -ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
          
          structure.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));//Triangle 3: wall top
          structure.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
          structure.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), -ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
          
          structure.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));//Triangle 4: wall bottom
          structure.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), -ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
          structure.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), -ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
        }
        
        
        index++;
      }
    
    if(index >= numbers.length) {break;}
    
    level++;
  }
  structure.endShape();
  return structure;
}
