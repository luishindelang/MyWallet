class DsTransfer {
  String _id;
  String _name;
  double _amount;
  DateTime _date;
  String _fromAccountId;
  String _toAccountId;

  DsTransfer(
    this._id,
    this._name,
    this._amount,
    this._date,
    this._fromAccountId,
    this._toAccountId,
  );

  String get getId => _id;
  String get getName => _name;
  double get getAmount => _amount;
  DateTime get getDate => _date;
  String get getFromAccountId => _fromAccountId;
  String get getToAccountId => _toAccountId;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setAmount(double amount) => _amount = amount;
  set setDate(DateTime date) => _date = date;
  set setFromAccountId(String id) => _fromAccountId = id;
  set setToAccountId(String id) => _toAccountId = id;
}
