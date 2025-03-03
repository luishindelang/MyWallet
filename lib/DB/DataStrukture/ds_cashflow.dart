import 'package:mywallet/DB/Service/s_uuid.dart';

class DsCashflow {
  String _id;
  int _type;
  DateTime _date;
  double _amount;
  String _note;
  String _categoryName;

  DsCashflow(
    this._type,
    this._date,
    this._amount, [
    this._id = "0",
    this._note = "",
    this._categoryName = "",
  ]) {
    if (_id == "0") {
      _id = uuid();
    }
  }

  String get getId => _id;
  int get getType => _type;
  DateTime get getDate => _date;
  double get getAmount => _amount;
  String get getNote => _note;
  String get getCategoryName => _categoryName;

  set setId(String id) => _id = id;
  set setType(int type) => _type = type;
  set setDate(DateTime date) => _date = date;
  set setAmount(double amount) => _amount = amount;
  set setNote(String note) => _note = note;
  set setCategoryName(String categoryName) => _categoryName = categoryName;
}
