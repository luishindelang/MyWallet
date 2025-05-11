import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CTextButton extends StatelessWidget {
  const CTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.forgroundColor = buttonColor,
    this.splashColor = buttonSplashColor,
    this.paddingVert = 2,
    this.paddingHor = 6,
    this.radius = roundedButtonRadius,
  });

  final Function onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color forgroundColor;
  final Color splashColor;
  final double paddingVert;
  final double paddingHor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHor,
          vertical: paddingVert,
        ),

        backgroundColor: backgroundColor,
        foregroundColor: forgroundColor,
        overlayColor: splashColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: () => onPressed(),
      child: child,
    );
  }
}
