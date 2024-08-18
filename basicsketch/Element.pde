abstract class Element {
  int x;
  int y;
  int width;
  int height;
  boolean focus = false;
  boolean hover = false;
  boolean enabled = true;
 
  public Element(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  public void setHover(boolean hover) {
    this.hover = hover;
  }
  
  public void setFocus(boolean focus) {
    this.focus = focus;
  }
  
  public boolean hitTest(int x, int y) {
    return x > this.x && x < this.x + width && y > this.y && y < this.y + height; 
  }
  
  abstract void render();
}
