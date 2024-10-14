import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_event_box.dart';
import 'package:mywallet/Components/Loading/c_overview_circle_loading.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/Pages/AddCategory/add_category.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_expense_overview_circle.dart';
import 'package:mywallet/Style/style.dart';

class COverviewExpenses extends StatefulWidget {
  const COverviewExpenses({
    super.key,
  });

  @override
  State<COverviewExpenses> createState() => _COverviewExpensesState();
}

class _COverviewExpensesState extends State<COverviewExpenses> {
  List<DsCategory> _categories = [];
  DsAccount? _activeAccount;
  double? _expense;
  final Map<double, Color> _cashflowData = {};

  int _lastDays = 30;

  final _until = DateTime.now();
  get _from => _until.subtract(Duration(days: _lastDays));

  void loadData() async {
    _activeAccount = await DaoAccount.getActive();
    _categories = await DaoCategory.getAll();
    if (_activeAccount != null) {
      _expense = await DaoCashflow.getSumOfPeriod(
        _from,
        _until,
        _activeAccount!.getId,
      );
      if (_expense != null) _expense = _expense! * -1;
      for (var category in _categories) {
        await loadCashflowData(category);
      }
    }
    setState(() {});
  }

  Future<void> loadCashflowData(DsCategory category) async {
    var value = await DaoCashflow.getSumOfPeriodAndCategory(
      _from,
      _until,
      _activeAccount!.getId,
      category.getId,
    );
    if (value != null) {
      _cashflowData.addAll({value * -1: category.getColor});
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CEventBox(
      borderColor: Colors.transparent,
      title: "Overview expenses",
      onMorePressed: () {},
      onTextPressed: () => routePush(context, const AddCategory()),
      buttonText: "Add Category",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Last $_lastDays days", style: textS(text)),
          Text(_expense == null ? "..." : "$_expense€", style: textLB(text)),
          const SizedBox(height: 10),
          Row(
            children: [
              Center(
                child: _cashflowData.isEmpty
                    ? const COverviewCircleLoading()
                    : CExpenseOverviewCircle(values: _cashflowData),
              ),
              SizedBox(
                width: (screenWidth - 260),
                height: 172,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _categories.isEmpty
                          ? [
                              Text(
                                "No categories",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: textS(textSelected),
                              ),
                            ]
                          : _categories
                              .map((category) => Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          color: category.getColor,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: borderWith,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              borderRadius),
                                        ),
                                      ),
                                      Text(
                                        category.getName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: textS(textSelected),
                                      ),
                                    ],
                                  ))
                              .toList()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
