import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CBoxBorder extends StatelessWidget {
  const CBoxBorder({
    super.key,
    required this.child,
    this.horMargin = 10,
    this.verMargin = 5,
    this.padding = 8,
  });

  final double horMargin;
  final double verMargin;
  final double padding;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horMargin, vertical: verMargin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: boxBorderColor, width: boxBorderWith),
        borderRadius: BorderRadius.circular(boxBorderRadius),
      ),
      child: child,
    );
  }
}
