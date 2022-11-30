class InputFieldSuggestion extends InputField {
  List<String> suggestions = new ArrayList<String>();
  List<String> matches = new ArrayList<String>();
  int selectedSuggestion = 0;
  String searchText = "";

  public InputFieldSuggestion(String text, String label, int x, int y, int width, int height, List<String> suggestions) {
    super(text, label, x, y, width, height);
    this.suggestions = suggestions;
  }

  public void render() {
    super.render();
  }

  private void updateMatches() {
    matches.clear();
    searchText = text;
    for (String s : suggestions) {
      if (s.contains(searchText)) matches.add(s);
    }
  }

  public void handleKeyPressed() {
    super.handleKeyPressed();
    if (key == TAB) {      
      if (matches.size() > 0) {
        text = matches.get(selectedSuggestion);
        selectedSuggestion++;
        if (selectedSuggestion > matches.size() - 1) selectedSuggestion = 0;
      }
    } else {
      selectedSuggestion = 0;
      updateMatches();
    }
  }
}
