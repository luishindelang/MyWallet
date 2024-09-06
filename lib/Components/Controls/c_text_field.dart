import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.focus,
    this.curserColor = fieldCurser,
    this.borderColor = fieldBorder,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final FocusNode? focus;
  final Color curserColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: curserColor,
          selectionColor: curserColor,
          selectionHandleColor: curserColor,
        ),
      ),
      child: TextField(
        style: textInput,
        focusNode: focus,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(bottom: 0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: borderWith, color: borderColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: borderWith, color: borderColor),
          ),
        ),
        controller: controller,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}
