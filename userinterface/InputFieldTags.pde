class InputFieldTags extends InputField {
  List<String> tags = new ArrayList<String>();
  List<String> selectedTags = new ArrayList<String>();
  String match = null;
  int cursorBlink = 0;

  public InputFieldTags(String text, String label, int x, int y, int width, int height, List<String> tags) {
    super(text, label, x, y, width, height);
    this.tags = tags;
  }
  
  public List<String> getSelectedTags() {
    return selectedTags;
  }
  
  public void clear() {
    super.clear();
    selectedTags.clear();
    match = null;
  }

  public String getMatch() {
    if (text.length() < 2) return null;
    for (String tag : tags) {
      if (tag.startsWith(text)) return tag;
    }
    return null;
  }
  
  public void addTags(String[] newTags) {
    for(int i=0; i<newTags.length; i++) {
      selectedTags.add(newTags[i]);
    }
  }

  public void render() {    
    fill(hover ? backgroundColorHover: backgroundColor);
    noStroke();
    rect(x, y, width, fonts.TEXTSIZE + 3);

    textFont(labelFont);
    float xo = x;
    for (String selected : selectedTags) {
      float tw = textWidth(selected);
      // TODO: Set tag background color
      fill(230);
      rect(xo, y + 2, tw + 4, fonts.TEXTSIZE - 1);      
      fill(backgroundColor);
      text(selected, xo + 2, y + fonts.TEXTSIZE - 2);
      xo += tw + 10;
    } 

    textFont(font);
    fill(hover ? foregroundColorHover : foregroundColor);
    text(text, xo, y + fonts.TEXTSIZE);
    textFont(labelFont);
    text(label, x, y + fonts.TEXTSIZE + fonts.TEXTSIZE + 4);
    textFont(font);
    float offset = textWidth(text);    
    if (match != null) {
      // TODO: Set dimmed foreground color
      fill(hover ? 200 : 140);
      text(match.replaceFirst(text, ""), xo + offset, y + fonts.TEXTSIZE);
    }
    stroke(hover ? foregroundColorHover : foregroundColor);
    line(x, y + fonts.TEXTSIZE + 3, x + width, y + fonts.TEXTSIZE + 3);

    if (isFocused() && enabled) {
      cursorBlink++;
      if (cursorBlink > 100) cursorBlink = 0;
      int cursorColor = (int) map(cursorBlink, 0, 100, 100, 255);

      stroke(cursorColor);
      float cursorOffset = match == null ? xo + offset + 2 : textWidth(match.replaceFirst(text, "")) + xo + offset + 2;
      line(cursorOffset, y, cursorOffset, y + fonts.TEXTSIZE - 1);
    }
  }

  public void handleKeyPressed() {
    if(!enabled) return;
    
    int textLength = text.length(); // Make sure we do not delete if text in field has a letter before
    super.handleKeyPressed();
    match = getMatch();
    if (key == ENTER) {
      if (match != null && !match.isEmpty()) {
        if(!selectedTags.contains(match)) selectedTags.add(match);
      } else {
        if(!selectedTags.contains(text)) selectedTags.add(text);
      }
      text = "";
      match = null;
    }
    if (key == BACKSPACE && text.isEmpty() && textLength == 0 && selectedTags.size() > 0) {      
      selectedTags.remove(selectedTags.size() - 1);
    }
  }
}
