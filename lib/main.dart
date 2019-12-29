import 'package:flutter/material.dart';

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

  Box box1;
  Box box2;
  Box box3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modoku'),),
      body: FocusScope(
        autofocus: true,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                buildSection(Colors.grey.shade300),
                buildSection(),
                buildSection(Colors.grey.shade300),
              ],
            ),
            Row(
              children: <Widget>[
                buildSection(),
                buildSection(Colors.grey.shade300),
                buildSection(),
              ],
            ),
            Row(
              children: <Widget>[
                buildSection(Colors.grey.shade300),
                buildSection(),
                buildSection(Colors.grey.shade300),
              ],
            ),
        ],),
      ),
    );
  }
  
  Widget buildSection([Color sectionColor = Colors.white]){
    return Expanded(
      child: Container(
        color: sectionColor,
        child: Column(
          children: <Widget>[
            buildRow(),
            buildRow(),
            buildRow(),
          ],
        ),
      ),
    );
  }
  
  Row buildRow() {
    return Row(
      children: <Widget>[
        
        Expanded(child: Box(3)),
        Expanded(child: Box(3)),
        Expanded(child: Box(3)),
        
      ],
    );
  }

}