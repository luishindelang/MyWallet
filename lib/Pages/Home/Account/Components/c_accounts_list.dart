import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_add_account_button.dart';
import 'package:mywallet/Components/Elements/c_info_account_button.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_select_account_popup.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/Pages/EditAccount/edit_account.dart';
import 'package:mywallet/Style/style.dart';

class CAccountsList extends StatelessWidget {
  const CAccountsList({
    super.key,
    required this.title,
    required this.activeAccount,
    required this.accounts,
  });

  final String title;
  final DsAccount? activeAccount;
  final List<DsAccount> accounts;

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
                      accounts: accounts,
                    ),
                  );
                },
                icons: Icons.swap_vert_rounded,
                color: textSelected,
              ),
            ],
          ),
          const SizedBox(height: 20),
          activeAccount != null
              ? accounts.isNotEmpty
                  ? CInfoAccountButton(
                      account: activeAccount!,
                      onPressed: () => routePush(
                        context,
                        EditAccount(account: activeAccount!),
                      ),
                    )
                  : const CAddAccountButton()
              : CInfoAccountButton(
                  account: DsAccount("null", "...", 0),
                  onPressed: () {},
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
