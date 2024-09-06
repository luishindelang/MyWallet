import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CSwitch extends StatelessWidget {
  const CSwitch({
    super.key,
    required this.value,
    required this.onchanged,
    this.acitveColor = switchActive,
    this.acitveTrackColor = switchActiveTrack,
    this.inactiveColor = switchInactive,
    this.inactiveTrackColor = switchInactiveTrack,
    this.borderColor = switchBorder,
  });

  final bool value;
  final Function(bool) onchanged;
  final Color acitveColor;
  final Color acitveTrackColor;
  final Color inactiveColor;
  final Color inactiveTrackColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: acitveColor,
      activeTrackColor: acitveTrackColor,
      inactiveThumbColor: inactiveColor,
      inactiveTrackColor: inactiveTrackColor,
      trackOutlineColor: WidgetStateProperty.all(borderColor),
      value: value,
      onChanged: (newValue) => onchanged(newValue),
    );
  }
}
