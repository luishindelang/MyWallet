import 'package:flutter/material.dart';
import 'package:mywallet/Components/Calculator/c_calculator_field.dart';

class CCalculator extends StatefulWidget {
  const CCalculator({
    super.key,
    required this.calcList,
    required this.onPressed,
  });

  final List<String> calcList;
  final Function(String, String?) onPressed;

  @override
  State<CCalculator> createState() => _CCalculatorState();
}

class _CCalculatorState extends State<CCalculator> {
  String _number = "";
  String? _operationType;
  double? _oldNum;

  String? _completeCalculation;

  String get _numberText => _number.isEmpty ? "0" : _number;

  void setOperation(String type, double num) {
    _operationType = type;
    if (_number.isNotEmpty) {
      if (_oldNum == null) {
        _oldNum = num;
      } else {
        _oldNum = calculateNum(num);
      }

      if (_completeCalculation == null) {
        _completeCalculation = "$_number$_operationType";
      } else {
        _completeCalculation = "$_completeCalculation$_number$_operationType";
      }
    } else {}
    _number = "";
  }

  double calculateNum(double newNum) {
    double result = 0;
    if (_oldNum != null) {
      switch (_operationType) {
        case "÷":
          result = _oldNum! / newNum;
          break;
        case "×":
          result = _oldNum! * newNum;
          break;
        case "−":
          result = _oldNum! - newNum;
          break;
        case "+":
          result = _oldNum! + newNum;
          break;
      }
    }
    return result;
  }

  void onCalcPressed(String type) {
    double num = double.parse(_numberText);
    if (type == "enter") {
      if (_operationType != null && _completeCalculation != null) {
        String result = cutZero(calculateNum(num));
        String summ = "$_completeCalculation$_number=$result";
        if (_number.isEmpty) {
          int length = _completeCalculation!.length;
          String newComplete = _completeCalculation!.substring(0, length - 1);
          summ = "$newComplete = $result";
        }
        widget.calcList.insert(0, summ);
        _number = result;

        reset();
      } else {
        _number = "";
      }
    } else {
      setOperation(type, num);
    }
  }

  void reset() {
    _operationType = null;
    _oldNum = null;
    _completeCalculation = null;
  }

  String cutZero(double num) {
    return num.toString().replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
  }

  @override
  Widget build(BuildContext context) {
    return CCalculatorField(
      number: _number,
      onPressed: (value) {
        if (value == "delete") {
          _number = "";
          _completeCalculation = null;
          widget.calcList.clear();
          reset();
        } else {
          _number = value;
        }
        widget.onPressed(_numberText, _completeCalculation);
      },
      onCalcPressed: (value) {
        onCalcPressed(value);
        widget.onPressed(_numberText, _completeCalculation);
      },
    );
  }
}
