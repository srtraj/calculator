import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class FunPage {
  var btnString = {
    "dot": ".",
    "backspace": "",
    "eq": "=",
    "add": "+",
    "min": "-",
    "div": "÷",
    "mul": "×",
    "sign": "±",
    "mod": "%",
    "pow": "^",
    "br": "()",
    "sqrt": "√",
    "clear": "C",
  };

  validateInput(String inp, String out, String val) {
    String exp;
    switch (val) {
      case "clear":
        return [true, "", ""];
        break;
      case "br":
        exp = bracket_fun(inp);
        break;
      case "dot":
        exp = dot_fun(inp);
        break;
      case "sign":
        exp = signChange_fun(inp);
        break;
      case "backspace":
        exp = backSpace_fun(inp);
        break;
      case "eq":
        while (inp.length > 1 &&
            (!isNumeric(inp[inp.length - 1]) && inp[inp.length - 1] != ")"))
          inp = inp.substring(0, inp.length - 1);
        return [true, EvaluteInput(inp), "", ""];
        break;
      case "sqrt":
      case "pow":
      case "min":
      case "mul":
      case "div":
      case "mod":
      case "pow":
      case "add":
        exp = op_fun(inp, val);
        break;
      default:
        int i = inp.length - 1;
        inp = i > 0 && inp[i] == ")" ? inp + btnString["mul"] : inp;
        int cnt = 0;
        while (i >= 0 && (isNumeric(inp[i]) || inp[i] == btnString["dot"])) {
          i--;
          cnt++;
        }
        if (cnt < 15) {
          exp = inp + val;
        } else
          return [false, exp, out, "Can't enter more than 15 digits!!!"];
    }
    if (exp == inp)
      return [false, "", "", "Invalid input!!!"];
    else {
      exp = lineBrack_fun(exp);
      return [true, exp, EvaluteInput(exp), ""];
    }
  }

  lineBrack_fun(String exp) {
    int opF = 0;
    int opL = 0;
    opF = exp.lastIndexOf("\n") > 0 ? exp.lastIndexOf("\n") : 0;
    if (exp.length - opF > 23) {
      for (int i = exp.length - 1; i > opF; i--) {
        if (!isNumeric(exp[i]) && exp[i] != ".") {
          exp = exp.substring(0, i) + "\n" + exp.substring(i);
          break;
        }
      }
    }
    return exp;
  }

  signChange_fun(exp) {
    String last_num = "";
    String st = exp;
    int cnt = 0;
    if (exp.length != 0 &&
        (isNumeric(exp[exp.length - 1]) || exp[exp.length - 1] == '.') &&
        exp != "0") {
      for (int i = exp.length - 1; i >= 0; i--)
        if (isNumeric(exp[i]) || exp[i] == '.') {
          last_num = exp[i] + last_num;
          cnt++;
        } else if (exp[i] == '-') {
          cnt++;
          last_num =
              removeTrailingZero((-1 * double.parse(last_num)).toString());
          break;
        } else
          break;
      last_num = removeTrailingZero((-1 * double.parse(last_num)).toString());
      if (cnt == exp.length)
        st = last_num;
      else if (double.parse(last_num) > 0 &&
          (exp[exp.length - cnt - 1] == ")" ||
              isNumeric(exp[exp.length - cnt - 1]))) {
        st = exp.substring(0, exp.length - cnt) + "+" + last_num;
      } else
        st = exp.substring(0, exp.length - cnt) + last_num;
    }
    return st;
  }

  bracket_fun(ex) {
    String exp = ex;
    int br = '('.allMatches(exp).length - ')'.allMatches(exp).length;
    if (exp.length == 0) {
      exp = exp + '(';
    } else {
      String last_char = exp[exp.length - 1];
      if (isNumeric(last_char) || ')' == last_char) {
        if (br != 0)
          exp = exp + ')';
        else
          exp = exp + btnString["mul"] + "(";
      } else if (last_char == ".") if (br != 0)
        exp = exp + '0)';
      else
        exp = exp + "0" + btnString["mul"] + "(";
      else {
        exp = exp + '(';
      }
    }
    return exp;
  }

  dot_fun(exp) {
    if (exp.length == 0 || !isNumeric(exp[exp.length - 1]))
      exp = exp + "0.";
    else if (isNumeric(exp[exp.length - 1])) exp = exp + '.';
    return exp;
  }

  backSpace_fun(String inp) {
    if (inp.isNotEmpty) {
      int len = inp.length;
      if (len > 1 &&
          inp[len - 1] == "(" &&
          (inp[len - 2] == btnString["sqrt"] ||
              inp[len - 2] == btnString["pow"])) {
        return inp.substring(0, len - 2);
      }
      if (inp.lastIndexOf("\n") + 1 == len - 1) len--;
      return inp.substring(0, len - 1);
    }
    return inp;
  }

  op_fun(String exp, String val) {
    String op = val == "pow" ? btnString[val] + "(" : btnString[val];
    int len = exp.length;
    if (val == "sqrt") {
      if (len > 0) {
        if (exp[len - 1] == ".")
          exp = exp + "0" + btnString["mul"] + op + "(";
        else if (isNumeric(exp[len - 1]) || exp[len - 1] == ")")
          exp = exp + btnString["mul"] + op + "(";
        else
          exp = exp + op + "(";
      } else
        exp = exp + op + "(";
    } else if (val == "min") {
      if (len <= 1)
        exp = exp + op;
      else if (exp[len - 1] == ".")
        exp = exp + "0" + op;
      else if (isNumeric(exp[len - 1]) ||
          exp[len - 1] == "(" ||
          exp[len - 2] == ")" ||
          isNumeric(exp[len - 2])) exp = exp + op;
    } else if (len != 0 && exp[len - 1] != btnString["pow"]) {
      String last_dig = exp[len - 1];
      if (isNumeric(last_dig) || last_dig == ')') {
        exp = exp + op;
      } else if (last_dig == ".") exp = exp + "0" + op;
    } else if (len == 0 && val == "sqrt") {
      exp = btnString["sqrt"];
    }
    return exp;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String removeTrailingZero(String string) {
    if (!string.contains('.')) {
      return string;
    }
    string = string.replaceAll(RegExp(r'0*$'), '');
    if (string.endsWith('.')) {
      string = string.substring(0, string.length - 1);
    }
    return string;
  }

  String EvaluteInput(String inp) {
    String exp = "";
    if (inp.isNotEmpty &&
        (isNumeric(inp[inp.length - 1]) || inp[inp.length - 1] == ")")) {
      int br = '('.allMatches(inp).length - ')'.allMatches(inp).length;
      for (int i = 0; i < br; i++) inp = inp + ")";
      inp = inp.replaceAll(btnString["mul"], "*");
      inp = inp.replaceAll(btnString["min"], "-");
      inp = inp.replaceAll(btnString["add"], "+");
      inp = inp.replaceAll(btnString["div"], "/");
      inp = inp.replaceAll(btnString["sqrt"], "sqrt");
      inp = inp.replaceAll("\n", "");
      Parser p = Parser();
      Expression ex = p.parse(inp);
      exp =
          removeTrailingZero(ex.evaluate(EvaluationType.REAL, null).toString());

      exp = exp.contains("e+")
          ? double.parse(exp.substring(0, exp.indexOf("e+")))
                  .toStringAsFixed(10) +
              btnString["mul"] +
              "10" +
              btnString["pow"] +
              "(" +
              exp.substring(exp.indexOf("e+") + 2) +
              ")"
          : exp;
    }
    return exp;
  }
}
