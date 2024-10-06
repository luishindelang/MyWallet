import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CBoxList extends StatelessWidget {
  const CBoxList({
    super.key,
    required this.title,
    required this.onTextPressed,
    required this.buttonText,
    required this.child,
  });

  final String title;
  final Function onTextPressed;
  final String buttonText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: boxBorder, width: borderWith),
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
            child: Text(title, style: textL(text)),
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
              child: Text(buttonText, style: textM(text)),
            ),
          ),
        ],
      ),
    );
  }
}
