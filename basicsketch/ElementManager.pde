public class ElementManager {
  PApplet app;
  List<Element> elements = new ArrayList<Element>();
  
  public ElementManager(PApplet app) {
    this.app = app;
    registerListeners();
  }
  
  private void registerListeners() {
    app.registerMethod("draw", this);
    app.registerMethod("mouseEvent", this);
  }
  
  public void draw() {
    for(Element e : elements) {
      e.render();
    }
  }
    
  public void add(Element e) {
    elements.add(e);
  }
  
  public void mouseEvent(MouseEvent event) {
    switch(event.getAction()){
      case MouseEvent.MOVE:
          mouseMoved(event);
          break;
      case MouseEvent.PRESS:
          mousePressed(event);
          break;
      case MouseEvent.RELEASE:
          break;
      case MouseEvent.DRAG:
          break;
      case MouseEvent.WHEEL:
          break;
    }
  }

  public void mouseMoved(MouseEvent event) {
    for(Element e : elements) {
      e.setHover(false);
      if(e.hitTest(event.getX(), event.getY())) {
        e.setHover(true);
      }
    }
  }
  
  public void mousePressed(MouseEvent event) {
    for(Element e : elements) {
      e.setHover(false);
      e.setFocus(false);
      if(e.hitTest(event.getX(), event.getY())) {
        e.setFocus(true);
      }
    }  
  }
}
