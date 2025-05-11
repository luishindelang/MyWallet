import 'package:flutter/material.dart';

class COutlinedText extends StatelessWidget {
  const COutlinedText({
    super.key,
    required this.text,
    required this.borderColor,
    required this.strokeWidth,
    required this.style,
  });

  final String text;
  final Color borderColor;
  final double strokeWidth;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: style.fontSize,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = borderColor,
          ),
        ),
        Text(text, style: style),
      ],
    );
  }
}
