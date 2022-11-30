class BarDiagram extends Control {
  DiagramModel model;
  String label;

  public BarDiagram(DiagramModel model, String label, int x, int y, int width, int height) {
    super(x, y, width, height);
    this.model = model;
    this.label = label;
    model.setDimensions(x, y, width, height);
  }

  public void render() {
    if (!model.valid()) model.updateData();

    noFill();
    stroke(255);
    rect(x, y, width, height);

    fill(255);
    noStroke();
    for (int i=0; i < model.xCoords.length; i++) {
      rect(model.xCoords[i], model.yCoords[i], 6, height - (model.yCoords[i] - y));
    }    

    textFont(fonts.labelFont);
    text(label, x, y - 4);

    text(model.xStart, x, y + height + fonts.TEXTSIZESMALL + 2);
    text(model.xEnd, x + width - textWidth(Integer.toString(model.xEnd)), y + height + fonts.TEXTSIZESMALL + 2);

    if (hover) {
      String lab = getLabel(mouseX);
      if (!lab.isEmpty()) {
        textFont(fonts.labelFont);
        fill(255);
        noStroke();
        rect(mouseX + 6, mouseY - fonts.TEXTSIZESMALL - 6, textWidth(lab) + 4, fonts.TEXTSIZESMALL + 6);
        fill(0);            
        text(lab, mouseX + 8, mouseY - 4);
      }
    }
  }

  public String getLabel(float x) {
    float area = ((width - 2) / model.xCoords.length) ;
    for (int i=0; i<model.xCoords.length; i++) {
      if (model.xCoords[i] + area> x) return model.xLabels[i];
    }
    return "";
  }
}
