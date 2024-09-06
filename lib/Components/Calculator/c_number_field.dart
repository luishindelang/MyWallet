import 'package:flutter/material.dart';
import 'package:mywallet/Components/Calculator/c_calculator_button.dart';
import 'package:mywallet/Style/style.dart';

class CNumberField extends StatelessWidget {
  const CNumberField({
    super.key,
    required this.width,
    required this.onNumPressed,
  });

  final double width;
  final Function(int) onNumPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(1),
              child: Text("1", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(2),
              child: Text("2", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(3),
              child: Text("3", style: textCalcField(textSelected)),
            ),
          ],
        ),
        Row(
          children: [
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(4),
              child: Text("4", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(5),
              child: Text("5", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(6),
              child: Text("6", style: textCalcField(textSelected)),
            ),
          ],
        ),
        Row(
          children: [
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(7),
              child: Text("7", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(8),
              child: Text("8", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(9),
              child: Text("9", style: textCalcField(textSelected)),
            ),
          ],
        ),
        Row(
          children: [
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(10),
              child: Text(".", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(0),
              child: Text("0", style: textCalcField(textSelected)),
            ),
            CCalculatorButton(
              h: width / 3,
              w: width / 3,
              onPressed: () => onNumPressed(-1),
              onLongPressed: () => onNumPressed(-2),
              child: const Icon(
                Icons.backspace_rounded,
                color: textSelected,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
