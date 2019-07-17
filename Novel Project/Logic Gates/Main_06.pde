import TUIO.*;
import java.util.Map;
import java.util.Iterator;
import java.util.Collections;
import java.util.List;
import java.util.Map.Entry;

TuioProcessing tuioClient;

HashMap<Integer, PImage> gateimage = new HashMap<Integer, PImage>();
ArrayList<Wire> wires = new ArrayList();

TrackedObject wireStart;
TrackedObject wireEnd;
static int lab = 0;

void setup() {
  size(800, 600);

  gateimage.put(0, loadImage("0.jpg"));// 0
  gateimage.put(1, loadImage("0.jpg"));// 0
  gateimage.put(2, loadImage("0.jpg"));// 0
  gateimage.put(3, loadImage("1.jpg"));// 1
  gateimage.put(4, loadImage("1.jpg"));// 1
  gateimage.put(5, loadImage("1.jpg"));// 1
  gateimage.put(6, loadImage("and.jpg"));// and gate
  gateimage.put(7, loadImage("and.jpg"));// and gate
  gateimage.put(8, loadImage("or-gate.jpg"));// or gate
  gateimage.put(9, loadImage("or-gate.jpg"));// or gate
  gateimage.put(10, loadImage("bulb.jpg"));// Bulb

  noFill();

  tuioClient = new TuioProcessing(this);
}

HashMap<Integer, TrackedObject> objects = new HashMap<Integer, TrackedObject>();

synchronized void draw() {
  background(255);


  //for (Map.Entry<Integer, TrackedObject> entry1 : objects.entrySet()) {
  //  TrackedObject value1 = entry1.getValue();

  //  for (Map.Entry<Integer, TrackedObject> entry2 : objects.entrySet()) {
  //    if (entry2.getKey() > entry1.getKey()) {
  //      TrackedObject value2 = entry2.getValue();

  //      if (value1 != value2) {
  //        if (value1.contact(value2)) {
  //          wireStart = value2;
  //          wireEnd = value1;
  //        }
  //      }

  //      //Gates g = new Gates();
  //      //g.addGates(value1, value2);

  //      ArrayList<Wire> wiregroup = new ArrayList();
  //      for (Wire l : wires) {
  //        if ((l.value1 == value1 && l.value2 == value2) || (l.value2 == value1 && l.value1 == value2)) {
  //          wiregroup.add(l);
  //        }
  //      }
  //      for (int lw = 0; lw < wiregroup.size(); lw++) {
  //        Wire l = wiregroup.get(lw);
  //        int wirelink = (2 * lw - wiregroup.size() + 1);
  //        if (l.value1 == value2) {
  //          wirelink =- wirelink;
  //        }
  //        l.draw(wirelink);
  //      }
  //    }
  //  }
  //}

  for (TrackedObject newobj : objects.values()) {
    newobj.draw();
    // println("ID " + newobj.ID);
  }
  for (Wire w : wires){
    w.draw(1);
  }
 //rawline();
}

void drawline() {
  if (wireStart != null && wireEnd != null) {
    // pushStyle();
    //  stroke(50);
    //line(wireStart.locX, wireStart.locY, wireEnd.locX, wireEnd.locY);
    //popStyle();

    wires.add(new Wire(wireStart, wireEnd, lab));
    lab++;
  }
}

synchronized void addTuioObject(TuioObject tobj) {
  TrackedObject newObj;
  int id = tobj.getSymbolID();
  
  if (id == 0 || id == 1 || id == 2) {//0
    println("False");
    newObj = new BoolVal("F");//
  } 
  else if (id == 3 || id == 4 || id == 5) {//1
    println("True");
    newObj = new BoolVal("T");
  }
  else if (id == 10){
    newObj = new Bulb();
  }
  else if(id == 6 || id == 7){
    newObj = new AndGate();
    //newObj = new Bulb();
  }
  else {
    newObj = new OrGate();
  }
  
   println("==="+newObj.text);

  //synchronized(objects) {
  //TrackedObject newobj = new TrackedObject("" + id);
  newObj.setloc(tobj.getScreenX(width), tobj.getScreenY(height));
  objects.put(id, newObj);
  newObj.setimage(gateimage.get(id));
  newObj.setID(id);
}
//}

synchronized void updateTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  //synchronized(objects) {
  if (objects.containsKey(id)) {
    TrackedObject newobj = objects.get(id); 
    newobj.setloc(tobj.getScreenX(width), tobj.getScreenY(height));
    //bulb();
    //newobj.setimage(gateimage.get(id));
    for(TrackedObject o : objects.values()){
      if(newobj != o && newobj.contact(o) && !connected(newobj, o)){
        Wire w = new Wire(newobj, o, 1);
        wires.add(w);
      }
    }

  }
}

boolean connected(TrackedObject obj1, TrackedObject obj2) {
  for (Wire w : wires) {
    if (w.isConnected(obj1, obj2)) {
      return true;
    }
  }
  return false;
}
//}

synchronized void removeTuioObject(TuioObject tobj) {
  int id = tobj.getSymbolID();
  ArrayList<Wire> wr = new ArrayList<Wire>(wires);

  //synchronized(objects) {
  if (objects.containsKey(id)) {
    TrackedObject t = objects.get(id);
    for (Wire l : wr) {
      if (l.value1 == t || l.value2 == t) {
        wires.remove(l);
      }
    }
    objects.remove(id);
  }
}
//}