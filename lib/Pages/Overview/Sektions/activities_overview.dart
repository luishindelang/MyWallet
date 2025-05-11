import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_box_border.dart';
import 'package:mywallet/Components/Overview/c_recent_activity.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/Style/style.dart';

class ActivitiesOverview extends StatefulWidget {
  const ActivitiesOverview({super.key});

  @override
  State<ActivitiesOverview> createState() => _ActivitiesOverviewState();
}

class _ActivitiesOverviewState extends State<ActivitiesOverview> {
  final List<DsCashflow> list = [
    DsCashflow(0, DateTime(2025, 2, 28), 534.57),
    DsCashflow(1, DateTime(2025, 2, 28), 2.39),
    DsCashflow(1, DateTime(2025, 2, 27), 16.43),
    DsCashflow(1, DateTime(2025, 2, 27), 5.99),
    DsCashflow(3, DateTime(2025, 2, 27), 300),
    DsCashflow(2, DateTime(2025, 2, 26), 100),
    DsCashflow(0, DateTime(2025, 2, 26), 50),
    DsCashflow(1, DateTime(2025, 2, 25), 11.98),
    DsCashflow(1, DateTime(2025, 2, 25), 24.11),
  ];
  @override
  Widget build(BuildContext context) {
    return CBoxBorder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recent activites", style: recentActivityTitle),
          Text("last 10 days", style: recentActivitySubtitle),
          SizedBox(height: 12),
          Column(
            children:
                list
                    .map((cashflow) => CRecentActivity(cashflow: cashflow))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
