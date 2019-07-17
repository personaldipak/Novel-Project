
class Target {

  /* Rectangular targets.
   have x, y location location & dimensions.
   Can test whether an object inside them -- contains
   Display colour depends on whether they've been 'hit'.
   */

  int x, y, xSize, ySize, halfXSize, halfYSize;
  
  int objID;

  color fillCol, hitFillCol, strokeCol;
  boolean hit=false; 
  // better to store a list of tracked objects that are inside this target;
  // hit = list non-empty.

  String name="";

  Target(int xx, int yy, int sx, int sy, String n, color fc) {
    x=xx; 
    y=yy; 
    xSize=sx; 
    halfXSize=sx/2;
    ySize=sy;
    halfYSize=sy/2;
    fillCol=fc;
    hitFillCol=color(0, 200, 0, 150);
    strokeCol=color(200);
    name=n;
  }

  void draw() {
    pushStyle();
    if (hit) {
      fill(hitFillCol);
    } 
    else {
      fill(fillCol);
    }
    rectMode(CENTER);
    stroke(strokeCol);
    rect(x, y, xSize, ySize);
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    text(name, x, y);
    popStyle();
  }

  boolean contains(float ox, float oy) {
    // does this target contain the location (ox, oy)? 
    return (ox>x-halfXSize && ox<x+halfXSize && oy>y-halfYSize && oy<y+halfYSize);
  }

  void entered(TrackedObject o) {
    hit=true;
  }
  void left(TrackedObject o) {
    hit=false;
  }
  void moved(TrackedObject o) {
  }
  
  void setOID(int obj) {
    objID = obj;
}
}