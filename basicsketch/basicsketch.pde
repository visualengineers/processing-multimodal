import processing.event.*;
import java.util.*;

ElementManager manager;

void setup() {
  size(900,600);
  manager = new ElementManager(this);
  WeirdElement we = new WeirdElement("I am weird", 10, 10, 200, 200);
  manager.add(we);
}

void draw() {
  background(80);  
}
