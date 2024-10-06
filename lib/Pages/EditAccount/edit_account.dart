import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Components/Controls/c_number_input_field.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Components/Controls/c_text_field.dart';
import 'package:mywallet/Components/Elements/c_scaffold.dart';
import 'package:mywallet/Components/Elements/c_show_cashlfow.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/Pages/CashflowHistory/cashflow_history.dart';
import 'package:mywallet/Pages/EditAccount/Components/c_box_list.dart';
import 'package:mywallet/Pages/Home/home.dart';
import 'package:mywallet/Style/style.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({
    super.key,
    required this.account,
  });

  final DsAccount account;

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _nameController = TextEditingController();
  final _creditController = TextEditingController();

  List<DsCashflow> _cashflows = [];
  List<DsBudget> _budgets = [];

  final int _listLength = 5;

  void route() {
    routePushAndRemove(context, const Home());
  }

  void infoPopup() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please delete all cashflows and budgets!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.account.getName;
    _creditController.text = widget.account.getCredit.toString();
    _cashflows = widget.account.getCashflows;
    if (_cashflows.length > _listLength) {
      _cashflows = widget.account.getCashflows.sublist(0, _listLength);
    }
    _budgets = widget.account.getBudgets;
    if (_budgets.length > _listLength) {
      _budgets = widget.account.getBudgets.sublist(0, _listLength);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: "Account Info",
      actions: [
        CIconButton(
          icons: Icons.check_rounded,
          size: 35,
          color: textSelected,
          onPressed: () async {
            if (_nameController.text.isNotEmpty &&
                _creditController.text.isNotEmpty) {
              widget.account.setCredit =
                  double.tryParse(_creditController.text)!;
              widget.account.setName = _nameController.text;
              await DaoAccount.update(widget.account);
              routePushAndRemove(context, const Home());
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: addAccountBodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name", style: textL(text)),
              CTextField(
                controller: _nameController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              Text("Credit", style: textL(text)),
              CNumberInputField(
                controller: _creditController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              CBoxList(
                title: "Cashflows",
                onTextPressed: () =>
                    routePush(context, const CashflowHistory()),
                buttonText: "show more",
                child: Column(
                  children: _cashflows.isEmpty
                      ? [Text("No cashflows", style: textL(textSelected))]
                      : _cashflows
                          .map((cashflow) => CShowCashlfow(cashflow: cashflow))
                          .toList(),
                ),
              ),
              const SizedBox(height: 30),
              CBoxList(
                title: "Budgets",
                onTextPressed: () =>
                    routePushAndRemove(context, const Home(index: 1)),
                buttonText: "show more",
                child: Column(
                  children: _budgets.isEmpty
                      ? [
                          Text(
                            "No budgets",
                            style: textL(textSelected),
                          )
                        ]
                      : _budgets
                          .map((budget) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 5),
                                child: Text(budget.getName,
                                    style: textL(textSelected)),
                              ))
                          .toList(),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: text, width: borderWith + 1),
                  borderRadius: BorderRadius.circular(borderRadius + 2),
                ),
                child: CTextButton(
                  backgroundColor: boxBackround,
                  onPressed: () async {
                    if (_budgets.isEmpty && _cashflows.isEmpty) {
                      await DaoAccount.delete(widget.account.getId);
                      routePushAndRemove(context, const Home());
                      return;
                    }
                    infoPopup();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("DELETE ACCOUNT", style: textL(text)),
                      const Icon(Icons.delete_forever_rounded, size: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
