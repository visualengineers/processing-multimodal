import java.time.*;
import java.time.format.DateTimeFormatter;
import java.text.DecimalFormat;
import java.util.*;

int padding = 80;

ControlManager manager;
FontManager fonts;
AppModel model = new AppModel();
SomeDiagramModel diagModel = new SomeDiagramModel();
SomeDiagramModel barModel = new SomeDiagramModel();
ValueModel exampleModel = new ExampleModel();
InputField inputField;

void setup() {  
  fullScreen();
  surface.setTitle("User Interface");
  fonts = new FontManager();  
  manager = new ControlManager(this);
  ValueDisplay totals = new ValueDisplay(exampleModel, padding, 60, 200, 80);
  
  List<String> suggestions = new ArrayList<>(List.of( "Lorem", "Ipsum", "Sit", "Dolor", "Amet" ));
  
  Button updateButton = new Button("UPDATE", padding, 160, 100, 20);
  inputField = new InputField(String.valueOf(model.getMaxNumber()), "MAXIMUM", padding, 200, 100, 20);
  InputFieldSuggestion suggestionInput = new InputFieldSuggestion("", "SUGGESTIONS WITH TAB KEY", padding, 260, 280, 12, suggestions);
  InputFieldTags tagInput = new InputFieldTags("", "TAGS WITH ENTER KEY", padding, 300, 280, 12, suggestions);
  LineDiagram lineDiagram = new LineDiagram(diagModel, "RANDOM STATS", padding + 350, 60, 410, 100);
  BarDiagram bars= new BarDiagram(barModel, "RANDOM BARS", padding + 350, 200, 410, 80);
  
  manager.add(totals);
  manager.add(updateButton);
  manager.add(inputField);
  manager.add(suggestionInput);
  manager.add(tagInput);
  manager.add(lineDiagram);
  manager.add(bars);
}

void draw() {
  clear();
  background(0);
  manager.render();

  textFont(fonts.titleFont);
  fill(255);
  text("User Interface", padding, 40);
}

void mouseMoved() {
  manager.handleMouseMoved();
}

void mouseClicked() {
  manager.handleMouseClicked();
  if (manager.getActiveControlName()=="UPDATE") {
    model.setMaxNumber(parseInt(inputField.getText()));
    exampleModel.update();
    diagModel.invalidate();
    barModel.invalidate();
  }
}

void keyPressed() {
  manager.handleKeyPressed();
  if (keyCode == ESC) {
    exit();
  }
}
