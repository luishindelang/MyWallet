String dayMonth(DateTime date) {
  String day = date.day.toString().padLeft(2, "0");
  String month = date.month.toString().padLeft(2, "0");
  return "$day.$month.";
}
