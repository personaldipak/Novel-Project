class AndGate extends TrackedObject {

  String outputValue() {
    ArrayList<TrackedObject> input = new ArrayList();
    System.out.println("Size of wires " + wires.size());
    for (Wire w : wires) {
      if (w.value2 == this)
        input.add(w.value1);
    }
    System.out.println("Input size " + input.size());

    if (input.size() != 2) {
      return "X";
    }
    

    for (TrackedObject i : input) {
      if (i.outputValue() == "F" ) {
        return "F";
      }
    }
    return  "T";
  }
}