import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = '0';
  String equation = '0';
  String expression = '';
  double equationFontSize = 70.sp;
  double resultFontSize = 50.sp;

  buttonPressed(String buttonText) {
    setState(
      () {
        if (buttonText == 'C') {
          result = '0';
          equation = '0';
          equationFontSize = 70.sp;
          resultFontSize = 50.sp;
        } else if (buttonText == '⌦') {
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') {
            equation = '0';
          }
          equationFontSize = 70.sp;
          resultFontSize = 50.sp;
        } else if (buttonText == '=') {
          resultFontSize = 70.sp;
          equationFontSize = 50.sp;
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
            equationFontSize = 70.sp;
            resultFontSize = 50.sp;
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
      height: buttonHeight * 800.h,
      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? 50.w
          : 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: MaterialButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: const EdgeInsets.all(3),
        child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: 30.sp),
        ),
      ),
    );
  }

  _launchURL(Uri url) async {
    launchUrl(url);
  }

  MaterialColor mainColoring = Colors.green;

  @override
  Widget build(BuildContext context) {
    print(50.h * 20);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColoring,
        title: const Center(
          child: Text(
            'PRIME Calculator ',
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        shadowColor: mainColoring.shade500,
        elevation: 10.h,
        child: ListView(
          itemExtent: 100,
          children: [
            ListTile(
              title: Center(
                  child: Text(
                'Prime Calculator',
                style: TextStyle(
                    color: mainColoring,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              )),
            ),

            //colors
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Colors Palette'),
                      content: Text('Change the App color'),
                      actionsOverflowAlignment: OverflowBarAlignment.start,
                      actions: [
                        Wrap(
                          spacing: 20,
                          children: [
                            MaterialButton(
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.green;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.red;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                              //child: Text('Blue')
                            ),
                            MaterialButton(
                              color: Colors.brown,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.brown;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                              //child: Text('Blue')
                            ),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.blue;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              color: Colors.pink,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.pink;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              color: Colors.purple,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.purple;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                title: Text('Color'),
                trailing: Icon(Icons.color_lens_rounded),
              ),
            ),

            //feedbacks
            GestureDetector(
              onTap: () {
                _launchURL(Uri.parse('https://wa.me/2348112006431'));
              },
              child: ListTile(
                title: Text('Feedbacks'),
                trailing: Icon(Icons.feedback),
              ),
            ),

            //github source code
            GestureDetector(
              onTap: () {
                _launchURL(Uri.parse('https://github.com/Heebu'));
              },
              child: ListTile(
                title: Text('Github'),
                trailing: Icon(Icons.repeat),
              ),
            ),
          ],
        ),
      ),
      body: OrientationBuilder(
        builder: ((context, orientation) => orientation == Orientation.portrait
            ? buildPortrait(mainColoring)
            : buildLandscape(mainColoring)),
      ),
    );
  }

  Column buildPortrait(MaterialColor mainColoring) {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 5.h, right: 30.w, left: 10.w),
            child: SingleChildScrollView(
              child: Text(
                equation,
                style:
                    TextStyle(color: Colors.black, fontSize: equationFontSize),
              ),
            ),
          ),
        ),
        Divider(
          color: mainColoring,
          thickness: 5,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(
              top: 5.h,
              right: 30.w,
              left: 10.w,
            ),
            child: SingleChildScrollView(
              child: Text(
                result,
                style: TextStyle(color: Colors.black, fontSize: resultFontSize),
              ),
            ),
          ),
        ),
        Divider(
          color: mainColoring,
          thickness: 5,
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 10.h,
              right: 5.w,
              left: 5.w,
              bottom: 5.h,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                ),
                color: mainColoring.shade50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(children: [
                      myButton(
                          'C', .1, mainColoring.shade900, mainColoring.shade50),
                      myButton('÷', .1, mainColoring, mainColoring.shade50),
                      myButton('×', .1, mainColoring, mainColoring.shade50),
                    ]),
                    Row(children: [
                      myButton('7', .1, Colors.white, mainColoring),
                      myButton('8', .1, Colors.white, mainColoring),
                      myButton('9', .1, Colors.white, mainColoring),
                    ]),
                    Row(children: [
                      myButton('4', .1, Colors.white, mainColoring),
                      myButton('5', .1, Colors.white, mainColoring),
                      myButton('6', .1, Colors.white, mainColoring),
                    ]),
                    Row(children: [
                      myButton('1', .1, Colors.white, mainColoring),
                      myButton('2', .1, Colors.white, mainColoring),
                      myButton('3', .1, Colors.white, mainColoring),
                    ]),
                    Row(children: [
                      myButton('.', .1, Colors.white, mainColoring),
                      myButton('0', .1, Colors.white, mainColoring),
                      myButton('00', .1, Colors.white, mainColoring),
                    ]),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    myButton('⌦', .1, mainColoring, mainColoring.shade50),
                    myButton('-', .1, mainColoring, mainColoring.shade50),
                    myButton('+', .1, mainColoring, mainColoring.shade50),
                    myButton('=', .2, mainColoring, mainColoring.shade50),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Row buildLandscape(MaterialColor mainColoring) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.h,
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      equation,
                      style: TextStyle(
                          color: Colors.black, fontSize: equationFontSize),
                    ),
                  ),
                ),
              ),
              Divider(
                color: mainColoring,
                thickness: 5,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Text(
                      result,
                      style: TextStyle(
                          color: Colors.black, fontSize: resultFontSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: mainColoring,
          thickness: 5,
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 5.h,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
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
                          myButton(
                              'C', .08, mainColoring.shade900, Colors.white),
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
