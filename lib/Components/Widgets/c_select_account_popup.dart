import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_add_account_button.dart';
import 'package:mywallet/Components/Elements/c_info_account_button.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/Style/style.dart';

class CSelectAccountPopup extends StatelessWidget {
  const CSelectAccountPopup({
    super.key,
    required this.accounts,
    required this.onAccountPressed,
  });

  final List<DsAccount> accounts;
  final Function(DsAccount) onAccountPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      title: Text("Select Account", style: textXL(text)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: accounts.isEmpty
              ? [Text("No accounts", style: textL(text))]
              : accounts
                  .map((value) => Padding(
                        padding: popupContextPadding,
                        child: CInfoAccountButton(
                          title: value.getName,
                          content: "${value.getCredit}€",
                          onPressed: () => onAccountPressed(value),
                        ),
                      ))
                  .toList(),
        ),
      ),
      actions: const [CAddAccountButton()],
    );
  }
}
