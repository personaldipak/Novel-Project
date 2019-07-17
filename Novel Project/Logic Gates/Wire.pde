class Wire {
  
  String label = "";
  TrackedObject value1;
  TrackedObject value2;
  
  Wire(TrackedObject f, TrackedObject t, int lab) {
    value1 = f;
    value2 = t;
    label = "" + lab;
  }
  
  void draw (int wirelink) {
    pushStyle();
    pushMatrix();
    noFill();
    line(value1.locX, value1.locY, value2.locX, value2.locY);
    stroke(50);
    popMatrix();
    popStyle();
  }

  boolean isConnected(TrackedObject a, TrackedObject b) {
    if ((value1 == a && value2 == b) || (value1 == b && value2 == a)) {
      return true;
    }
    return false;
  }
}