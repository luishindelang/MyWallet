String formatDouble(double d, {int digits = 2}) {
  return d.toStringAsFixed(digits).replaceAll(RegExp(r'\.?0+$'), '');
}
