import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_scaffold.dart';

class CashflowHistory extends StatefulWidget {
  const CashflowHistory({
    super.key,
  });

  @override
  State<CashflowHistory> createState() => _CashflowHistoryState();
}

class _CashflowHistoryState extends State<CashflowHistory> {
  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: "Cashflow history",
      child: const Placeholder(),
    );
  }
}
