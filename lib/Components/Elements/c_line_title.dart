import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CLineTitle extends StatelessWidget {
  const CLineTitle({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: boxTopBorderColor, width: boxBorderWith),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [Text(title, style: budgetTitles)],
            ),
          ),
          SizedBox(height: 10),
          Column(children: children),
        ],
      ),
    );
  }
}
