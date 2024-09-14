import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_event_box.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/Style/style.dart';

class CLastCashflows extends StatefulWidget {
  const CLastCashflows({super.key});

  @override
  State<CLastCashflows> createState() => _CLastCashflowsState();
}

class _CLastCashflowsState extends State<CLastCashflows> {
  List<DsCashflow> _cashflows = [];
  DsAccount? _activeAccount;

  int _lastDays = 30;

  final _until = DateTime.now();
  get _from => _until.subtract(Duration(days: _lastDays));

  void loadData() async {
    _activeAccount = await DaoAccount.getActive();
    if (_activeAccount != null) {
      _cashflows = await DaoCashflow.getAll(_activeAccount!.getId);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return CEventBox(
      borderColor: Colors.transparent,
      title: "Last cashflows",
      onMorePressed: () {},
      onTextPressed: () {},
      buttonText: "buttonText",
      child: Column(
        children: _cashflows.map((cashflow) {
          int year = cashflow.getDate.year;
          int month = cashflow.getDate.month;
          int day = cashflow.getDate.day;
          int hour = cashflow.getDate.hour;
          int min = cashflow.getDate.minute;
          String date = "$day.$month.$year";
          String time = "$hour:$min";
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(time, style: textL(textSelected)),
                  const SizedBox(width: 5),
                  Text(date, style: textSB(textSelected)),
                ],
              ),
              Text("${cashflow.getAmount}€", style: textLB(textSelected)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
