import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CTextButtonSelected extends StatelessWidget {
  const CTextButtonSelected({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  final Function onPressed;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CTextButton(
      onPressed: onPressed,
      backgroundColor: isSelected ? selectedButtonColor : unselectedButtonColor,
      forgroundColor: isSelected ? textColorNegative : textColor,
      splashColor: isSelected ? buttonSplashColorNegative : buttonSplashColor,
      paddingHor: 14,
      paddingVert: 5,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }
}
