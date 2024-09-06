import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Components/Elements/c_add_account_button.dart';
import 'package:mywallet/Components/Elements/c_info_account_button.dart';
import 'package:mywallet/Components/Widgets/c_select_account_popup.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/Pages/edit_account.dart';
import 'package:mywallet/Style/style.dart';

class CAccountsList extends StatelessWidget {
  const CAccountsList({
    super.key,
    required this.title,
    required this.accountsList,
    required this.onAccountPressed,
  });

  final String title;
  final List<DsAccount> accountsList;
  final Function(DsAccount) onAccountPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: boxChildPadding,
      color: forgroundSecondery,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textL(textSelected)),
              CIconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CSelectAccountPopup(
                      accounts: accountsList,
                      onAccountPressed: (value) => onAccountPressed(value),
                    ),
                  );
                },
                icons: Icons.swap_vert_rounded,
                color: textSelected,
              ),
            ],
          ),
          const SizedBox(height: 20),
          accountsList.isNotEmpty
              ? CInfoAccountButton(
                  title: accountsList.first.getName,
                  content: "${accountsList.first.getCredit}€",
                  onPressed: () => routePush(
                    context,
                    EditAccount(account: accountsList.first),
                  ),
                )
              : const CAddAccountButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
