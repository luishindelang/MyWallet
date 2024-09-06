import 'package:flutter/material.dart';
import 'package:mywallet/Components/Calculator/c_calculator_button.dart';
import 'package:mywallet/Style/style.dart';

class COperationField extends StatelessWidget {
  const COperationField({
    super.key,
    required this.width,
    required this.onCalcPressed,
  });

  final double width;
  final Function(String) onCalcPressed;

  @override
  Widget build(BuildContext context) {
    final double height = width * 4 / 5;
    return Container(
      color: forground,
      child: Column(
        children: [
          CCalculatorButton(
            h: height,
            w: width,
            onPressed: () => onCalcPressed("÷"),
            child: Text("÷", style: textCalcField(textSelected)),
          ),
          CCalculatorButton(
            h: height,
            w: width,
            onPressed: () => onCalcPressed("×"),
            child: Text("×", style: textCalcField(textSelected)),
          ),
          CCalculatorButton(
            h: height,
            w: width,
            onPressed: () => onCalcPressed("−"),
            child: Text("−", style: textCalcField(textSelected)),
          ),
          CCalculatorButton(
            h: height,
            w: width,
            onPressed: () => onCalcPressed("+"),
            child: Text("+", style: textCalcField(textSelected)),
          ),
          CCalculatorButton(
            h: height,
            w: width,
            onPressed: () => onCalcPressed("enter"),
            child: Text("=", style: textCalcField(textSelected)),
          ),
        ],
      ),
    );
  }
}
