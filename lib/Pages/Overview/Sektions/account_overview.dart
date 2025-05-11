import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_drop_down_popup.dart';
import 'package:mywallet/Components/Elements/c_box_border.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/Pages/Overview/Sektions/switch_account_popup.dart';
import 'package:mywallet/Style/style.dart';

class AccountOverview extends StatelessWidget {
  const AccountOverview({super.key, required this.bankaccount});

  final DsBankaccount? bankaccount;

  @override
  Widget build(BuildContext context) {
    return CBoxBorder(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Overview", style: title),
              CDropDownPopup(
                title: bankaccount != null ? bankaccount!.getName : "...",
                alertDialog: SwitchAccountPopup(),
              ),
            ],
          ),
          Text(
            bankaccount != null ? "${bankaccount!.getCredit}" : "....,..€",
            style: accountCreditText,
          ),
        ],
      ),
    );
  }
}
