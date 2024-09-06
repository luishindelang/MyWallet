import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CCalculatorButton extends StatelessWidget {
  const CCalculatorButton({
    super.key,
    required this.h,
    required this.w,
    required this.onPressed,
    this.onLongPressed,
    required this.child,
  });

  final double h;
  final double w;
  final Function onPressed;
  final Function? onLongPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size.zero),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        )),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(buttonForground),
        overlayColor: WidgetStateProperty.all(
          buttonSplash.withOpacity(0.3),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      onPressed: () => onPressed(),
      onLongPress: () => onLongPressed!(),
      child: SizedBox(
        height: h,
        width: w,
        child: Center(child: child),
      ),
    );
  }
}
