class InputField extends Control {
  String text;
  String label;
  int cursorBlink = 0;
  
  public InputField(String text, String label, int x, int y, int width, int height) {
    super(x, y, width, height);
    this.text = text;
    this.label = label;
  }
  
  public String getText() {
    return text;
  }
  
  public void clear() {
    text = "";
  }
  
  public boolean hitTest(int x, int y) {
    return x > this.x && x < this.x + width && y > this.y && y < this.y + height + fonts.TEXTSIZE; 
  }
  
  public void render() {    
    textFont(font);
    String displayText = text;
    int shorten = 0;
    float tw = textWidth(displayText);
    while (tw > this.width) {
      shorten++;
      displayText = text.substring(0, text.length() - shorten);
      tw = textWidth(displayText);      
    } 
    
    fill(hover ? backgroundColorHover: backgroundColor);
    noStroke();
    rect(x, y, width, fonts.TEXTSIZE + 3);
    fill(hover ? foregroundColorHover : foregroundColor);
    text(displayText, x, y + fonts.TEXTSIZE);
    stroke(hover ? foregroundColorHover : foregroundColor);
    line(x, y + fonts.TEXTSIZE + 3, x + width, y + fonts.TEXTSIZE + 3);
    textFont(labelFont);
    text(label, x, y + fonts.TEXTSIZE + fonts.TEXTSIZE + 4);
    
    // Blinking cursor
    textFont(fonts.font);
    if(enabled && isFocused()) {
      cursorBlink++;
      if(cursorBlink > 100) cursorBlink = 0;
      int cursorColor = (int) map(cursorBlink, 0, 100, 100, 255);
      
      stroke(cursorColor);
      line(x + textWidth(displayText) + 2, y, x + textWidth(displayText) + 2, y + fonts.TEXTSIZE - 1);
    }
  }
  
  public void handleKeyPressed() {
    if(!enabled) return;
    
    if (key == CODED) {
    } else if(key == BACKSPACE && text.length() > 0) {
      text = text.substring(0, text.length() - 1);
    } else if(key != ENTER && key != TAB && key != BACKSPACE) {
      text += key;
    }
  }
}
