import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';
  String operation = '';
  double firstNum = 0;
  double secondNum = 0;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
        operation = '';
        firstNum = 0;
        secondNum = 0;
      } else if (value == "+" || value == "-" || value == "x" || value == "/") {
        firstNum = double.tryParse(input) ?? 0;
        operation = value;
        input = '';
      } else if (value == '=') {
        secondNum = double.tryParse(input) ?? 0;
        switch (operation) {
          case '+':
            result = (firstNum + secondNum).toString();
            break;
          case '-':
            result = (firstNum - secondNum).toString();
            break;
          case 'x':
            result = (firstNum * secondNum).toString();
            break;
          case '/':
            result = secondNum != 0 ? (firstNum / secondNum).toString() : 'Error';
            break;
          default:
            result = 'Error';
        }
        input = '';
        operation = '';
      } else {
        input += value;
        result = input;
      }
    });
  }

  Widget buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20.0),
        ),
        onPressed: () => buttonPressed(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              child: Text(
                result,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('x'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('C'),
                    buildButton('0'),
                    buildButton('='),
                    buildButton('+'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
