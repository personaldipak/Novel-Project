// import the TUIO library
import TUIO.*;
import java.util.Map;
import java.util.Iterator;
import java.util.Collections;
import java.util.List;
import java.util.Map.Entry;

// declare a TuioProcessing client
TuioProcessing tuioClient;

TrackedObject wirestart;
TrackedObject wireend;

// keep track of duration between object movement
long lastMoveTime=0;
long moveTimeout=1000;

color tempLinkColor=color(255, 200, 0);

// these are some helper variables which are used
// to create scalable graphical feedback
Map<Integer, TrackedObject> objects = 
  Collections.synchronizedMap(new HashMap<Integer, TrackedObject>()); 

HashMap<Integer, PImage> circuitSymbols = new HashMap<Integer, PImage>();
ArrayList<Wiring> wirecomponent = new ArrayList<Wiring>();
ArrayList<ArrayList<TrackedObject>> connectedComponentList = new ArrayList<ArrayList<TrackedObject>>();
ArrayList<ArrayList<TrackedObject>> disconnectedComponentList = new ArrayList<ArrayList<TrackedObject>>();

ArrayList<Target> targets=new ArrayList<Target>();

void setup()
{
  size(displayWidth, displayHeight);
  //size(600, 400);

  circuitSymbols.put(0, loadImage("1.jpg"));
  circuitSymbols.put(1, loadImage("0.jpg"));
  circuitSymbols.put(2, loadImage("1.jpg"));
  circuitSymbols.put(3, loadImage("0.jpg"));
  circuitSymbols.put(4, loadImage("voltmeter.jpg"));
  circuitSymbols.put(5, loadImage("and.jpg"));
  circuitSymbols.put(6, loadImage("bulb.jpg"));


  noFill(); 

  tuioClient  = new TuioProcessing(this);
}


void draw()
{
  background(255);
  //List<TrackedObject> tos = objects.values();
  synchronized(objects) {
    for (TrackedObject to : objects.values()) {
      to.draw();  
      //println(to.angle + " ");
      println("ID " + to.ID + " = " + to.voltage);
    }
  }

  for (Wiring w : wirecomponent) {
    w.draw();
  }
}

void addTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    TrackedObject o; 
    if (id == 5) {
      o = new And();
    } else 
    {
      o = new TrackedObject();
    }

    //if (id == 6) {
    // o = new And();
    //}
    //else 
    //{
    //  o = new TrackedObject();
    // }

    // if (id == 7) {
    //  o = new And();
    // }
    // else 
    // {
    //   o = new TrackedObject();
    // }

    o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
    //o.size=(int)random(50, 100);
    objects.put(id, o);
    o.setImage(circuitSymbols.get(id));
    o.getID(id);
  }
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    if (objects.containsKey(id)) {
      TrackedObject o = objects.get(id);
      float oldX=o.locX;
      float oldY=o.locY;
      o.setPos(tobj.getScreenX(width), tobj.getScreenY(height));
      o.setAngle(tobj.getAngle());
      o.setImage(circuitSymbols.get(id));
      
       if (wireend==o) {
        // if we're still moving the link with the object we were moving:
        // update the time
        lastMoveTime=millis();
      }

      for (TrackedObject obj : objects.values()) {
        if (o!=obj) {
          if (o.touching(obj)) {
            lastMoveTime=millis();
            wirestart=obj;
            wireend=o;
            obj.setHighlight(true);
          } else {
            obj.setHighlight(false);
          }
        }
      }
    }
  }
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  synchronized(objects) {
    if (objects.containsKey(id)) {
      objects.remove(id);
    }
  }
}

// check if object is near
boolean checkIfnear(TrackedObject obj1, TrackedObject obj2) {
  float distance = dist(obj1.getlocX(), obj1.getlocY(), obj2.getlocX(), obj2.getlocY());

  if (distance <= 100.0) {
    return true;
  } else {
    return false;
  }
}

// draws wires between object
void wireConnect(TrackedObject obj1, TrackedObject obj2) {
  //boolean near = dist(tobj.getScreenX(width), tobj.getScreenY(height),tobj2.getScreenX(width),tobj2.getScreenY(height)) <= 75; 
  if (checkIfnear(obj1, obj2)) {
    stroke(#0000FF);
    line(obj1.getlocX(), obj1.getlocY(), obj2.getlocX(), obj2.getlocY());
  } else {
    obj1.setConnection(true);
    obj2.setConnection(true);
    stroke(#FF0000);
    line(obj1.getlocX(), obj1.getlocY(), obj2.getlocX(), obj2.getlocY());
  }
}

void wireDisconnect(TrackedObject obj1, TrackedObject obj2) {
  if (checkIfnear(obj1, obj2)) {
    stroke(#0000FF);
    line(obj1.getlocX(), obj1.getlocY(), obj2.getlocX(), obj2.getlocY());
  } else {
    obj1.setConnection(false);
    obj2.setConnection(false);
    noStroke();
  }
}