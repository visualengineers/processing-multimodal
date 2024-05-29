class SomeDiagramModel extends DiagramModel {
  DecimalFormat df2 = new DecimalFormat("###,###.##");
  
  public void updateData() {
    List<Double> data = new ArrayList<Double>();

    for(int i=0;i<50;i++) {
      float r = random(model.getMaxNumber());
      data.add(Double.valueOf(r));
    }

    xStart = 0;
    xEnd = 49;

    int numEntries = 0;
    max = 0;
    for (Double value : data) {
      numEntries++;
      max = max < value ? value.floatValue() : max;
    }

    xCoords = new float[numEntries];
    yCoords = new float[numEntries];
    xCoordLabels = new float[numEntries];
    xLabels = new String[numEntries];
    int counter = 0;
    for (Double entry : data) {      
      float xo = map(counter, 0, numEntries, 0, width-10);
      float yo = height - map(entry.intValue(), 0, max, 0, height-2);
      xCoords[counter] = x + xo + 9;
      yCoords[counter] = y + yo + 1;
      xLabels[counter] = df2.format(entry.floatValue()) + " (" + counter + ")";
      xCoordLabels[counter] = xCoords[counter];
      counter++;      
    }
    
    this.validated = true;
  }
}
