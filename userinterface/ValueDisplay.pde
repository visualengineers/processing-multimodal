abstract class ValueModel {
  String[] labels;
  String[] values;
  boolean validated = false;

  public boolean isValid() {
    return validated;
  }

  public void invalidate() {
    validated = false;
  }

  public abstract void update();
}

class ValueDisplay extends Control {
  ValueModel model;
  int offset = 0;

  public ValueDisplay(ValueModel model, int x, int y, int width, int height) {
    super(x, y, width, height);
    this.model = model;
  }

  public void render() {
    if (!model.isValid()) model.update();
    if(hover) fill(255); else fill(200);
    int yo = y + fonts.TEXTSIZE;
    for (int i=offset; i < model.values.length; i++) {
      textFont(fonts.labelFont);
      text(model.labels[i], x, yo);
      textFont(fonts.font);
      float xo = width - textWidth(model.values[i]);
      text(model.values[i], x + xo, yo);
      yo += 20;
      if (yo > y + height) break;
    }
    if(hover && model.values.length * 20 > height) {
      fill(255);
      if(mouseY < y + height / 2 && offset > 0)
        triangle(x + width / 2 - 4, y + 4, x + width / 2, y, x + width / 2 + 4, y + 4);
      else if (mouseY >= y + height / 2 && (model.values.length - offset) * 20 > height) 
        triangle(x + width / 2 - 4, y + height - 4, x + width / 2, y + height, x + width / 2 + 4, y + height - 4);
    }
  }

  public void handleMouseClicked() {
    if (isFocused()) {
      if (mouseY < y + height / 2) {
        offset = offset > 0 ? offset - 1 : 0;
      } else if ((model.values.length - offset) * 20 > height) {
        offset = offset + 1;
      }
    }
  }
}
