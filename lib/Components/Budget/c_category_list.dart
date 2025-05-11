import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/Style/style.dart';

class CCategoryList extends StatelessWidget {
  const CCategoryList({
    super.key,
    required this.category,
    required this.onClose,
  });

  final DsCategory category;
  final Function onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: unselectedButtonColor,
          borderRadius: BorderRadius.circular(roundedButtonRadius),
        ),
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: category.getColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(width: 10),
            Text(category.getName, style: unselectCategory),
            CTextButton(
              onPressed: onClose,
              backgroundColor: unselectedButtonColor,
              forgroundColor: textColor,
              splashColor: buttonSplashColor,
              paddingHor: 5,
              paddingVert: 5,
              child: Icon(Icons.close_rounded, color: textColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
