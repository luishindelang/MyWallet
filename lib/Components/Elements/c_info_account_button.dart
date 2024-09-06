import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CInfoAccountButton extends StatelessWidget {
  const CInfoAccountButton({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
  });

  final String title;
  final String content;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CTextButton(
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textS(text)),
              Text(
                content,
                style: textL(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
