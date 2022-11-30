class Button extends Control {
  String label;

  public Button(String label, int x, int y, int width, int height) {
    super(x, y, width, height);
    this.label = label;
  }
  
  public void render() {
    fill(hover ? foregroundColorHover : foregroundColor);
    noStroke();
    rect(x, y, width, height);
    fill(hover ? backgroundColorHover : backgroundColor);
    textFont(labelFont);
    float xo = width / 2 - textWidth(label) / 2;
    float yo = height / 2 + fonts.TEXTSIZESMALL / 2;
    text(label, x + xo, y + yo);
  }
  
  public void clear() {
    label = "";
  }
  
  public String getName() {
    return label;
  }

  public void handleKeyPressed() {
  }
  
  public void handleMouseClicked() {
  }
}
