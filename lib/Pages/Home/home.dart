import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_scaffold_menu.dart';
import 'package:mywallet/Pages/Home/Account/accounts_page.dart';
import 'package:mywallet/Pages/Home/Budget/budgets_page.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow_category.dart';
import 'package:mywallet/Pages/AddCashflow/add_cashflow.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void route(
    List<DsAccount> accounts,
    List<DsCashflowCategory> categories,
  ) {
    routePush(
      context,
      AddCashflow(
        typeIndex: 1,
        selectedAccound: accounts.first,
        accountOption: accounts,
        categoryOptions: categories,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CScaffoldMenu(
      title: "Home",
      tabController: _tabController,
      tabList: const [
        Tab(text: "Accounts"),
        Tab(text: "Budgets"),
      ],
      pageList: const [
        AccountsPage(),
        BudgetsPage(),
      ],
      onActionPressed: () async {
        final categories = await DaoCashflowCategory.getAll();
        final accounts = await DaoAccount.getAll();
        if (accounts.isNotEmpty) {
          route(accounts, categories);
        }
      },
    );
  }
}
