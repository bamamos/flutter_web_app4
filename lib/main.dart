import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _displayText = '';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operator = '';

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clearAll();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
      _setOperator(buttonText);
    } else if (buttonText == '=') {
      _calculateResult();
    } else {
      _appendToDisplay(buttonText);
    }
  }

  void _clearAll() {
    setState(() {
      _output = '0';
      _displayText = '';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
    });
  }

  void _appendToDisplay(String buttonText) {
    setState(() {
      if (_output == '0' && buttonText != '.') {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
      _displayText = _output;
    });
  }

  void _setOperator(String operator) {
    setState(() {
      if (_num1 == '0') {
        _num1 = double.parse(_output);
        _operator = operator;
        _displayText = '';
      }
    });
  }

  void _calculateResult() {
    setState(() {
      if (_displayText.isNotEmpty) {
        _num2 = double.parse(_displayText);
        double result;
        switch (_operator) {
          case '+':
            result = _num1 + _num2;
            break;
          case '-':
            result = _num1 - _num2;
            break;
          case '×':
            result = _num1 * _num2;
            break;
          case '÷':
            result = _num1 / _num2;
            break;
          default:
            result = 0.0;
        }
        _output = result.toString();
        _displayText = _output;
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            _buttonPressed(buttonText);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey,
            textStyle: TextStyle(fontSize: 24.0),
          ),
          child: Text(
            buttonText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('÷'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('×'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildButton('C'),
                      _buildButton('0'),
                      _buildButton('.'),
                      _buildButton('+'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildButton('='),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
