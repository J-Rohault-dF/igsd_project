

int sumDivisors(int n) {
  int s = 0;
  for(int i=1; i<n; i++) {
    if(n%i == 0) {s += i;}
  }
  return s;
}



color getColor(int n) {
  if(n == 0) {return color(255);}
  if(n < 0) {return color(191);}
  
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



void calculateNumbers(int[] nl, int[] poly) {
  for(int i=1; i<nl.length; i++) {
    nl[i] = int(pow(i,2) * poly[0]) + (i*poly[1]) + poly[2];
  }
}
