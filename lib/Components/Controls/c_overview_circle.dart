import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class COverviewCircle extends StatelessWidget {
  const COverviewCircle({
    super.key,
    required this.elements,
    this.height = 200,
    this.width = 200,
    this.centerRadius = 35,
  });

  final List<PieChartSectionData> elements;
  final double height;
  final double width;
  final double centerRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: centerRadius,
          sections: elements,
        ),
      ),
    );
  }
}
