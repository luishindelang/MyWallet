import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CListTile extends StatelessWidget {
  const CListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.widget,
    this.textColor = text,
  });

  final IconData icon;
  final String title;
  final Widget widget;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: textColor,
      leading: Icon(icon),
      title: Text(title, style: textM(textColor)),
      onTap: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => widget,
        ),
        (route) => false,
      ),
    );
  }
}
