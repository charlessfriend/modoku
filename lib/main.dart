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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modoku'),),
      body: FocusScope(
        autofocus: true,
        child: Column(
          children: 
            buildSheet(),
          )  
        ),
    );
  }

  List<Row> buildSheet() {
    var rows = List<Row>(3);
    for(int r = 0; r < _modokuEngine.size; r++ ) {
      var sections = List<Widget>();
      for(int c = 0; c < _modokuEngine.size; c++ ) {
        sections.add(buildSection(_modokuEngine.sections[r][c]));
      }
      rows[r] = Row(children: sections);
    }
    return rows;
  }
  
  Widget buildSection(ModokuSection modokuSection, [Color sectionColor = Colors.white]){
    return Expanded(
      child: Container(
        color: sectionColor,
        child: Column(
          children: 
            buildBoxRow(modokuSection),
        ),
      ),
    );
  }
  
  List<Row> buildBoxRow(ModokuSection section) {
    var rows = List<Row>(section.size);
    for(int r = 0; r < section.size; r++ ) {
      var boxes = List<Expanded>();
      for(int c = 0; c < section.size; c++ ) {
        boxes.add(Expanded(
          child: Box(section.modokuBoxes[r][c], 
          onFocus: (modokuBox){
            setState(() {
              //modokuBox.answer = 4;
            });
          },),
        )
       );
        rows[r] = Row(children: boxes);

      }
    }
    return rows;
  }

}