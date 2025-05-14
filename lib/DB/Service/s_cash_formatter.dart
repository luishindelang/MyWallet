String cashFormatter(double cash, String curreny, {int dezimal = 2}) {
  String string = cash.toStringAsFixed(dezimal);
  return "${string.replaceAll(".", ",")} $curreny";
}
