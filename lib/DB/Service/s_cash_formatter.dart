String cashFormatter(double cash, String curreny) {
  return "${cash.toString().replaceAll(".", ",")} $curreny";
}
