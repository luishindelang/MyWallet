import 'package:flutter/material.dart';
import 'package:mywallet/Components/Calculator/c_operation_field.dart';
import 'package:mywallet/Components/Calculator/c_number_field.dart';
import 'package:mywallet/DB/Service/s_calculator.dart';
import 'package:mywallet/Style/style.dart';

class CCalculatorField extends StatelessWidget {
  const CCalculatorField({
    super.key,
    required this.number,
    required this.onPressed,
    required this.onCalcPressed,
  });

  final String number;
  final Function(String) onPressed;
  final Function(String) onCalcPressed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: forgroundSecondery,
      child: Row(
        children: [
          CNumberField(
            width: screenWidth * 0.75,
            onNumPressed: (value) => onPressed(addNumToNum(number, value)),
          ),
          COperationField(
            width: screenWidth * 0.25,
            onCalcPressed: (value) => onCalcPressed(value),
          ),
        ],
      ),
    );
  }
}
