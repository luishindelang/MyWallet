import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_scaffold.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';

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
  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: "Account Info",
      child: const Placeholder(),
    );
  }
}
