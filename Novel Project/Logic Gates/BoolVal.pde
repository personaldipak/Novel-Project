class BoolVal extends TrackedObject{
  BoolVal(String t){
    super(t);
    
    println("Creating:"+t);
    text=t;
  }
 
    String outputValue(){
    return text;
  }
}