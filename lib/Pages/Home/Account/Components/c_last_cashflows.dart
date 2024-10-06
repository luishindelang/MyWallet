import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_event_box.dart';
import 'package:mywallet/Components/Elements/c_show_cashlfow.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/Pages/CashflowHistory/cashflow_history.dart';
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
      _cashflows = await DaoCashflow.searchByDate(
        _from,
        _until,
        _activeAccount!.getId,
      );
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
      onTextPressed: () => routePush(context, const CashflowHistory()),
      buttonText: "Cashflow history",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Last $_lastDays days", style: textS(text)),
          const SizedBox(height: 10),
          Column(
            children: _cashflows.isEmpty
                ? [Text("No cashflows", style: textL(textSelected))]
                : _cashflows
                    .map((cashflow) => CShowCashlfow(cashflow: cashflow))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
