import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_overview_circle.dart';
import 'package:mywallet/Style/style.dart';

class CExpenseOverviewCircle extends StatelessWidget {
  const CExpenseOverviewCircle({
    super.key,
    required this.values,
    this.radius = 50,
    this.size = 200,
  });

  final Map<double, Color> values;
  final double radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return COverviewCircle(
      width: size,
      height: size,
      elements: values.entries.map((entry) {
        return PieChartSectionData(
          color: entry.value,
          value: entry.key > 0 ? entry.key * -1 : entry.key,
          title: "${entry.key}",
          titleStyle: textXSB(textSelected),
          radius: radius,
        );
      }).toList(),
    );
  }
}
