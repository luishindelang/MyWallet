import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/Style/style.dart';

class CInfoAccountButton extends StatelessWidget {
  const CInfoAccountButton({
    super.key,
    required this.account,
    required this.onPressed,
  });

  final DsAccount account;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CTextButton(
      backgroundColor: boxBackround,
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account.getName, style: textS(text)),
              Text(
                "${account.getCredit}€",
                style: textL(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
