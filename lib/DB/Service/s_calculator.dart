String addNumToNum(String num, int numToAdd) {
  if (numToAdd == 10) {
    if (num.isEmpty) {
      return "0.0";
    }
    if (num.contains(".")) {
      return num;
    }
    return "$num.0";
  }
  if (numToAdd == -1) {
    if (num.isEmpty) {
      return num;
    }
    return num.substring(0, num.length - 1);
  }
  if (numToAdd == -2) {
    return "delete";
  }

  if (num.contains(".0")) {
    return "${num.substring(0, num.length - 1)}$numToAdd";
  }
  return "$num$numToAdd";
}

String cutNum(String num, int length) {
  if (num.length <= length) return num;
  return "...${num.substring(num.length - (length - 1))}";
}
