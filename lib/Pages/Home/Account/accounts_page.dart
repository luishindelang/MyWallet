import 'package:flutter/material.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_accounts_list.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_last_cashflows.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_overview_expenses.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CAccountList(),
          COverviewExpenses(),
          CLastCashflows(),
          SizedBox(height: 90),
        ],
      ),
    );
  }
}
