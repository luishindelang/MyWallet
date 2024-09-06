import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CTextButton extends StatelessWidget {
  const CTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = buttonBackground,
    this.forgroundColor = buttonForground,
    this.splashColor = buttonSplash,
    this.paddingVert = 8,
    this.paddingHor = 10,
  });

  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color forgroundColor;
  final Color splashColor;
  final double paddingVert;
  final double paddingHor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size.zero),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
          horizontal: paddingHor + 3,
          vertical: paddingVert,
        )),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(forgroundColor),
        overlayColor: WidgetStateProperty.all(
          splashColor.withOpacity(0.3),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      onPressed: () => onPressed(),
      child: child,
    );
  }
}
