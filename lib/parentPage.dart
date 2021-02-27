import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import 'functionPage.dart';
import 'keyBoard/keyboardPage.dart';
import 'outputPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String exp = "";
  String op = "";
  final Map<String, int> states = {};

  keyPress(val) {
    var res = FunPage().validateInput(exp, op, val);
    switch (res[0]) {
      case true:
        exp = res[1];
        op = res[2];
        break;
      case false:
        toastmessage(res[3]);
        break;
    }
    setState(() {});
  }

  void toastmessage(String msg) {
    //Add depencies "fluttertoast: ^3.1.0"
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP //
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, Constraints) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(flex: 16, child: OutputPage(exp, op)),
                Expanded(flex: 1, child: Container()),
                Expanded(flex: 24, child: KeyBoardPage(keyPress)),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          );
        },
      ),
    );
  }
}
