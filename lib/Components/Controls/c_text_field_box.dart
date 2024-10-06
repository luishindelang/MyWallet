import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CTextFieldBox extends StatelessWidget {
  const CTextFieldBox({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.readOnly,
    this.focus,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.curserColor = fieldCurser,
    this.borderColor = fieldBorder,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final bool readOnly;
  final FocusNode? focus;
  final String? hint;
  final int maxLines;
  final int minLines;
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
      child: SingleChildScrollView(
        child: TextField(
          style: textInput,
          focusNode: focus,
          readOnly: readOnly,
          keyboardType: TextInputType.multiline,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textInputHint,
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
      ),
    );
  }
}
