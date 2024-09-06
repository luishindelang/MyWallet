import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Style/style.dart';

class CTextSwitch extends StatelessWidget {
  const CTextSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.child,
    this.activeColor = buttonBackground,
    this.activeBackgroundColor = buttonForground,
    this.inactiveColor = buttonForground,
    this.inactiveBackgroundColor = buttonBackground,
  });

  final bool value;
  final Function(bool) onChanged;
  final Widget child;
  final Color activeColor;
  final Color activeBackgroundColor;
  final Color inactiveColor;
  final Color inactiveBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: value ? activeBackgroundColor : inactiveColor,
          width: borderWith,
        ),
        borderRadius: BorderRadius.circular(borderRadius + 1),
      ),
      child: CTextButton(
        onPressed: () => onChanged(!value),
        backgroundColor:
            value ? activeBackgroundColor : inactiveBackgroundColor,
        forgroundColor: value ? activeColor : inactiveColor,
        child: Padding(padding: const EdgeInsets.all(6), child: child),
      ),
    );
  }
}
