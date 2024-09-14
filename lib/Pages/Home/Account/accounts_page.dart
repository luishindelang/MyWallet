import 'package:flutter/material.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_accounts_list.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_last_cashflows.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_overview_expenses.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  DsAccount? _activeAccount;
  List<DsAccount> _accounts = [];

  void loadData() async {
    _accounts = await DaoAccount.getAll();
    setState(() {
      if (_accounts.isNotEmpty) {
        _activeAccount = _accounts.first;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CAccountsList(
            title: "Active account",
            activeAccount: _activeAccount,
            accounts: _accounts,
          ),
          const COverviewExpenses(),
          const CLastCashflows(),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
