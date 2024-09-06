import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CEventBox extends StatelessWidget {
  const CEventBox({
    super.key,
    required this.title,
    required this.onMorePressed,
    required this.onTextPressed,
    required this.buttonText,
    required this.child,
    this.borderColor = boxBorder,
  });

  final String title;
  final Function onMorePressed;
  final Function onTextPressed;
  final String buttonText;
  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: boxMargin,
      decoration: BoxDecoration(
        color: boxBackround,
        border: Border.all(color: borderColor, width: borderWith),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: boxShadow,
            spreadRadius: shadowRadius,
            offset: Offset(shadowRadius, shadowRadius),
            blurRadius: shadowBlur,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: boxTitlePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: textL(text)),
                CIconButton(
                  onPressed: () => onMorePressed(),
                  icons: Icons.more_vert_rounded,
                  size: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: boxChildPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child,
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: boxBorder, width: borderWith),
                    ),
                  ),
                  child: const Row(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CTextButton(
              onPressed: () => onTextPressed(),
              backgroundColor: Colors.transparent,
              paddingHor: 2,
              paddingVert: 0,
              child: Text(buttonText, style: textM(textSelected)),
            ),
          ),
        ],
      ),
    );
  }
}
