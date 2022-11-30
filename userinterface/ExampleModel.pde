class ExampleModel extends ValueModel {
  public void update() {
    labels = new String[4];
    values = new String[4];
    
    labels[0] = "Lorem";
    values[0] = Integer.toString((int)random(model.getMaxNumber()));    
    labels[1] = "Ipsum";
    values[1] = Integer.toString((int)random(model.getMaxNumber()));
    labels[2] = "Dolor"; 
    values[2] = Integer.toString((int)random(model.getMaxNumber()));
    labels[3] = "Amet";
    values[3] = Integer.toString((int)random(model.getMaxNumber()));
    
    validated = true;
  }
}
