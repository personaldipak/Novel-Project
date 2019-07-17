class Wiring {
  TrackedObject start, end;
  
  void draw()
  {
    line(start.locX, start.locY, end.locX, end.locY);
  }
 
 
}