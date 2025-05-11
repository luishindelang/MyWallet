import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/Style/style.dart';

class CCategorySelect extends StatelessWidget {
  const CCategorySelect({
    super.key,
    required this.onPressed,
    required this.category,
    required this.isSelected,
  });

  final Function onPressed;
  final DsCategory category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CTextButton(
        onPressed: onPressed,
        backgroundColor:
            isSelected ? selectedButtonColor : unselectedButtonColor,
        forgroundColor: isSelected ? textColorNegative : textColor,
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
                color: category.getColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(width: 10),
            Text(
              category.getName,
              style: isSelected ? selectCategory : unselectCategory,
            ),
          ],
        ),
      ),
    );
  }
}
