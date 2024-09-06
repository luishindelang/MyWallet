import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CIconButton extends StatelessWidget {
  const CIconButton({
    super.key,
    required this.onPressed,
    required this.icons,
    this.color = icon,
    this.backgroundColor = Colors.transparent,
    this.size = 40,
    this.padding = 5,
  });

  final Function onPressed;
  final IconData icons;
  final Color color;
  final Color backgroundColor;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor)),
      padding: EdgeInsets.all(padding),
      iconSize: size,
      onPressed: () => onPressed(),
      icon: Icon(
        icons,
        color: color,
      ),
    );
  }
}
