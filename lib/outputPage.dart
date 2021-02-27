import 'package:flutter/material.dart';

class OutputPage extends StatelessWidget {
  OutputPage(this.inp, this.out);
  String inp, out;
  TextEditingController textCnt;

  @override
  Widget build(BuildContext context) {
    textCnt = TextEditingController(text: inp);
    return LayoutBuilder(builder: (context, Constraints) {
      final ht = Constraints.maxHeight / 100;
      final wt = Constraints.maxWidth / 100;
      return Container(
        padding: EdgeInsets.fromLTRB(wt * 2, ht * 6, wt * 2, ht),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: Text(inp,
                      style: TextStyle(
                          fontSize: inp.length >= 18 ? ht * 8 : ht * 11),
                      textAlign: TextAlign.right),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  out == "" ? out : "= " + out,
                  style: TextStyle(
                      fontSize: ht * 8, color: Colors.grey.withOpacity(.8)),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
