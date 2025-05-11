import 'package:flutter/material.dart';
import 'package:mywallet/Components/Calculator/c_number_feld_button.dart';
import 'package:mywallet/Style/style.dart';

class NumberFeld extends StatelessWidget {
  const NumberFeld({super.key, required this.onPressed});

  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CNumberFeldButton(
              onPressed: () => onPressed("AC"),
              text: "AC",
              backgroundColor: numberBackgroundColor,
              borderColor: boxBorderGrey,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("÷"),
              text: "÷",
              backgroundColor: operationBackgroundColor,
              borderColor: operationBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("×"),
              text: "×",
              backgroundColor: operationBackgroundColor,
              borderColor: operationBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("ok"),
              text: "ok",
              backgroundColor: boxBorderDark,
              borderColor: boxBorderDark,
              icon: Icons.check_rounded,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CNumberFeldButton(
              onPressed: () => onPressed("7"),
              text: "7",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("8"),
              text: "8",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("9"),
              text: "9",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("bracket"),
              text: "( )",
              backgroundColor: operationBackgroundColor,
              borderColor: operationBackgroundColor,
              style: numberFeldStyleBrackets,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CNumberFeldButton(
              onPressed: () => onPressed("4"),
              text: "4",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("5"),
              text: "5",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("6"),
              text: "6",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("–"),
              text: "–",
              backgroundColor: operationBackgroundColor,
              borderColor: operationBackgroundColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CNumberFeldButton(
              onPressed: () => onPressed("1"),
              text: "1",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("2"),
              text: "2",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("3"),
              text: "3",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("+"),
              text: "+",
              backgroundColor: operationBackgroundColor,
              borderColor: operationBackgroundColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CNumberFeldButton(
              onPressed: () => onPressed("."),
              text: ".",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("0"),
              text: "0",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("delete"),
              text: "delete",
              backgroundColor: numberBackgroundColor,
              borderColor: numberBackgroundColor,
              icon: Icons.backspace_rounded,
              iconColor: textColor,
            ),
            CNumberFeldButton(
              onPressed: () => onPressed("enter"),
              text: "=",
              backgroundColor: numberBackgroundColor,
              borderColor: boxBorderGrey,
            ),
          ],
        ),
      ],
    );
  }
}
