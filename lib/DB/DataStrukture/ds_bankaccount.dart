class DsBankaccount {
  String _id;
  String _name;
  double _credit;

  DsBankaccount(this._id, this._name, this._credit);

  String get getId => _id;
  String get getName => _name;
  double get getCredit => _credit;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setCredit(double credit) => _credit = credit;
}
