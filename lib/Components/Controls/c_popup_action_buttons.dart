import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/Style/style.dart';

class CPopupActionButtons extends StatelessWidget {
  const CPopupActionButtons({super.key, required this.onDone});

  final Function onDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CTextButton(
          backgroundColor: unselectedButtonColor,
          splashColor: selectedButtonColor,
          paddingHor: 10,
          paddingVert: 4,
          onPressed: () => routePop(context),
          child: Text("Cancel", style: actionButtonPositive),
        ),
        SizedBox(width: 10),
        CTextButton(
          backgroundColor: selectedButtonColor,
          splashColor: unselectedButtonColor,
          paddingHor: 10,
          paddingVert: 4,
          onPressed: onDone,
          child: Text("Done", style: actionButtonNegative),
        ),
      ],
    );
  }
}
