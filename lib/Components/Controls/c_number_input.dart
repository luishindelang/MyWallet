import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mywallet/Style/style.dart';

class CNumberInput extends StatelessWidget {
  const CNumberInput({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\,?\d*')),
      ],
      style: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: textColor,
      cursorHeight: 20,
      cursorRadius: Radius.circular(2),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        hintText: "Enter amount",
        hintStyle: TextStyle(
          color: textColor.withValues(alpha: 0.4),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: boxBorderColor),
          borderRadius: BorderRadius.circular(boxBorderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: boxBorderColor),
          borderRadius: BorderRadius.circular(boxBorderRadius),
        ),
      ),
    );
  }
}
