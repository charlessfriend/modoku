import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  final int size;
  _BoxState _boxState;

  Box(this.size);

  @override
  _BoxState createState() {
      _boxState = _BoxState();
     return _boxState;
  }

  unFocus(bool hasFocus) {
    //_boxState.unFocus(hasFocus);
    //print('focusChanged $size $hasFocus');
  }
  
}
    
class _BoxState extends State<Box> {
  List<bool> _pencilVisibility;
  Color _borderColor = Colors.black;
  bool _hasFocus;
  FocusNode _focusNode;

  @override
  void initState(){
    super.initState();
     _pencilVisibility = List<bool>(widget.size * widget.size);
    _pencilVisibility = new List.generate(widget.size * widget.size, (i) => true);

  }

  @override
  Widget build(BuildContext context) {
    return        
      Focus(
        onFocusChange: (focus){
          setState(() {
            _hasFocus = _focusNode.hasFocus;
            _borderColor = _hasFocus ? Colors.green : Colors.black;
          });
        },
        child: Builder(
          builder: (BuildContext context) {
            _focusNode = Focus.of(context);
            _hasFocus = _focusNode.hasFocus;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _focusNode.requestFocus();
                });
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: getDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getRows(),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Center(
                      child: AutoSizeText("5",
                        style : TextStyle(fontSize: 40)
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      );
  }

  Decoration getDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        color: _borderColor,
        width: 1,
        ),
      );
  }

  List<Row> getRows() {
    var rows = List<Row>();
    for(int i = 0; i < widget.size; i++) {
      rows.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getPencils(i),
          )
      );
    }
    return rows;
  }

  List<Widget> getPencils(int rowNumber) {
    var pencils = List<Visibility>();
    var start = rowNumber * widget.size;
    for(int i = start; i < start + widget.size; i++){
      pencils.add(
        Visibility(
          visible: _pencilVisibility[i],
          child: Text(
            (i + 1).toString(),
            style: TextStyle(
              fontSize: 10
            ),
          )
        )
      );
    }
    return pencils;
  }
}