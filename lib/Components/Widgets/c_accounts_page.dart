import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_accounts_list.dart';
import 'package:mywallet/Components/Elements/c_event_box.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/Pages/home.dart';

class CAccountsPage extends StatefulWidget {
  const CAccountsPage({
    super.key,
    required this.accountsList,
  });

  final List<DsAccount> accountsList;

  @override
  State<CAccountsPage> createState() => _CAccountsPageState();
}

class _CAccountsPageState extends State<CAccountsPage> {
  void route() {
    routePushAndRemove(context, const Home());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CAccountsList(
            title: "Active account",
            accountsList: widget.accountsList,
            onAccountPressed: (value) async {
              await DaoAccount.updatePrio(value);
              route();
            },
          ),
          CEventBox(
            borderColor: Colors.transparent,
            title: "Overview expenses",
            onMorePressed: () {},
            onTextPressed: () {},
            buttonText: "buttonText",
            child: const Column(
              children: [
                Text("data"),
                SizedBox(height: 90),
                Text("data"),
              ],
            ),
          ),
          CEventBox(
            borderColor: Colors.transparent,
            title: "Last cashflows",
            onMorePressed: () {},
            onTextPressed: () {},
            buttonText: "buttonText",
            child: const Column(
              children: [
                Text("data"),
                SizedBox(height: 90),
                Text("data"),
              ],
            ),
          ),
          CEventBox(
            borderColor: Colors.transparent,
            title: "title",
            onMorePressed: () {},
            onTextPressed: () {},
            buttonText: "buttonText",
            child: const Column(
              children: [
                Text("data"),
                SizedBox(height: 90),
                Text("data"),
              ],
            ),
          ),
          CEventBox(
            borderColor: Colors.transparent,
            title: "title",
            onMorePressed: () {},
            onTextPressed: () {},
            buttonText: "buttonText",
            child: const Column(
              children: [
                Text("data"),
                SizedBox(height: 90),
                Text("data"),
              ],
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
