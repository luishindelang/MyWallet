import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/Style/style.dart';

class CShowCashlfow extends StatelessWidget {
  const CShowCashlfow({
    super.key,
    required this.cashflow,
  });

  final DsCashflow cashflow;

  @override
  Widget build(BuildContext context) {
    int year = cashflow.getDate.year;
    int month = cashflow.getDate.month;
    int day = cashflow.getDate.day;
    String hour = cashflow.getDate.hour.toString().padLeft(2, '0');
    String min = cashflow.getDate.minute.toString().padLeft(2, '0');
    String date = "$day.$month.$year";
    String time = "$hour:$min";
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(time, style: textL(textSelected)),
                  const SizedBox(width: 5),
                  Text(date, style: textSB(textSelected)),
                ],
              ),
              Text("${cashflow.getAmount}€", style: textLB(textSelected)),
            ],
          ),
          cashflow.getCategory != null
              ? Text(
                  cashflow.getCategory!.getName,
                  style: textXS(textSelected),
                  overflow: TextOverflow.ellipsis,
                )
              : const SizedBox(),
          cashflow.getNote.isNotEmpty
              ? Text(
                  cashflow.getNote,
                  style: textXS(textSelected),
                  overflow: TextOverflow.ellipsis,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
