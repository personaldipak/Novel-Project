class TrackedObject{
  color textCol;
  
  String text;
  
  int ID;
  boolean highlight=false;
  color highlightCol;
  float locX, locY;
  float angle=0;
  int size=60;
  int voltage = 0;
  int path =0;
  int x, y;
  
  PImage componentImg;
  
  boolean connected = false;

  
  void draw(){
    noFill();
    

     if(ID == 6 && voltage == 15) {
     noStroke();
     ellipseMode(CENTER);
     fill(#ffff00);
     ellipse(locX, locY, 300, 300);
    }

    imageMode(CENTER);

    pushMatrix();
    translate(locX, locY);
    image(componentImg, 0, 0);
    popMatrix();
    
  }
  
  void setPos(float x, float y){
    locX=x; locY=y; 
  }
  
  void shiftPos(float dx, float dy){
    locX+=dx; locY+=dy;
  }
  
  void setAngle(float a){
    angle=a;
  }
  
  void setImage(PImage img) {
    componentImg=img;
  }
  
  void setConnection(boolean con) {
    connected = con;
  }
  
  void setSize(int s) {
    size = s;
  }
  
  
  public float getlocX() {
    return locX;
  }
  
  public boolean isConnected() {
    return connected;
  }
  
  public float getlocY() {
    return locY;
  }  
  
  void addVoltage(int v) {
    voltage = v;
  }
  
  void getID(int id) {
    ID = id;
  }
  
  void setHighlight(boolean h) {
    highlight=h;
  }
 
 boolean touching(TrackedObject obj) {
    return (dist(x, y, obj.x, obj.y) < (size + obj.size)/2);
  }
  
}