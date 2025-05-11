import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CTextButtonBorder extends StatelessWidget {
  const CTextButtonBorder({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.forgroundColor = buttonColor,
    this.splashColor = buttonSplashColor,
    this.borderColor = boxBorderColor,
  });

  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color forgroundColor;
  final Color splashColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: boxBorderWith),
        borderRadius: BorderRadius.circular(dropdownRadius),
      ),
      child: CTextButton(
        onPressed: () => onPressed(),
        backgroundColor: backgroundColor,
        forgroundColor: forgroundColor,
        splashColor: splashColor,
        radius: dropdownRadius,
        child: child,
      ),
    );
  }
}
