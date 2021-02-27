import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  ButtonPage(this.wt, this.ht, this.st, this.callBack);
  final String st;
  final double wt, ht;
  final Function callBack;
  var btnString = {
    "dot": ".",
    "backspace": Icons.backspace_outlined,
    "eq": "=",
    "add": "+",
    "min": "−",
    "div": "÷",
    "mul": "×",
    "sign": "±",
    "mod": "%",
    "pow": "^",
    "br": "()",
    "sqrt": "√",
    "clear": "C",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wt * 23,
      padding: EdgeInsets.all(wt / 2),
      height: double.infinity,
      child: RawMaterialButton(
        child: btnStringSel(st),
        onPressed: () {
          callBack(st);
        },
        elevation: 2.0,
        fillColor: clrBasedSt(st),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(wt * 10),
        ),
      ),
    );
  }

  Color clrBasedSt(st) {
    switch (st) {
      case "backspace":
        return Colors.white.withOpacity(.2);
        break;
      case "eq":
        return Colors.purpleAccent.withOpacity(.8);
        break;
      case "add":
      case "min":
      case "div":
      case "mul":
        return Colors.purpleAccent.withOpacity(.4);
        break;
      case "sign":
      case "mod":
      case "pow":
      case "br":
      case "sqrt":
        return Colors.orangeAccent.withOpacity(.4);
        break;
      case "clear":
        return Colors.amberAccent.withOpacity(.8);
        break;
      default:
        return Colors.white.withOpacity(.5);
    }
  }

  btnStringSel(st) {
    if (isNumeric(st)) {
      return textBtn(st);
    } else if (st == "backspace") {
      return Icon(btnString[st], size: ht * 6, color: Colors.black);
    } else {
      return textBtn(btnString[st]);
    }
  }

  textBtn(s) {
    return Text(
      s,
      style: TextStyle(
          fontSize: ht * 6, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
