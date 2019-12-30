import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modoku/modokuEngine.dart';

class Box extends StatelessWidget {
  
  final ModokuBox modokuBox;
  final ValueChanged<ModokuBox> onFocus;

  Box(this.modokuBox, {this.onFocus});

  @override
  Widget build(BuildContext context) {
    var _focusNode;
    var _hasFocus = false;
    var borderColor = Colors.black;

    return        
      Focus(
        onFocusChange: (focus){
            _hasFocus = _focusNode.hasFocus;
            if (_hasFocus) {
              onFocus(modokuBox);
            }
        },
        child: Builder(
          builder: (BuildContext context) {
            _focusNode = Focus.of(context);
            _hasFocus = _focusNode.hasFocus;
            borderColor = _hasFocus ? Colors.green : Colors.black;
            return GestureDetector(
              onTap: () {
                  _focusNode.requestFocus();
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 45,
                    height: 45,
                    decoration: getDecoration(borderColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getRows(),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Center(
                      child: AutoSizeText(modokuBox.answer.toString(),
                        style : TextStyle(fontSize: 30)
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

  Decoration getDecoration(Color borderColor) {
    return BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        color: borderColor,
        width: 1,
        ),
      );
  }

  List<Row> getRows() {
    var rows = List<Row>(modokuBox.size);
    for(int r = 0; r < modokuBox.size; r++) {
      var notes = List<Visibility>();
      for(int c = 0; c < modokuBox.size; c++) {
        notes.add(Visibility(
          visible: modokuBox.notes[r][c],
          child: Text(
            ((r * modokuBox.size) + (c + 1)).toString(),
            style: TextStyle(
              fontSize: 10
            ),
          )
          )
        );
        rows[r] = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: notes);
      }
    }
    return rows;
  }
}