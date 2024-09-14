import 'package:flutter/material.dart';
import 'package:mywallet/Pages/AddCashflow/Components/c_cashflow_selection.dart';
import 'package:mywallet/Components/Elements/c_scaffold_add.dart';
import 'package:mywallet/Components/Calculator/c_show_number.dart';
import 'package:mywallet/Components/Calculator/c_calculator.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/Pages/Home/home.dart';

class AddCashflow extends StatefulWidget {
  const AddCashflow({
    super.key,
    required this.typeIndex,
    required this.selectedAccound,
    required this.accountOption,
    required this.categoryOptions,
  });

  final int typeIndex;
  final DsAccount selectedAccound;

  final List<DsAccount> accountOption;
  final List<DsCashflowCategory> categoryOptions;

  @override
  State<AddCashflow> createState() => _AddCashflowState();
}

class _AddCashflowState extends State<AddCashflow>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedTypeIndex;
  late IconData _typeIcon;
  String _number = "0";
  String? _operation;
  final List<String> _calculated = [];

  DsAccount? _accountValue;
  DsAccount? _accountToValue;
  DsCashflowCategory? _categoryValue;

  double get _numberDouble => _number.isEmpty ? 0 : double.parse(_number);

  void resetAccountCategory() {
    _categoryValue = null;
    _accountValue = null;
  }

  void setIcon(int type) {
    switch (type) {
      case 0:
        _typeIcon = Icons.add_rounded;
        break;
      case 1:
        _typeIcon = Icons.remove_rounded;
        break;
      case 2:
        _typeIcon = Icons.swap_vert_rounded;
        break;
    }
  }

  void selectType(int type) {
    setState(() {
      setIcon(type);
      if (type == 2 || _selectedTypeIndex == 2) {
        resetAccountCategory();
      }
      _selectedTypeIndex = type;
    });
  }

  void addToAccountCredit(DsAccount account) async {
    account.setCredit = account.getCredit + _numberDouble;
    await DaoAccount.update(account);
  }

  void subFromAccountCredit() async {
    _accountValue!.setCredit = _accountValue!.getCredit - _numberDouble;
    await DaoAccount.update(_accountValue!);
  }

  void addIncome() async {
    addToAccountCredit(_accountValue!);
    final cashflow = DsCashflow(
      uuid(),
      DateTime.now(),
      "",
      _numberDouble,
      _categoryValue,
      _accountValue!.getId,
    );
    await DaoCashflow.insert(cashflow);
  }

  void addExpense() async {
    subFromAccountCredit();
    final cashflow = DsCashflow(
      uuid(),
      DateTime.now(),
      "",
      _numberDouble * -1,
      _categoryValue,
      _accountValue!.getId,
    );
    await DaoCashflow.insert(cashflow);
  }

  void addTransfer() {
    if (_accountToValue != null) {
      subFromAccountCredit();
      addToAccountCredit(_accountToValue!);
    }
  }

  void route() {
    routePushAndRemove(context, const Home());
  }

  void addCashflow() async {
    if (_accountValue != null) {
      switch (_selectedTypeIndex) {
        case 2:
          addTransfer();
          break;
        case 1:
          addExpense();
          break;
        case 0:
          addIncome();
          break;
      }
      route();
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = widget.typeIndex;
    _selectedTypeIndex = widget.typeIndex;
    _accountValue = widget.selectedAccound;
    setIcon(widget.typeIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CScaffoldAdd(
      title: "Add Cashflow",
      controller: _tabController,
      onCheckPressed: () => addCashflow(),
      onBottomPressed: (value) => selectType(value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CShowNumber(
            icon: _typeIcon,
            operation: _operation,
            number: _number,
            calculation: _calculated,
          ),
          Column(
            children: [
              CCashflowSelection(
                width: screenWidth,
                isTransfer: _selectedTypeIndex == 2,
                accountValue: _accountValue,
                accountOptions: widget.accountOption,
                onAccountChanged: (value) {
                  setState(() {
                    _accountValue = value;
                  });
                },
                categoryValue: _categoryValue,
                categoryOptions: widget.categoryOptions,
                onCategoryChanged: (value) {
                  setState(() {
                    _categoryValue = value;
                  });
                },
                accountToValue: _accountToValue,
                accountToOptions: widget.accountOption,
                onAccountToChanged: (value) {
                  setState(() {
                    _accountToValue = value;
                  });
                },
              ),
              CCalculator(
                calcList: _calculated,
                onPressed: (numberText, operation) => setState(() {
                  _number = numberText;
                  _operation = operation;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
