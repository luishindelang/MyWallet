import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CPopup extends StatelessWidget {
  const CPopup({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth - 30;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(boxBorderRadius),
      ),
      backgroundColor: background,
      child: Container(
        padding: EdgeInsets.all(20),
        width: maxWidth,
        child: child,
      ),
    );
  }
}
