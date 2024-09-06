import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Style/style.dart';

class CScaffoldAdd extends StatelessWidget {
  const CScaffoldAdd({
    super.key,
    required this.title,
    required this.onCheckPressed,
    required this.controller,
    required this.onBottomPressed,
    required this.child,
  });

  final String title;
  final Function onCheckPressed;
  final TabController controller;
  final Function(int) onBottomPressed;
  final Widget child;

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
        actions: [
          CIconButton(
            icons: Icons.check_rounded,
            size: 35,
            color: textSelected,
            onPressed: () => onCheckPressed(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: forgroundSecondery,
            child: TabBar(
              dividerColor: forgroundSecondery,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: textSelected,
              indicator: const BoxDecoration(
                color: forgroundSelected,
              ),
              labelStyle: textM(textSelected),
              unselectedLabelStyle: textM(textSelected),
              overlayColor: WidgetStateProperty.all(buttonSplash),
              controller: controller,
              tabs: const [
                Tab(text: "INCOME"),
                Tab(text: "EXPENSE"),
                Tab(text: "TRANSFER"),
              ],
              onTap: (value) => onBottomPressed(value),
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
