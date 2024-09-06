import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Style/style.dart';

class CScaffold extends StatelessWidget {
  const CScaffold({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: forground,
        title: Text(title, style: textLB(textSelected)),
        leading: CIconButton(
          icons: Icons.arrow_back_rounded,
          size: 35,
          color: textSelected,
          onPressed: () => Navigator.pop(context),
        ),
        actions: actions,
      ),
      body: child,
    );
  }
}
