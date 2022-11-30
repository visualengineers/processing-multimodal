abstract class DiagramModel {
  boolean validated = false;
  float[] xCoords;
  float[] yCoords;
  float[] xCoordLabels;
  String[] xLabels;
  int x;
  int y;
  int height;
  int width;
  float max;
  int xStart;
  int xEnd;

  public void setDimensions(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  } 
  
  public void invalidate() {
    validated = false;
  }
  
  public boolean valid() {
    return validated;
  }

  public abstract void updateData();
}
