import 'package:flutter/material.dart';
import 'package:mywallet/Pages/AddCashflow/Components/c_cashflow_selection.dart';
import 'package:mywallet/Components/Elements/c_scaffold_add.dart';
import 'package:mywallet/Components/Calculator/c_show_number.dart';
import 'package:mywallet/Components/Calculator/c_calculator.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/Pages/AddCashflow/Components/c_edit_note_popup.dart';
import 'package:mywallet/Pages/Home/home.dart';
import 'package:mywallet/Style/style.dart';

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
  final List<DsCategory> categoryOptions;

  @override
  State<AddCashflow> createState() => _AddCashflowState();
}

class _AddCashflowState extends State<AddCashflow>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  late TabController _tabController;
  late int _selectedTypeIndex;
  late IconData _typeIcon;
  String _number = "0";
  String? _operation;
  final List<String> _calculated = [];

  DsAccount? _accountValue;
  DsAccount? _accountToValue;
  DsCategory? _categoryValue;

  double get _numberDouble => _number.isEmpty ? 0 : double.parse(_number);

  void resetAccountCategory() {
    _categoryValue = null;
    _accountToValue = null;
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
      _controller.text,
      _numberDouble,
      _categoryValue,
      0,
      _accountValue!.getId,
    );
    await DaoCashflow.insert(cashflow);
  }

  void addExpense() async {
    subFromAccountCredit();
    final cashflow = DsCashflow(
      uuid(),
      DateTime.now(),
      _controller.text,
      _numberDouble * -1,
      _categoryValue,
      1,
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
    if (_accountValue != null && _numberDouble != 0) {
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

  void editText() {
    showDialog(
      context: context,
      builder: (context) => CEditNotePopup(
        controller: _controller,
      ),
    );
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = MediaQuery.of(context).padding.top + 120;
    final double availableBodyHeight = screenHeight - appBarHeight;

    return CScaffoldAdd(
      title: "Add Cashflow",
      controller: _tabController,
      onCheckPressed: () => addCashflow(),
      onBottomPressed: (value) => selectType(value),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: availableBodyHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CShowNumber(
                icon: _typeIcon,
                operation: _operation,
                number: _number,
                calculation: _calculated,
              ),
              Container(
                color: forground,
                child: Column(
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
                      onEditText: () => editText(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
