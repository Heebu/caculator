import 'package:caculator/usables/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = '0';
  String equation = '0';
  String expression = '';
  double equationFontSize = Dimensions.height20 + Dimensions.height50;
  double resultFontSize = Dimensions.height50;

  buttonPressed(String buttonText) {
    setState(
      () {
        if (buttonText == 'C') {
          result = '0';
          equation = '0';
          equationFontSize = Dimensions.height20 + Dimensions.height50;
          resultFontSize = Dimensions.height50;
        } else if (buttonText == '⌦') {
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') {
            equation = '0';
          }
          equationFontSize = Dimensions.height20 + Dimensions.height50;
          resultFontSize = Dimensions.height50;
        } else if (buttonText == '=') {
          resultFontSize = Dimensions.height20 + Dimensions.height50;
          equationFontSize = Dimensions.height50;
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'error';
          }
        } else {
          if (equation == '0') {
            equation = buttonText;
            equationFontSize = Dimensions.height20 + Dimensions.height50;
            resultFontSize = Dimensions.height50;
          } else {
            equation = equation + buttonText;
          }
        }
      },
    );
  }

  Widget myButton(String buttonText, double buttonHeight, Color buttonColor,
      Color textColor) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: buttonHeight * Dimensions.height50 * 15,
      width: Dimensions.width10 * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: FlatButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Dimensions.height20),
        ),
        padding: const EdgeInsets.all(3),
        child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: Dimensions.height30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text(
            'PRIME Calc ',
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: ((context, orientation) => orientation == Orientation.portrait
            ? buildPortrait()
            : buildLandscape()),
      ),
    );
  }

  Column buildPortrait() {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
                top: Dimensions.height5,
                right: Dimensions.width30,
                left: Dimensions.width10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              addAutomaticKeepAlives: true,
              reverse: true,
              children: [
                Text(
                  equation,
                  style: TextStyle(
                      color: Colors.white, fontSize: equationFontSize),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
                top: Dimensions.height5,
                right: Dimensions.width30,
                left: Dimensions.width10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              addAutomaticKeepAlives: true,
              reverse: true,
              children: [
                Text(
                  result,
                  style: TextStyle(
                      color: Colors.white70, fontSize: resultFontSize),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: Dimensions.height10,
                right: Dimensions.width5,
                left: Dimensions.width5,
                bottom: Dimensions.height5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white10),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(children: [
                          myButton('C', .1, Colors.lightGreen, Colors.white),
                          myButton('÷', .1, Colors.green, Colors.white),
                          myButton('×', .1, Colors.green, Colors.white),
                        ]),
                        Row(children: [
                          myButton('7', .1, Colors.white, Colors.green),
                          myButton('8', .1, Colors.white, Colors.green),
                          myButton('9', .1, Colors.white, Colors.green),
                        ]),
                        Row(children: [
                          myButton('4', .1, Colors.white, Colors.green),
                          myButton('5', .1, Colors.white, Colors.green),
                          myButton('6', .1, Colors.white, Colors.green),
                        ]),
                        Row(children: [
                          myButton('1', .1, Colors.white, Colors.green),
                          myButton('2', .1, Colors.white, Colors.green),
                          myButton('3', .1, Colors.white, Colors.green),
                        ]),
                        Row(children: [
                          myButton('.', .1, Colors.white, Colors.green),
                          myButton('0', .1, Colors.white, Colors.green),
                          myButton('00', .1, Colors.white, Colors.green),
                        ]),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        myButton('⌦', .1, Colors.green, Colors.white),
                        myButton('-', .1, Colors.green, Colors.white),
                        myButton('+', .1, Colors.green, Colors.white),
                        myButton('=', .2, Colors.green, Colors.white),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Row buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
                top: Dimensions.height5,
                right: Dimensions.width5,
                left: Dimensions.width5),
            child: ListView(
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              children: [
                Text(
                  equation,
                  style: TextStyle(
                      color: Colors.white, fontSize: equationFontSize),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
                top: Dimensions.height5,
                right: Dimensions.width30,
                left: Dimensions.width10),
            child: ListView(
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              children: [
                Text(
                  result,
                  style: TextStyle(
                      color: Colors.white70, fontSize: resultFontSize),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: Dimensions.height10,
                right: Dimensions.width5,
                left: Dimensions.width5,
                bottom: Dimensions.height5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white10),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(children: [
                          myButton('C', .08, Colors.lightGreen, Colors.white),
                          myButton('÷', .08, Colors.green, Colors.white),
                          myButton('×', .08, Colors.green, Colors.white),
                        ]),
                        Row(children: [
                          myButton('7', .08, Colors.white, Colors.green),
                          myButton('8', .08, Colors.white, Colors.green),
                          myButton('9', .08, Colors.white, Colors.green),
                        ]),
                        Row(children: [
                          myButton('4', .08, Colors.white, Colors.green),
                          myButton('5', .08, Colors.white, Colors.green),
                          myButton('6', .08, Colors.white, Colors.green),
                        ]),
                        Row(children: [
                          myButton('1', .08, Colors.white, Colors.green),
                          myButton('2', .08, Colors.white, Colors.green),
                          myButton('3', .08, Colors.white, Colors.green),
                        ]),
                        Row(children: [
                          myButton('.', .08, Colors.white, Colors.green),
                          myButton('0', .08, Colors.white, Colors.green),
                          myButton('00', .08, Colors.white, Colors.green),
                        ]),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        myButton('⌦', .08, Colors.green, Colors.white),
                        myButton('-', .08, Colors.green, Colors.white),
                        myButton('+', .08, Colors.green, Colors.white),
                        myButton('=', .08 * 2, Colors.green, Colors.white),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
