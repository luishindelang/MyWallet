import 'package:flutter/material.dart';

class CTextWithOutline extends StatelessWidget {
  const CTextWithOutline({
    super.key,
    required this.text,
    required this.textColor,
    required this.outlineColor,
    required this.fontSize,
    required this.outlineWidth,
  });

  final String text;
  final Color textColor;
  final Color outlineColor;
  final double fontSize;
  final double outlineWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = outlineWidth
                  ..color = outlineColor,
          ),
        ),
        Text(text, style: TextStyle(fontSize: fontSize, color: textColor)),
      ],
    );
  }
}
