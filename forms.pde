int zoom = 30;
final static byte inc = 2;

int ELEMENT_SIZE = 50;
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
  
  if(sd == 1) { //Prime
    return color(0, 255, 0);
  } else if(sd == n) { //Perfect
    return color(255, 0, 255);
  } else if(sd < n) { //Deficient
    return color(255, 0, 0);
  } else { //Abundant
    return color(0, 0, 255);
  }
}



PShape makeShape(int[] numbers) {
  PShape structure = createShape();
  
  int level = 0;
  int index = 0;
  while(index <= numbers.length) {
    
    float centerY = level*ELEMENT_SIZE;

      for(int cell=0; cell<((level == 0) ? 1 : 6*level); cell++) {
        
        if(index >= numbers.length) {break;}
        int n = numbers[index];
        
        //Extrapolate the coords
        float centerX = 0;
        float centerZ = 0;
        
        //Get color
        color c = getColor(n);
        c = color(255, 255, 255); //debugging
        noStroke();
        fill(c);
        
        //Draw hexagon
        /*structure.beginShape(QUAD_STRIP);
        structure.endShape();*/
        
        //Draw hexagon
        structure.beginShape(TRIANGLES);
        
        float ewi = (1*ELEMENT_SIZE)/2;
        float ehh = (1*ELEMENT_HEIGHT)/2;
        
        for(int i=0; i<6; i++) {
          structure.vertex(0, ehh, 0); //Triangle 1: top
          structure.vertex(ewi*sin(2*PI*(i*1.0)/6), ehh, ewi*cos(2*PI*(i*1.0)/6));
          structure.vertex(ewi*sin(2*PI*((i+1)*1.0)/6), ehh, ewi*cos(2*PI*((i+1)*1.0)/6));
          
          structure.vertex(0, -ehh, 0); //Triangle 2: bottom
          structure.vertex(ewi*sin(2*PI*(i*1.0)/6), -ehh, ewi*cos(2*PI*(i*1.0)/6));
          structure.vertex(ewi*sin(2*PI*((i+1)*1.0)/6), -ehh, ewi*cos(2*PI*((i+1)*1.0)/6));
          
          structure.vertex(ewi*sin(2*PI*(i*1.0)/6), ehh, ewi*cos(2*PI*(i*1.0)/6));//Triangle 3: wall top
          structure.vertex(ewi*sin(2*PI*((i+1)*1.0)/6), ehh, ewi*cos(2*PI*((i+1)*1.0)/6));
          structure.vertex(ewi*sin(2*PI*(i*1.0)/6), -ehh, ewi*cos(2*PI*(i*1.0)/6));
          
          structure.vertex(ewi*sin(2*PI*((i+1)*1.0)/6), ehh, ewi*cos(2*PI*((i+1)*1.0)/6));//Triangle 4: wall bottom
          structure.vertex(ewi*sin(2*PI*(i*1.0)/6), -ehh, ewi*cos(2*PI*(i*1.0)/6));
          structure.vertex(ewi*sin(2*PI*((i+1)*1.0)/6), -ehh, ewi*cos(2*PI*((i+1)*1.0)/6));
        }
        
        structure.endShape();
        
        index++;
      }
    
    if(index >= numbers.length) {break;}
    
    level++;
  }
    return structure;
}
