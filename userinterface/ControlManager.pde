class ControlManager {
  List<Control> controls = new ArrayList<Control>();
  color foregroundColor = color(200);
  color foregroundColorHover = color(255);
  color backgroundColor = color(20);
  color backgroundColorHover = color(50);
  PApplet sketch;
  
  public ControlManager(PApplet sketch) {
    this.sketch = sketch;
    // Method sumInstanceMethod = PApplet.class.getMethod("publicSum", int.class, double.class);
  }
  
  public void add(Control c) {
    c.setFonts(fonts.font, fonts.labelFont);
    controls.add(c);
  }
  
  public void remove(Control c) {
    controls.remove(c);
  }
  
  public void render() {
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
  
  public void handleMouseClicked() {
    for(Control c : controls) {
      c.setFocus(false);
      if(c.hitTest(mouseX, mouseY)) {
        c.setFocus(true);
        c.handleMouseClicked();
      }
    }
  }
  
  public void handleMouseMoved() {
    for(Control c : controls) {
      c.setHover(false);
      if(c.hitTest(mouseX, mouseY)) {
        c.setHover(true);
      }
    }
  }
  
  public void handleKeyPressed() {
    if(getActiveControl() != null) {
      getActiveControl().handleKeyPressed();
    }
  }
}
