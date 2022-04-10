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
        if(index == 0) {centerX = 0; centerZ = 0;}
        //println(index, level, noSection, noCellInSection, /*nbCellsInSection, nbCellsInsideSection,*/ centerX, centerZ);
        
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



void drawPolynomeInterface(int[] poly) {
  fill(color(255));
  
  /*rect(0, 0, 10, 10);
  rect(30, 0, 10, 10);
  rect(60, 0, 10, 10);*/
  
  textSize(50);
  textAlign(CENTER);
  text(str(poly[0])+"n² + "+str(poly[1])+"n + "+str(poly[2]), 0, 0);
  
  /*rect(0, 60, 10, 10);
  rect(30, 60, 10, 10);
  rect(60, 60, 10, 10);*/
}
