int zoom = 30;
final static byte inc = 2;

int ELEMENT_WIDTH = 75;
int ELEMENT_HEIGHT = 50;

int TOTAL_NUMBERS = 100;

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



int frameCounter = 0;
void draw() {
  
  // rotate l'objet pour mieux voir ce que ca donne 
  lights();
  background(0);
  /*float mX = (mouseX-1000.0)/500.0;
  float mY = (mouseY-1000.0)/500.0;
  translate(mouseX,mouseY);
  rotateX(PI*(mX));
  rotateZ(PI*(mY));*/
  
  pushMatrix();
  translate(-500, 0, 0);
  rotateY(float(frameCounter)/100);
  shape(makeShape(numbersList)); //Makes the shape n°1
  popMatrix();
  
  pushMatrix();
  translate(500, 0, 0);
  rotateY(float(frameCounter)/100);
  shape(makeShape(numbersList)); //Makes the shape n°2
  popMatrix();
  
  //Place the camera
  //camera(5, 15, 5, 0, 0, 0, 0, 1, 0);
  camera(0, -height, (height*0.75) / tan(PI/6), 0, 0, 0, 0, 1, 0);
  
  frameCounter++;
}



int sumDivisors(int n) {
  int s = 0;
  for(int i=1; i<n; i++) {
    if(n%i == 0) {s += i;}
  }
  return s;
}

color getColor(int n) {
  int sd = sumDivisors(n);
  
  if(sd == 1) { //Prime
    return color(255, 0, 255);
  } else if(sd == n) { //Perfect
    return color(0, 0, 255);
  } else if(sd < n) { //Deficient
    return color(127, 0, 0);
  } else { //Abundant
    return color(0, 127, 0);
  }
}



PShape makeShape(int[] numbers) {
  PShape structure;
  structure = createShape(GROUP);
  
  int level = 0;
  int index = 0;
  int shapeHeight = floor(sqrt(numbers.length-(1/4)/3) - 1/2); //Inverse of 3n²+3n+1 which is the number of hexagons in a pyramid of height n
  
  while(index <= numbers.length) {
    
    float centerY = level*ELEMENT_HEIGHT - (1.0*ELEMENT_HEIGHT*shapeHeight)/2; //First part adds height for the level, second part moves it back down to center the height

      for(int cell=0; cell<((level == 0) ? 1 : 6*level); cell++) { //Get the n° of the cell
        
        if(index >= numbers.length) {break;}
        int n = numbers[index];
        
        //Get the level
        //Take the direction
        //Use trigo to calculate the direction
        //Multiply by the level to get the distance
        //Get the centers
        //Add the index in level (in the righty direction)
        
        //Number of the section, and number of the cell in section
        //Splitting the hexagon into 6 sections, one for each side
        //Number of cells in each section = level n°
        int nbCellsInSection = (level == 0) ? 1 : level*6;
        int nbCellsInsideSection = 3*(level-1)*((level-1)+1)+1; //See sheet for details
        
        int noSection = (index-nbCellsInsideSection) / ceil(float(nbCellsInSection)/6);
        int noCellInSection = (index-nbCellsInsideSection) % ceil(float(nbCellsInSection)/6);
        
        //Extrapolate the coords
        float centerX = cos(2*PI*(noSection*1.0)/6) * (level*(ELEMENT_WIDTH-10)) + cos(2*PI*((noSection+2)*1.0)/6) * (noCellInSection*(ELEMENT_WIDTH-10)); //Pourquoi (ELEMENT_WIDTH-10) et pas seulement ELEMENT_WIDTH ? Pas la moindre idée
        float centerZ = sin(2*PI*(noSection*1.0)/6) * (level*(ELEMENT_WIDTH-10)) + sin(2*PI*((noSection+2)*1.0)/6) * (noCellInSection*(ELEMENT_WIDTH-10));
        
        //println(index, level, noSection, noCellInSection, /*nbCellsInSection, nbCellsInsideSection,*/ centerX, centerZ);
        
        if(index == 0) {centerX = 0; centerZ = 0;}
        
        //Get color
        fill(getColor(n));
        
        //Draw hexagon
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
