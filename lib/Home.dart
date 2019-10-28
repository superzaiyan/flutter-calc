import 'package:calc/calculate.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => new _HomeState();
}

TextEditingController operation = new TextEditingController();
TextEditingController output = new TextEditingController();
bool append = false;

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.card_membership),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Flutter-Calc",
              ),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: new NumberDisplay(
                controller: output,
              ),
            ),
          Expanded(
              child: new NumberDisplay(
                controller: operation,
                fontSize: 140.0,
              ),
            ),
          new Keyboard(),
        ],
      ),
    );
  }
}

class NumberDisplay extends StatefulWidget {
  NumberDisplay({this.controller, this.fontSize: 100.0});

  TextEditingController controller;
  double fontSize;

  @override
  _NumberDisplayState createState() =>
      _NumberDisplayState(controller: controller, fontSize: fontSize);
}

class _NumberDisplayState extends State<NumberDisplay> {
  _NumberDisplayState({this.controller, this.fontSize: 80.0});

  TextEditingController controller;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
      focusNode: AlwaysDisableFocus(),
    );
  }
}

class AlwaysDisableFocus extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sys_height = MediaQuery.of(context).size.height;
    var sys_width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              _key('1', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('2', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('3', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('+', sys_height * 0.1, sys_width * 0.2, Colors.blueGrey),
              _key('-', sys_height * 0.1, sys_width * 0.2, Colors.blueGrey),
            ],
          ),
          new Row(
            children: <Widget>[
              _key('4', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('5', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('6', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('*', sys_height * 0.1, sys_width * 0.2, Colors.blueGrey),
              _key('/', sys_height * 0.1, sys_width * 0.2, Colors.blueGrey),
            ],
          ),
          new Row(
            children: <Widget>[
              _key('7', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('8', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('9', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('(', sys_height * 0.1, sys_width * 0.2, Colors.blueGrey),
              _key(')', sys_height * 0.1, sys_width * 0.2, Colors.blueGrey),
            ],
          ),
          new Row(
            children: <Widget>[
              _key('C', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('0', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('.', sys_height * 0.1, sys_width * 0.2, Colors.white38),
              _key('=', sys_height * 0.1, sys_width * 0.4, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  void _addKey(keyValue) {
    if (append == false) {
      if (keyValue.toString() == "=") {
        if (_validOperation(operation.text)) {
          var d = calculate(operation.text);
          output.text = d.toString();
          operation.text = '';
          append = true;
        } else
          output.text = '';
      } else if (keyValue.toString() == "C") {
        operation.text = "";
        output.text = "";
      } else {
        operation.text = operation.text + keyValue;
      }
    } else {
      operation.text =
          _validOperation(keyValue) ? output.text + keyValue : keyValue;
      append = false;
    }
  }

  _key(String i, double h, double w, Color color) {
    return new Container(
      decoration: BoxDecoration(
          color: color, border: Border.all(color: Colors.white30)),
      height: h,
      width: w,
      child: MaterialButton(
        onPressed: () {
          _addKey(i);
        },
        child: new Text(
          i,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  bool _validOperation(String text) {
    return text.contains('/') ||
        text.contains('*') ||
        text.contains('-') ||
        text.contains('+');
  }
}
