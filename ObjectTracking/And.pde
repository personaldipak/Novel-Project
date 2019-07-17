class And extends TrackedObject {
 
  void draw(){
     ellipseMode(CENTER);
     rect(locX, locY, 100, 100);
     fill(0);
     text("and", locX, locY);
      
    //imageMode(CENTER);                                                                                                         
   // pushMatrix();
   // translate(locX, locY);
   // image(componentImg, 0, 0);
   // popMatrix();
  }
  
   
}