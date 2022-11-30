class FontManager {
  PFont font;
  PFont labelFont;
  PFont titleFont;
  int TEXTSIZE = 14;
  int TEXTSIZESMALL = 10;
  int TEXTSIZELARGE = 28;

  public FontManager() {
    font = createFont("fonts/ChicagoFLF.ttf", TEXTSIZE);
    labelFont = createFont("fonts/ChicagoFLF.ttf", TEXTSIZESMALL);
    titleFont = createFont("fonts/ChicagoFLF.ttf", TEXTSIZELARGE);
  }
}
