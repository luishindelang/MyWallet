import 'package:flutter/material.dart';
import 'package:mywallet/Components/Budget/c_calcutolator_feld.dart';
import 'package:mywallet/Components/Controls/c_drop_down.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/Pages/Calculator/Sektions/select_type.dart';
import 'package:mywallet/Style/style.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _type = 0;
  List<DsBankaccount> accountList = [
    DsBankaccount("Main", 1000),
    DsBankaccount("Sub", 100),
    DsBankaccount("Div", 10),
  ];
  late List<DsBankaccount> transferAccountList;

  late DsBankaccount selectedAccount;
  DsBankaccount? transferAccount;

  String operationString = "";
  List<String> operationHistory = [];

  void removeAktiveAccountFromList() {
    transferAccountList = accountList.toList();
    transferAccountList.remove(selectedAccount);
  }

  Widget switchTypeChoose(bool showTransfer) {
    if (showTransfer) {
      return Row(
        children: [
          Icon(Icons.arrow_forward_outlined),
          SizedBox(width: 15),
          CDropDown(
            changedItem: (account) {
              return account.getName;
            },
            options: transferAccountList,
            selectedItemName: "Select account",
          ),
        ],
      );
    } else {
      return CTextButton(
        onPressed: () {},
        backgroundColor: unselectedButtonColor,
        child: Row(
          children: [
            Icon(Icons.add_rounded, color: textColor, size: 18),
            Text("Category ", style: dropDownText),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    selectedAccount = accountList.first;
    removeAktiveAccountFromList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Calculator", style: title),
            SizedBox(height: 15),
            SelectType(
              type: _type,
              onChange: (type) {
                setState(() {
                  _type = type;
                });
              },
            ),
            SizedBox(height: 15),
            Row(
              children: [
                CDropDown(
                  changedItem: (account) {
                    selectedAccount = account;
                    return account.getName;
                  },
                  onChange: () {
                    setState(() {
                      removeAktiveAccountFromList();
                    });
                  },
                  options: accountList,
                  selectedItemName: selectedAccount.getName,
                ),
                SizedBox(width: 15),
                switchTypeChoose(_type == 2),
              ],
            ),
            SizedBox(height: 15),
            CCalcutolatorFeld(
              pressedDone: (double result) {
                print(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}
