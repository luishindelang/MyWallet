import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CColorSelect extends StatelessWidget {
  const CColorSelect({
    super.key,
    required this.onPressed,
    required this.color,
    required this.isSelected,
  });

  final Function onPressed;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CTextButton(
        onPressed: onPressed,
        backgroundColor:
            isSelected ? selectedButtonColor : unselectedButtonColor,
        splashColor: isSelected ? buttonSplashColorNegative : buttonSplashColor,
        paddingHor: 14,
        paddingVert: 5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: boxBorderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
