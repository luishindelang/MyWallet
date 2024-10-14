import 'package:flutter/material.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_add_account_button.dart';
import 'package:mywallet/Components/Elements/c_info_account_button.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/Pages/Home/home.dart';
import 'package:mywallet/Style/style.dart';

class CSelectAccountPopup extends StatelessWidget {
  const CSelectAccountPopup({
    super.key,
    required this.accounts,
  });

  final List<DsAccount> accounts;

  @override
  Widget build(BuildContext context) {
    void route() {
      routePushAndRemove(context, const Home());
    }

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
                          account: value,
                          onPressed: () async {
                            await DaoAccount.updatePrio(value);
                            route();
                          },
                          onSwitchPressed: () {},
                        ),
                      ))
                  .toList(),
        ),
      ),
      actions: const [CAddAccountButton()],
    );
  }
}
