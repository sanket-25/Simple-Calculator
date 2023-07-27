import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fucked_up_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var userInput = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "C") {
      input = '';
      output = '';
    } else if (value == "<<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      userInput = input;
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideInput = true;
      outputSize = 52;
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          Expanded(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: black,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(hideInput ? '' : input,
                            style:
                                TextStyle(fontSize: 48, color: Colors.white)),
                        SizedBox(height: 0),
                        Text(output,
                            style: TextStyle(
                                fontSize: outputSize, color: Colors.white)),
                        SizedBox(height: 0),
                      ]))),
          Row(
            children: [
              button(text: "C"),
              button(text: "%"),
              button(text: "<<"),
              button(text: "/")
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "*")
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-")
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+")
            ],
          ),
          Row(
            children: [
              button(text: "00"),
              button(text: "0"),
              button(text: "."),
              button(text: "=")
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = purple}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            primary: buttonBgColor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
