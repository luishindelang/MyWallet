import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CIconButton extends StatelessWidget {
  const CIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.transparent,
    this.forgroundColor = buttonColor,
    this.splashColor = buttonSplashColor,
    this.paddingVert = 2,
    this.paddingHor = 6,
    this.radius = roundedButtonRadius,
  });

  final Function onPressed;
  final Widget icon;
  final Color backgroundColor;
  final Color forgroundColor;
  final Color splashColor;
  final double paddingVert;
  final double paddingHor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
      icon: icon,
    );
  }
}
