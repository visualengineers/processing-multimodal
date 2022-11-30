abstract class Control {
  int x;
  int y;
  int width;
  int height;
  boolean focus = false;
  boolean hover = false;
  boolean enabled = true;
  PFont font;
  PFont labelFont;
  color foregroundColor = color(200);
  color foregroundColorHover = color(255);
  color backgroundColor = color(20);
  color backgroundColorHover = color(50);
  
  public Control(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  public void setColors(color fg, color fgHover, color bg, color bgHover) {
    this.foregroundColor = fg;
    this.foregroundColorHover = fgHover;
    this.backgroundColor = bg;
    this.backgroundColorHover = bgHover;
  }
  
  public void setFonts(PFont font, PFont labelFont) {
    this.font = font;
    this.labelFont = labelFont;
  }
  
  public boolean isFocused() {
    return this.focus;
  }
  
  public void setFocus(boolean focus) {
    this.focus = focus;
  }
  
  public void setHover(boolean hover) {
    this.hover = hover;
  }
  
  public void setEnabled(boolean enabled) {
    this.enabled = enabled;
  }
  
  public boolean hitTest(int x, int y) {
    return x > this.x && x < this.x + width && y > this.y && y < this.y + height; 
  }
  
  public String getName() {
    return "Control"; 
  }
  
  public void clear() {
  }
  
  public void handleMouseClicked() {
  }
  
  public void handleKeyPressed() {
  }
  
  public abstract void render();
}
