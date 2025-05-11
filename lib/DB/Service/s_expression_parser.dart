class ExpressionParser {
  String input;
  int _pos = 0;

  ExpressionParser(this.input) {
    input = input.replaceAll(' ', '');

    if (input.isNotEmpty && RegExp(r'[+–×÷]$').hasMatch(input)) {
      input = input.substring(0, input.length - 1);
    }

    final openCount = '('.allMatches(input).length;
    final closeCount = ')'.allMatches(input).length;
    if (openCount > closeCount) {
      input += ')' * (openCount - closeCount);
    }
  }

  double parse() {
    _pos = 0;
    final value = _parseExpression();
    if (_pos < input.length) {
      throw FormatException(
        'Unerwartetes Zeichen bei Position $_pos: ${input[_pos]}',
      );
    }
    return value;
  }

  double _parseExpression() {
    double value = _parseTerm();
    while (_pos < input.length) {
      final op = input[_pos];
      if (op == '+' || op == '–') {
        _pos++;
        final rhs = _parseTerm();
        value = (op == '+') ? value + rhs : value - rhs;
      } else {
        break;
      }
    }
    return value;
  }

  double _parseTerm() {
    double value = _parseFactor();
    while (_pos < input.length) {
      final op = input[_pos];
      if (op == '×' || op == '÷') {
        _pos++;
        final rhs = _parseFactor();
        value = (op == '×') ? value * rhs : value / rhs;
      } else {
        break;
      }
    }
    return value;
  }

  double _parseFactor() {
    if (_pos < input.length && (input[_pos] == '+' || input[_pos] == '–')) {
      final isNegative = input[_pos] == '–';
      _pos++;
      final value = _parseFactor();
      return isNegative ? -value : value;
    }

    if (_pos < input.length && input[_pos] == '(') {
      _pos++;
      final value = _parseExpression();
      if (_pos >= input.length || input[_pos] != ')') {
        throw FormatException(
          'Fehlende schließende Klammer bei Position $_pos',
        );
      }
      _pos++;
      return value;
    }

    final start = _pos;
    bool sawDot = false;
    while (_pos < input.length &&
        (RegExp(r'\d').hasMatch(input[_pos]) ||
            (input[_pos] == '.' && !sawDot))) {
      if (input[_pos] == '.') sawDot = true;
      _pos++;
    }
    if (start == _pos) {
      throw FormatException('Erwartete Zahl bei Position $_pos');
    }
    final numberStr = input.substring(start, _pos);
    return double.parse(numberStr);
  }
}
