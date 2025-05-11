import 'package:flutter/material.dart';
import 'package:mywallet/Components/Overview/c_recent_activity_cashflow_type.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/Service/s_cash_formatter.dart';
import 'package:mywallet/DB/Service/s_time_formatter.dart';
import 'package:mywallet/Style/style.dart';

class CRecentActivity extends StatelessWidget {
  const CRecentActivity({super.key, required this.cashflow});

  final DsCashflow cashflow;

  String _getAmount() {
    String amountType = "";
    switch (cashflow.getType) {
      case 0 || 2:
        amountType = "+";
        break;
      default:
        amountType = "–";
    }
    return "$amountType ${cashFormatter(cashflow.getAmount, "€")}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CRecentActivityCashflowType(type: cashflow.getType),
              SizedBox(width: 15),
              Text(_getAmount(), style: recentActivityAmount),
            ],
          ),
          Text(dayMonth(cashflow.getDate), style: recentActivityDate),
        ],
      ),
    );
  }
}
