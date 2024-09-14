import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/Style/style.dart';

class CDropdownCategory extends StatelessWidget {
  const CDropdownCategory({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.hint = "",
    this.borderColor = boxBorder,
    this.textColor = text,
    this.hintColor = textSelected,
    this.dropdownColor = buttonBackground,
  });

  final DsCashflowCategory? value;
  final List<DsCashflowCategory> options;
  final Function(DsCashflowCategory) onChanged;
  final String hint;
  final Color borderColor;
  final Color textColor;
  final Color hintColor;
  final Color dropdownColor;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      iconEnabledColor: borderColor,
      style: textM(textColor),
      underline: Container(height: borderWith, color: borderColor),
      dropdownColor: dropdownColor,
      value: value,
      hint: Text(hint, style: textS(hintColor)),
      items: options.map((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem.getName),
        );
      }).toList(),
      onChanged: (value) => onChanged(value!),
    );
  }
}
