import 'package:flutter/material.dart';
import 'package:mywallet/DB/Service/s_calculator.dart';
import 'package:mywallet/Style/style.dart';

class CShowNumber extends StatelessWidget {
  const CShowNumber({
    super.key,
    required this.icon,
    required this.number,
    required this.operation,
    required this.calculation,
  });

  final IconData icon;
  final String number;
  final String? operation;
  final List<String> calculation;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int operationWidth = (screenWidth / 14).round();
    final int numberWidth = (screenWidth / 60).round();
    final operationText = operation != null ? "$operation" : "";
    return Padding(
      padding: numberBoxPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            cutNum(operationText, operationWidth),
            style: textM(text),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: text, size: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    cutNum(number, numberWidth),
                    style: textCalcNum(text),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(width: 10),
                  Text("EUR", style: textL(text)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: (screenHeight - screenWidth) - 390,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: calculation
                    .map(
                      (value) => Text(value, style: textM(text)),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
