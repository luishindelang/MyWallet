import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';

class DsCashflow {
  String _id;
  DateTime _date;
  String _note;
  double _amount;
  DsCashflowCategory? _category;
  String _accountId;

  DsCashflow(
    this._id,
    this._date,
    this._note,
    this._amount,
    this._category,
    this._accountId,
  );

  String get getId => _id;
  DateTime get getDate => _date;
  String get getNote => _note;
  double get getAmount => _amount;
  DsCashflowCategory? get getCategory => _category;
  String get getAccountId => _accountId;

  set setId(String id) => _id = id;
  set setDate(DateTime date) => _date = date;
  set setNote(String note) => _note = note;
  set setAmount(double amount) => _amount = amount;
  set setCategory(DsCashflowCategory? category) => _category = category;
  set setAccountId(String accountId) => _accountId = accountId;
}
