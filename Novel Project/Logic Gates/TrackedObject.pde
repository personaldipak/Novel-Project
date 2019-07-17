class TrackedObject {
  
  
  PImage gateimage;
  int ID;
  float locX, locY;
  float angle = 0;
  int size = 60;
  String text;
  
  boolean connected = false;
  
  TrackedObject(String t) {
    text = t;
  }
  
  TrackedObject() {
  }
  
  String outputValue(){
    return "X";
  }
  // this is the old code
  void draw() {
    
    noFill();
    
    imageMode(CENTER);
    pushMatrix();
    translate(locX, locY);
    rotate(angle);
    image(gateimage, 0, 0);
    popMatrix();
    
    if(ID == 5 && gateInput1 == 1){
      ellipseMode(CENTER);
      fill(50);
      ellipse(150, 150, 200, 200);
     //       if (ID == 10)
     // noStroke();
     // ellipseMode(CENTER);
     //fill(#ffff00);
    }
    fill(255,0,0);
    text("output:" + outputValue(), locX, locY);
  }
  
  void setloc (float x, float y) {
    this.locX = x;
    this.locY = y;
  }
  
  void moveloc (float mx, float my) {
    locX += mx;
    locY += my;
  }
  
  void setangle (float a) {
    angle = a;
  }
  
  void setimage (PImage image) {
    gateimage = image;
  }
  
  public float getlocX() {
    return locX;
  }
  
  public float getlocY() {
    return locY;
  }
  
  void setID (int id) {
    ID = id;
  }
  
  boolean contact (TrackedObject gate) {
    return (dist(locX, locY, gate.locX, gate.locY) < (50 + gate.size)/2);
  }
  ////////////////////GATES/////////////////
  
  int gateInput1 = -1;
  int gateInput2 = -1;
  int gateOutput = -1;
  boolean outputUsed = false;
  
  void gateInput1 (int i1){
    gateInput1 = i1;
  }
  void gateInput2 (int i2){
    gateInput2 = i2;
  }
  void gateOutput (int o){
    gateOutput = o;
  }
  void outputUsed(boolean u){
    outputUsed = u;
  }
}