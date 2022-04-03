int zoom = 30;
final static byte inc = 2;

int ELEMENT_WIDTH = 75;
int ELEMENT_HEIGHT = 50;

int TOTAL_NUMBERS = 3;

int[] numbersList;
ArrayList<Integer> listS = new ArrayList<Integer>();
void setup(){

  size(1280, 720, P3D);
  smooth();
  rectMode(CENTER);
  
  numbersList = new int[TOTAL_NUMBERS];
  for(int i=0; i<TOTAL_NUMBERS; i++) {
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
    case 0: println('0'); return color(255, 0, 0);
    case 1: println('1'); return color(255, 127, 127);
    case 2:
    case 3:
    case 4:
    case 5:
    case 6: println('+'); return color(255, 191, 191);
    case 7: println('7'); return color(255, 255, 0);
    case 8: println('8'); return color(255, 255, 127);
    default: println('D'); return color(255, 255, 255);
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
  PShape structure;
  structure = createShape(GROUP);
  
  int level = 0;
  int index = 0;
  while(index <= numbers.length) {
    
    float centerY = level*ELEMENT_HEIGHT;

      for(int cell=0; cell<((level == 0) ? 1 : 6*level); cell++) { //Get the n° of the cell
        
        if(index >= numbers.length) {break;}
        int n = numbers[index];
        
        //Number of the section, and number of the cell in section
        //Splitting the hexagon into 6 sections, one for each side
        //Number of cells in each section = level n°
        int nbCellsInSection = (level == 0) ? 1 : level*6;
        int nbCellsInsideSection = 3*(level-1)*((level-1)+1)+1; //See sheet for details
        
        int noSection = (index-nbCellsInsideSection) / ceil(float(nbCellsInSection)/6);
        int noCellInSection = (index-nbCellsInsideSection) % ceil(float(nbCellsInSection)/6);
        
        //Extrapolate the coords
        float centerX = cos(2*PI*(noSection*1.0)/6) * (level*ELEMENT_WIDTH) + cos(2*PI*((noSection+2)*1.0)/6) * (noCellInSection*ELEMENT_WIDTH);// + (ELEMENT_WIDTH*noCellInSection);
        float centerZ = sin(2*PI*(noSection*1.0)/6) * (level*ELEMENT_WIDTH) + sin(2*PI*((noSection+2)*1.0)/6) * (noCellInSection*ELEMENT_WIDTH);// + (ELEMENT_WIDTH*noCellInSection);
        
        println(index, level, noSection, noCellInSection, /*nbCellsInSection, nbCellsInsideSection,*/ centerX, centerZ);
        
        if(index == 0) {centerX = 0; centerZ = 0;}
        
        //Get the level
        //Take the direction
        //Use trigo to calculate the direction
        //Multiply by the level to get the distance
        //Get the centers
        //Add the index in level (in the righty direction)
        
        //Get color
        color c = getColor(index);
        c = getColor(index); //Debugging
        //c = color(255, 255, 255); //debugging
        //noStroke();
        println("Index, color: ", index, c);
        fill(getColor(index));
        
        //Draw hexagon
        
        
        //println(centerZ + ewi*cos(2*PI*(3*1.0)/6));
        //println(centerZ + ewi*sin(2*PI*(0*1.0)/6));
        
        structure.addChild(hexagonalPrism(centerX, centerY, centerZ, ELEMENT_WIDTH, ELEMENT_HEIGHT));
        
        index++;
      }
    
    if(index >= numbers.length) {break;}
    
    level++;
  }
  
  return structure;
}



PShape hexagonalPrism(float centerX, float centerY, float centerZ, float hexWidth, float hexHeight) {
  PShape hex = createShape();
  hex.beginShape(TRIANGLES);
  
  float ewi = (1.0*hexWidth)/2;
  float ehh = (1.0*hexHeight)/2;
  
  for(int i=0; i<6; i++) { //Draw one (1) hexagon
    //Triangle 1: top
    hex.vertex(centerX + 0, centerY+ehh, centerZ + 0);
    hex.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), centerY+ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
    hex.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), centerY+ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
    
    //Triangle 2: bottom
    hex.vertex(centerX + 0, centerY-ehh, centerZ + 0);
    hex.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), centerY-ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
    hex.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), centerY-ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
    
    //Triangle 3: wall top
    hex.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), centerY+ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
    hex.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), centerY+ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
    hex.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), centerY-ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
    
    //Triangle 4: wall bottom
    hex.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), centerY+ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
    hex.vertex(centerX + ewi*sin(2*PI*(i*1.0)/6), centerY-ehh, centerZ + ewi*cos(2*PI*(i*1.0)/6));
    hex.vertex(centerX + ewi*sin(2*PI*((i+1)*1.0)/6), centerY-ehh, centerZ + ewi*cos(2*PI*((i+1)*1.0)/6));
  }
  
  hex.endShape();
  return hex;
}
