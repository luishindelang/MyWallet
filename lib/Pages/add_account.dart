import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Components/Controls/c_number_input_field.dart';
import 'package:mywallet/Components/Controls/c_switch.dart';
import 'package:mywallet/Components/Controls/c_text_field.dart';
import 'package:mywallet/Components/Elements/c_scaffold.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_account.dart';
import 'package:mywallet/Pages/home.dart';
import 'package:mywallet/Style/style.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _nameController = TextEditingController();
  final _creditController = TextEditingController();
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    void route() {
      routePushAndRemove(context, const Home());
    }

    return CScaffold(
      title: "Add new account",
      actions: [
        CIconButton(
          icons: Icons.check_rounded,
          size: 35,
          color: textSelected,
          onPressed: () async {
            if (_nameController.text.isNotEmpty &&
                _creditController.text.isNotEmpty) {
              final account = DsAccount(
                uuid(),
                _nameController.text,
                double.tryParse(_creditController.text)!,
                isSelected ? 0 : 1,
              );
              if (isSelected) {
                await DaoAccount.updateAllToLowPrio();
              }
              await DaoAccount.insert(account);
              route();
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: addAccountBodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name", style: textL(text)),
              CTextField(
                controller: _nameController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              Text("Credit", style: textL(text)),
              CNumberInputField(
                controller: _creditController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text("Select account as main: ", style: textL(text)),
                  CSwitch(
                    value: isSelected,
                    onchanged: (value) => setState(() {
                      isSelected = value;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
