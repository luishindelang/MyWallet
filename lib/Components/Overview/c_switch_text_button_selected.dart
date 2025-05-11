import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button_selected.dart';
import 'package:mywallet/Style/style.dart';

class CSwitchTextButtonSelected extends StatefulWidget {
  const CSwitchTextButtonSelected({
    super.key,
    required this.onChange,
    required this.expenseText,
    required this.incomeText,
  });

  final Function(bool) onChange;
  final String expenseText;
  final String incomeText;

  @override
  State<CSwitchTextButtonSelected> createState() =>
      _CSwitchTextButtonSelectedState();
}

class _CSwitchTextButtonSelectedState extends State<CSwitchTextButtonSelected> {
  bool _isSelected = true;

  void onChangePressed(bool witch) {
    if (_isSelected != witch) widget.onChange(witch);
    setState(() {
      if (witch) {
        _isSelected = witch;
      } else {
        _isSelected = witch;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CTextButtonSelected(
              onPressed: () => onChangePressed(true),
              text: "Total expenses",
              isSelected: _isSelected,
            ),
            SizedBox(height: 10),
            Text(widget.expenseText, style: totalExpensesText),
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: [
            CTextButtonSelected(
              onPressed: () => onChangePressed(false),
              text: "Total incomes",
              isSelected: !_isSelected,
            ),
            SizedBox(height: 10),
            Text(widget.incomeText, style: totalIncomesText),
          ],
        ),
      ],
    );
  }
}
