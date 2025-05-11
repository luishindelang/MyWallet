import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CNumberFeldButton extends StatelessWidget {
  const CNumberFeldButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    this.iconColor = textColorNegative,
    this.style = numberFeldStyle,
  });

  final Function onPressed;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final IconData? icon;
  final Color iconColor;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.all(5),

          backgroundColor: backgroundColor,
          overlayColor: buttonSplashColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () => onPressed(),
        child:
            icon != null
                ? Icon(icon, color: iconColor, size: 35)
                : Text(text, style: style),
      ),
    );
  }
}
