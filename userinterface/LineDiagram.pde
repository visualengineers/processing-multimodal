class LineDiagram extends Control {
  DiagramModel model;
  String label;
  DecimalFormat df2 = new DecimalFormat("###,###.##");

  public LineDiagram(DiagramModel model, String label, int x, int y, int width, int height) {
    super(x, y, width, height);
    this.label = label;
    this.model = model;
    model.setDimensions(x, y, width, height);
  }

  public void render() {
    if (!model.valid()) model.updateData();
    
    noFill();
    stroke(255);
    rect(x, y, width, height);

    for (int i=1; i < model.xCoords.length; i++) {
      line(model.xCoords[i-1], model.yCoords[i-1], model.xCoords[i], model.yCoords[i]);
    }

    fill(200);
    textFont(fonts.labelFont);
    text(label, x, y - 4);
    text(df2.format(model.max), x + width + 4, y + fonts.TEXTSIZESMALL);
    text(df2.format(model.max/2), x + width + 4, y + (height / 2) + (fonts.TEXTSIZESMALL/2));
    text("0", x + width + 4, y + height);

    if (width > 500) {
      for (int i=0; i < model.xCoordLabels.length - 1; i++) {
        text(model.xStart + i + 1, model.xCoordLabels[i], y + height + fonts.TEXTSIZESMALL + 2);
      }
    } else {
      text(model.xStart, x, y + height + fonts.TEXTSIZESMALL + 2);
      text(model.xEnd, x + width - textWidth(Integer.toString(model.xEnd)), y + height + fonts.TEXTSIZESMALL + 2);
    }

    if (hover) {
      String lab = getLabel(mouseX);
      if(!lab.isEmpty()) {
        textFont(fonts.labelFont);
        stroke(150);
        line(mouseX, y+1, mouseX, y+height-1);
        fill(255);
        noStroke();
        rect(mouseX + 6, mouseY - fonts.TEXTSIZESMALL - 6, textWidth(lab) + 4, fonts.TEXTSIZESMALL + 6);
        fill(0);            
        text(lab, mouseX + 8, mouseY - 4);
      }
    }
  }
  
  public String getLabel(float x) {
    float area = ((width - 2) / model.xCoords.length) / 2;
    for(int i=1; i<model.xCoords.length; i++) {
      if(model.xCoords[i] + area > x) return model.xLabels[i];   
    }
    return "";
  }
}
