import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_add_account_button.dart';
import 'package:mywallet/Components/Elements/c_info_account_button.dart';
import 'package:mywallet/Pages/Home/Account/Components/c_select_account_popup.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/Pages/EditAccount/edit_account.dart';
import 'package:mywallet/Style/style.dart';

class CAccountList extends StatefulWidget {
  const CAccountList({super.key});

  @override
  State<CAccountList> createState() => _CAccountListState();
}

class _CAccountListState extends State<CAccountList> {
  List<DsAccount> _accounts = [];
  DsAccount? _activeAccount;

  void loadData() async {
    _accounts = await DaoAccount.getAll();
    _activeAccount = await DaoAccount.getActive();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
              Text("Active account", style: textL(textSelected)),
              CIconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CSelectAccountPopup(
                      accounts: _accounts,
                    ),
                  );
                },
                icons: Icons.swap_vert_rounded,
                color: textSelected,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _activeAccount != null
              ? CInfoAccountButton(
                  account: _activeAccount!,
                  onPressed: () => routePush(
                    context,
                    EditAccount(account: _activeAccount!),
                  ),
                )
              : const CAddAccountButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
