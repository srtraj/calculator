import 'package:flutter/material.dart';

import 'btnPage.dart';

class KeyBoardPage extends StatelessWidget {
  KeyBoardPage(this.callBack);
  Function callBack;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        final ht = Constraints.maxHeight / 100;
        final wt = Constraints.maxWidth / 100;
        return Container(
          padding: EdgeInsets.fromLTRB(wt * 3, ht, wt * 3, ht),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonPage(wt, ht, "clear", callBack),
                    ButtonPage(wt, ht, "br", callBack),
                    ButtonPage(wt, ht, "sqrt", callBack),
                    ButtonPage(wt, ht, "mul", callBack),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonPage(wt, ht, "pow", callBack),
                    ButtonPage(wt, ht, "mod", callBack),
                    ButtonPage(wt, ht, "sign", callBack),
                    ButtonPage(wt, ht, "div", callBack),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonPage(wt, ht, "7", callBack),
                    ButtonPage(wt, ht, "8", callBack),
                    ButtonPage(wt, ht, "9", callBack),
                    ButtonPage(wt, ht, "min", callBack),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonPage(wt, ht, "4", callBack),
                    ButtonPage(wt, ht, "5", callBack),
                    ButtonPage(wt, ht, "6", callBack),
                    ButtonPage(wt, ht, "add", callBack),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                ButtonPage(wt, ht, "1", callBack),
                                ButtonPage(wt, ht, "2", callBack),
                                ButtonPage(wt, ht, "3", callBack),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                ButtonPage(wt, ht, "dot", callBack),
                                ButtonPage(wt, ht, "0", callBack),
                                ButtonPage(wt, ht, "backspace", callBack),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ButtonPage(wt, ht, "eq", callBack),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
