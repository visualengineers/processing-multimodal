public class ControlManager {
  List<Control> controls = new ArrayList<Control>();
  color foregroundColor = color(200);
  color foregroundColorHover = color(255);
  color backgroundColor = color(20);
  color backgroundColorHover = color(50);
  PApplet sketch;
  
  public ControlManager(PApplet sketch) {
    this.sketch = sketch;
    registerListeners();
  }
  
  private void registerListeners() {
    sketch.registerMethod("draw", this);
    sketch.registerMethod("mouseEvent", this);
    sketch.registerMethod("keyEvent", this);
  }
  
  public void keyEvent(KeyEvent event){
    switch(event.getAction()){
      case KeyEvent.PRESS:
        keyPressed(event);
        break;
      case KeyEvent.RELEASE:
        keyReleased(event);
      break;
    }
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
  
  public void add(Control c) {
    c.setFonts(fonts.font, fonts.labelFont);
    controls.add(c);
  }
  
  public void remove(Control c) {
    controls.remove(c);
  }
  
  public void draw() {
    for(Control c : controls) {
      c.render();
    }
  }
  
  public Control getActiveControl() {
    for(Control c : controls) {
      if(c.isFocused()) return c;
    }
    return null;
  }
  
  public String getActiveControlName() {
    Control c = getActiveControl();
    if(c != null) return c.getName();
    return "";
  }
  
  public void mousePressed(MouseEvent event) {
    for(Control c : controls) {
      c.setFocus(false);
      if(c.hitTest(event.getX(), event.getY())) {
        c.setFocus(true);
        c.handleMouseClicked();
      }
    }
  }
  
  public void mouseMoved(MouseEvent event) {
    for(Control c : controls) {
      c.setHover(false);
      if(c.hitTest(event.getX(), event.getY())) {
        c.setHover(true);
      }
    }
  }
  
  public void keyPressed(KeyEvent event) {
    if(getActiveControl() != null) {
      getActiveControl().handleKeyPressed();
    }
  }
}
