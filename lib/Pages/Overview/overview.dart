import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/Pages/Overview/Sektions/account_overview.dart';
import 'package:mywallet/Pages/Overview/Sektions/activities_overview.dart';
import 'package:mywallet/Pages/Overview/Sektions/monthly_overview.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  DsBankaccount? bankaccount;

  // void setAccount() async {
  //   Future.delayed(const Duration(seconds: 3), () {
  //       bankaccount = DsBankaccount("Main Bankaccount", 2384.24);
  //     setState(() {
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   setAccount();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AccountOverview(bankaccount: bankaccount),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MonthlyOverview(bankaccount: bankaccount),
                  ActivitiesOverview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
