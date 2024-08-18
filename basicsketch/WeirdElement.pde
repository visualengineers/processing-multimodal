class WeirdElement extends Element {
  String label;

  public WeirdElement(String label, int x, int y, int width, int height) {
    super(x, y, width, height);
    this.label = label;
  }
  
  public void render() {
    noStroke();
    fill(0);
    if(this.hover) {
      fill(133);
    } else if(this.focus) {
      fill(190); 
    }
    rect(x,y,width,height);
    fill(255);
    text(label, x + 10, y + 30);
  }
}
