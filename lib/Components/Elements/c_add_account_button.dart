import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/Pages/add_account.dart';
import 'package:mywallet/Style/style.dart';

class CAddAccountButton extends StatelessWidget {
  const CAddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: text, width: borderWith + 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: CTextButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          routePush(context, const AddAccount());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ADD ACCOUNT", style: textL(text)),
            const Icon(Icons.add_circle_outline_rounded, size: 30),
          ],
        ),
      ),
    );
  }
}
