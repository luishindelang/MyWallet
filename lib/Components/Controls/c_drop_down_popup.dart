import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button_border.dart';
import 'package:mywallet/Style/style.dart';

class CDropDownPopup extends StatelessWidget {
  const CDropDownPopup({
    super.key,
    required this.title,
    required this.alertDialog,
    this.paddingHor = 4,
    this.paddingVert = 10,
  });

  final String title;
  final Widget alertDialog;

  final double paddingVert;
  final double paddingHor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: paddingVert,
        horizontal: paddingHor,
      ),
      child: CTextButtonBorder(
        onPressed: () {
          showDialog(context: context, builder: (context) => alertDialog);
        },
        child: Row(
          children: [
            Text(title, style: dropDownText),
            SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: selectedIconColor,
              size: dropdownIconSize,
            ),
          ],
        ),
      ),
    );
  }
}
