import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mywallet/Style/style.dart';

class CRecentActivityCashflowType extends StatelessWidget {
  const CRecentActivityCashflowType({super.key, required this.type});

  final int type;

  Color getColorByType() {
    switch (type) {
      case 0:
        return incomeColor;
      case 1:
        return expenseColor;
      default:
        return transferColor;
    }
  }

  IconData getIconByType() {
    switch (type) {
      case 0:
        return Symbols.add_rounded;
      case 1:
        return Symbols.remove_rounded;
      default:
        return Symbols.swap_horiz_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: getColorByType(),
        borderRadius: BorderRadius.circular(dropdownRadius),
      ),
      child: Icon(
        getIconByType(),
        color: textColorNegative,
        size: 18,
        grade: 100,
        weight: 600,
        opticalSize: 18,
      ),
    );
  }
}
