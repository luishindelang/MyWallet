import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_scaffold_menu.dart';
import 'package:mywallet/Components/Widgets/c_accounts_page.dart';
import 'package:mywallet/Components/Widgets/c_budgets_page.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow_category.dart';
import 'package:mywallet/Pages/add_cashflow.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<DsAccount> _accountsList = [];
  List<DsCashflowCategory> _categoryList = [];

  void loadData() async {
    final listC = await DaoCashflowCategory.getAll();
    final listA = await DaoAccount.getAll();

    setState(() {
      _accountsList = listA;
      _categoryList = listC;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadData();
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
      pageList: [
        CAccountsPage(accountsList: _accountsList),
        const CBudgetsPage(),
      ],
      onActionPressed: () {
        if (_accountsList.isNotEmpty) {
          routePush(
            context,
            AddCashflow(
              typeIndex: 1,
              selectedAccound: _accountsList.first,
              accountOption: _accountsList,
              categoryOptions: _categoryList,
            ),
          );
        }
      },
    );
  }
}
