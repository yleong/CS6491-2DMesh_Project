//http://processingjs.org/learning/custom/intersect/
//class util
//{
static final int DONT_INTERSECT = 0;
static final int COLLINEAR = 1;
static final int DO_INTERSECT = 2;

static final float eps = 20f;

static int intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, pts P){

  float x = 0, y = 0;
  float a1, a2, b1, b2, c1, c2;
  float r1, r2 , r3, r4;
  float denom, offset, num;

  // Compute a1, b1, c1, where line joining points 1 and 2
  // is "a1 x + b1 y + c1 = 0".
  a1 = y2 - y1;
  b1 = x1 - x2;
  c1 = (x2 * y1) - (x1 * y2);

  // Compute r3 and r4.
  r3 = ((a1 * x3) + (b1 * y3) + c1);
  r4 = ((a1 * x4) + (b1 * y4) + c1);

  // Check signs of r3 and r4. If both point 3 and point 4 lie on
  // same side of line 1, the line segments do not intersect.
  if ((r3 != 0) && (r4 != 0) && same_sign(r3, r4)){
    return DONT_INTERSECT;
  }

  // Compute a2, b2, c2
  a2 = y4 - y3;
  b2 = x3 - x4;
  c2 = (x4 * y3) - (x3 * y4);

  // Compute r1 and r2
  r1 = (a2 * x1) + (b2 * y1) + c2;
  r2 = (a2 * x2) + (b2 * y2) + c2;

  // Check signs of r1 and r2. If both point 1 and point 2 lie
  // on same side of second line segment, the line segments do
  // not intersect.
  if ((r1 != 0) && (r2 != 0) && (same_sign(r1, r2))){
    return DONT_INTERSECT;
  }

  //Line segments intersect: compute intersection point.
  denom = (a1 * b2) - (a2 * b1);

  if (denom == 0) {
    return COLLINEAR;
  }

  if (denom < 0){ 
    offset = -denom / 2; 
  } 
  else {
    offset = denom / 2 ;
  }

  // The denom/2 is to get rounding instead of truncating. It
  // is added or subtracted to the numerator, depending upon the
  // sign of the numerator.
  num = (b1 * c2) - (b2 * c1);
  if (num < 0){
    x = (num - offset) / denom;
  } 
  else {
    x = (num + offset) / denom;
  }

  num = (a2 * c1) - (a1 * c2);
  if (num < 0){
    y = ( num - offset) / denom;
  } 
  else {
    y = (num + offset) / denom;
  }
  
  /*for(int i = 0; i < P.nv; i++)
  {
    float distance = (float)Math.sqrt(Math.pow(x - P.G[i].x, 2) + Math.pow(y - P.G[i].y, 2));
    if(distance < eps) return DONT_INTERSECT;
  }*/
  /*if((Math.abs(x - x1) < eps && Math.abs(y - y1) < eps) || 
  (Math.abs(x - x2) < eps && Math.abs(y - y2) < eps) || 
  (Math.abs(x - x3) < eps && Math.abs(y - y3) < eps) || 
  (Math.abs(x - x4) < eps && Math.abs(y - y4) < eps)) return DONT_INTERSECT;*/

  // lines_intersect
  return DO_INTERSECT;
}

static boolean same_sign(float a, float b){

  return (( a * b) >= 0);
}
