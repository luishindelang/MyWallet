import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_overview_circle.dart';

class COverviewCircleLoading extends StatelessWidget {
  const COverviewCircleLoading({
    super.key,
    this.color = Colors.grey,
    this.radius = 50,
    this.size = 200,
  });

  final Color color;
  final double radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return COverviewCircle(
      width: size,
      height: size,
      elements: [
        PieChartSectionData(
          color: color,
          value: 1 / 3,
          title: "",
          radius: radius,
        ),
        PieChartSectionData(
          color: color,
          value: 1 / 3,
          title: "",
          radius: radius,
        ),
        PieChartSectionData(
          color: color,
          value: 1 / 3,
          title: "",
          radius: radius,
        ),
      ],
    );
  }
}
