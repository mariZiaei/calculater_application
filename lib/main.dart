import 'package:calculater/constant.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(calculaterApplication());
}

class calculaterApplication extends StatefulWidget {
  const calculaterApplication({super.key});

  @override
  State<calculaterApplication> createState() => _calculaterApplicationState();
}

class _calculaterApplicationState extends State<calculaterApplication> {
  var inputUser = "";
  var result = '';

  void buttonPress(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text1)),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPress(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, color: getTextColor(text1)),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text2)),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else
              buttonPress(text2);
          },
          child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                text2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, color: getTextColor(text2)),
              )),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: getBackgroundColor(text3),
          ),
          onPressed: () {
            buttonPress(text3);
          },
          child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                text3,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, color: getTextColor(text3)),
              )),
        ),
        TextButton(
          style: TextButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(width: 0, color: Colors.transparent),
              ),
              backgroundColor: getBackgroundColor(text4)),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPress(text4);
            }
          },
          child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                text4,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, color: getTextColor(text4)),
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
              color: backgroundGreyDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      inputUser,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: textGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 38),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Text(
                    result,
                    style: TextStyle(
                        fontSize: 62,
                        fontWeight: FontWeight.bold,
                        color: textGrey),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
                color: backgroundGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getRow('ac', 'ce', '%', '/'),
                    getRow('7', '8', '9', '*'),
                    getRow('4', '5', '6', '-'),
                    getRow('1', '2', '3', '+'),
                    getRow('00', '0', '.', '='),
                  ],
                )),
          ),
        ]))));
  }
}

bool isOperator(String text) {
  var list = ['ac', 'ce', '%', '/', '=', '+', '-', '*'];
  for (var item in list) {
    if (text == item) {
      return true;
    }
  }

  return false;
}

Color getBackgroundColor(String text) {
  if (isOperator(text)) {
    return backgroundGreyDark;
  } else {
    return backgroundGrey;
  }
}

Color getTextColor(String text) {
  if (isOperator(text)) {
    return textGreen;
  } else {
    return textGrey;
  }
}
