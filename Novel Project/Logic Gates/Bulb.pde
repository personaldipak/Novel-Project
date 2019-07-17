class Bulb extends TrackedObject {
 private boolean value = false;

 String outputValue() {
    ArrayList<TrackedObject> input = new ArrayList();
for (Wire w : wires) {
      if (w.value2 == this)
        input.add(w.value1);
    }
    if (input.isEmpty()) {
      return "X";
    }

    for (TrackedObject i : input) {
      if (i.outputValue() == "F" ) {
        return "F";
      }
    }
    value = true;
    return  "T";
  }
  
  //@Override
    void draw() {

      if(value) {
        if(true) {
      //    noStroke();
          ellipseMode(CENTER);
          fill(#ffff00);
          ellipse(locX, locY, 150, 150);
          
        }
      }
      super.draw();
   }
  
}