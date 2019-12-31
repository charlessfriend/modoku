import 'package:flutter/material.dart';
import 'package:modoku/modokuEngine.dart';

import 'box.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: Modoku(),
    );
  }
}

class Modoku extends StatefulWidget {
  @override
  _ModokuState createState() => _ModokuState();
}

class _ModokuState extends State<Modoku> {

  ModokuEngine _modokuEngine = ModokuEngine(3);
  ModokuBox _selectedModokuBox;
  bool _editMode = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modoku'),),
      body: FocusScope(
        autofocus: true,
        child: Column(
          children: <Widget>[
            ModokuSheet(_modokuEngine,
              onSelectedBoxChanged: (modokuBox) => _selectedModokuBox = modokuBox ,),
            Row(
              children: buildAnswerButtons()
              ,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete_outline,
                    size: 45,),
                  onPressed: (){
                    setState(() {
                      _selectedModokuBox.answer = '';
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit,
                    size: 45,
                    color: _editMode ? Colors.redAccent[700] : Colors.black,
                    ),
                  onPressed: (){
                    setState(() {
                      _editMode = !_editMode;
                    });
                  },
                ),
              ],
            )
          ],
        )  
        ),
    );
  }

  List<Widget> buildAnswerButtons() {
    var answerButtons = List<Widget>();
    for(int answer = 1; answer <= _modokuEngine.size * _modokuEngine.size; answer++){
      answerButtons.add(
        Expanded(
          child: FlatButton(
            child: Text(answer.toString(),
              style: TextStyle(fontSize: 45,)
              ), 
              onPressed: () {
                setState(() {
                  if (_editMode) {
                    var row = (answer / _selectedModokuBox.size).ceil() - 1;
                    var col = answer % _selectedModokuBox.size - 1;
                    if (col == -1) col = 2;
                    _selectedModokuBox.notes[row][col] = !_selectedModokuBox.notes[row][col];
                  }
                  else
                    _selectedModokuBox.answer = answer.toString();
                });
              },
            ),
        )
      );
    }
    return answerButtons;
  }

}

class ModokuSheet extends StatelessWidget {
  final ModokuEngine modokuEngine;
  final ValueChanged<ModokuBox> onSelectedBoxChanged;

  const ModokuSheet(this.modokuEngine, {@required this.onSelectedBoxChanged} );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
      children: 
      buildSheet(),
      ),
    );
  }

  List<Row> buildSheet() {
    var rows = List<Row>(modokuEngine.size);
    for(int r = 0; r < modokuEngine.size; r++ ) {
      var sections = List<Widget>();
      for(int c = 0; c < modokuEngine.size; c++ ) {
        sections.add(buildSection(modokuEngine.sections[r][c]));
      }
      rows[r] = Row(children: sections);
    }
    return rows;
  }
  
  Widget buildSection(ModokuSection modokuSection, [Color sectionColor = Colors.white]){
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1
          )
        ),
        child: Column(
          children: 
            buildBoxRow(modokuSection),
        ),
      ),
    );
  }
  
  List<Widget> buildBoxRow(ModokuSection section) {
    var rows = List<Widget>(section.size);
    for(int r = 0; r < section.size; r++ ) {
      var boxes = List<Expanded>();
      for(int c = 0; c < section.size; c++ ) {
        boxes.add(Expanded(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Box(section.modokuBoxes[r][c], 
            onFocus: (modokuBox){
              onSelectedBoxChanged(modokuBox);
            },),
          ),
        )
       );
        rows[r] = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: boxes);

      }
    }
    return rows;
  }
}