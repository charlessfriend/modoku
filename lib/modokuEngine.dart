
class ModokuEngine {
  int size;
  List<List<ModokuSection>> sections;

  ModokuEngine(this.size) {
    buildSections();
  }
    
  void buildSections() {
    sections  = List<List<ModokuSection>>();
    for(int r = 0; r < size; r++ ) {
      sections.add(List<ModokuSection>());
      for(int c = 0; c < size; c++ ) {
        sections[r].add(ModokuSection(size));
      }
    }
  }
}

class ModokuSection {
  int size;
  List<List<ModokuBox>> modokuBoxes;

  ModokuSection(this.size){
    modokuBoxes  = List<List<ModokuBox>>();
    for(int r = 0; r < size; r++ ) {
      modokuBoxes.add(List<ModokuBox>());
      for(int c = 0; c < size; c++ ) {
        modokuBoxes[r].add(ModokuBox(size));
      }
    }
  }
}

class ModokuBox {
  int size;
  List<List<bool>> notes;
  int correctAnswer = 5;
  int answer = 5;

  ModokuBox(this.size){
    notes  = List<List<bool>>();
    for(int r = 0; r < size; r++ ) {
      notes.add(List<bool>());
      for(int c = 0; c < size; c++ ) {
        notes[r].add(true);
      }
    }
  }
}