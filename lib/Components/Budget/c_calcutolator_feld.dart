import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_box_border.dart';
import 'package:mywallet/DB/Service/s_expression_parser.dart';
import 'package:mywallet/DB/Service/s_number_formatting.dart';
import 'package:mywallet/Pages/Calculator/Sektions/number_feld.dart';
import 'package:mywallet/Style/style.dart';

class CCalcutolatorFeld extends StatefulWidget {
  const CCalcutolatorFeld({super.key, required this.pressedDone});

  final Function(double) pressedDone;

  @override
  State<CCalcutolatorFeld> createState() => _CCalcutolatorFeldState();
}

class _CCalcutolatorFeldState extends State<CCalcutolatorFeld> {
  String operationString = "";
  List<String> operationHistory = [];
  double result = 0;

  void addToCalculationString(String operation) {
    setState(() {
      if (operation == 'AC') {
        operationString = '';
        operationHistory = [];
      }

      if (operation == 'delete') {
        if (operationString.isNotEmpty) {
          operationString = operationString.substring(
            0,
            operationString.length - 1,
          );
        }
      }

      if (operation == 'enter') {
        if (operationString.isNotEmpty &&
            operationString != result.toString()) {
          final parser = ExpressionParser(operationString);
          result = parser.parse();
          operationHistory.add(parser.input);
          operationString = formatDouble(result);
        }
      }

      if (operation == 'ok') {
        widget.pressedDone(result);
      }

      if (RegExp(r'^[0-9]$').hasMatch(operation)) {
        operationString += operation;
      }

      if (operation == '.') {
        final parts = operationString.split(RegExp(r'[+–×÷()]'));
        final last = parts.isEmpty ? '' : parts.last;
        if (!last.contains('.')) {
          operationString += '.';
        }
      }

      if (['+', '–', '×', '÷'].contains(operation)) {
        if (operationString.isEmpty) {
          if (operation == '–') operationString = '–';
        } else if (RegExp(r'[+–×÷]$').hasMatch(operationString)) {
          operationString =
              operationString.substring(0, operationString.length - 1) +
              operation;
        } else if (operationString.endsWith('(') && operation == '–') {
          operationString += '–';
        } else {
          operationString += operation;
        }
      }

      if (operation == 'bracket') {
        final openCount = '('.allMatches(operationString).length;
        final closeCount = ')'.allMatches(operationString).length;
        final isLastSeparator = RegExp(r'[+–×÷(]$').hasMatch(operationString);

        if (openCount > closeCount && !isLastSeparator) {
          operationString += ')';
        } else if (operationString.isEmpty || isLastSeparator) {
          operationString += '(';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CBoxBorder(
        horMargin: 0,
        verMargin: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:
                      operationHistory
                          .map(
                            (lastOperation) => Text(
                              lastOperation,
                              style: caclulatorLastOperation,
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Text(operationString, style: caclulatorResult),
            ),
            SizedBox(height: 5),
            NumberFeld(onPressed: addToCalculationString),
          ],
        ),
      ),
    );
  }
}
