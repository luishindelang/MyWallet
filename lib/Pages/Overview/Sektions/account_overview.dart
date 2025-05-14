import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Components/Controls/c_drop_down.dart';
import 'package:mywallet/Components/Elements/c_box_border.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/Service/s_cash_formatter.dart';
import 'package:mywallet/Style/style.dart';

class AccountOverview extends StatelessWidget {
  const AccountOverview({
    super.key,
    required this.bankaccount,
    required this.allBankaccounts,
    required this.changedAccount,
  });

  final DsBankaccount? bankaccount;
  final List<DsBankaccount>? allBankaccounts;
  final Function(DsBankaccount) changedAccount;

  @override
  Widget build(BuildContext context) {
    late DsBankaccount newBankaccount;
    return CBoxBorder(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Overview", style: title),
                SizedBox(height: 10),
                CDropDown(
                  changedItem: (newAccount) {
                    newBankaccount = newAccount;
                    return newAccount.getName;
                  },
                  options:
                      allBankaccounts != null
                          ? allBankaccounts!
                          : <DsBankaccount>[],
                  selectedItemName:
                      bankaccount != null ? bankaccount!.getName : "...",
                  onChange: () {
                    changedAccount(newBankaccount);
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CTextButton(
                onPressed: () {},
                backgroundColor: unselectedButtonColor,
                child: Row(
                  children: [
                    Icon(Icons.add_rounded, color: textColor, size: 15),
                    Text("New Account", style: addBudgetButton),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                bankaccount != null
                    ? cashFormatter(bankaccount!.getCredit, "€")
                    : "....,..€",
                style: accountCreditText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
