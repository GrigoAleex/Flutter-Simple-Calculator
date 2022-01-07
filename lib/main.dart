import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Grigo's Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String _equation = "0";
  Color _equationColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grigo's Calculator"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(
                  left: 10, top: 20, right: 10, bottom: 0),
              child: Text(
                _equation,
                style: TextStyle(fontSize: 38.0, color: _equationColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buildButton("9", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("7", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildButton("6", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("4", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildButton("3", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("1", 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Table(
                    children: [
                      TableRow(children: [buildButton("x", 1, Colors.blue)]),
                      TableRow(children: [buildButton("-", 1, Colors.blue)]),
                      TableRow(children: [buildButton("+", 1, Colors.blue)]),
                      TableRow(
                          children: [buildButton("=", 2, Colors.redAccent)]),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildButton(
      String _buttonText, double _buttonHieght, Color _buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * _buttonHieght,
      color: _buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(double.parse("0")),
            side: const BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () => _buttonPressed(_buttonText),
        child: Text(
          _buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case "C":
          _equation = "0";
          break;
        case "⌫":
          _equation = _equation.substring(0, _equation.length - 1);
          if (_equation == "") {
            _equation = "0";
          }
          break;
        case "=":
          String _expresion =
              _equation.replaceAll('÷', "/").replaceAll('x', "*");

          try {
            _equationColor = Colors.green.shade400;
            _equation = Parser()
                .parse(_expresion)
                .evaluate(EvaluationType.REAL, ContextModel())
                .toString();
          } catch (e) {
            _equationColor = Colors.redAccent;
            _equation = "Error!";
          }
          break;
        default:
          _equationColor = Colors.black;
          _equation == "0" ? _equation = buttonText : _equation += buttonText;
          break;
      }
    });
  }
}
