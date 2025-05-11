import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button_selected.dart';

class SelectType extends StatefulWidget {
  const SelectType({super.key, required this.type, required this.onChange});

  final int type;
  final Function(int) onChange;

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  int _type = 0;

  void onPressed(int newType) {
    if (_type != newType) {
      setState(() {
        _type = newType;
        widget.onChange(newType);
      });
    }
  }

  @override
  void initState() {
    _type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CTextButtonSelected(
          onPressed: () => onPressed(0),
          text: "Expense",
          isSelected: _type == 0,
        ),
        SizedBox(width: 20),
        CTextButtonSelected(
          onPressed: () => onPressed(1),
          text: "Income",
          isSelected: _type == 1,
        ),
        SizedBox(width: 20),
        CTextButtonSelected(
          onPressed: () => onPressed(2),
          text: "Transfer",
          isSelected: _type == 2,
        ),
      ],
    );
  }
}
