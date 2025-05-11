import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CTextInput extends StatelessWidget {
  const CTextInput({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: textColor,
      cursorHeight: 26,
      cursorRadius: Radius.circular(2),
      decoration: InputDecoration(
        hintText: "Add name",
        hintStyle: TextStyle(
          color: textColor.withValues(alpha: 0.6),
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
