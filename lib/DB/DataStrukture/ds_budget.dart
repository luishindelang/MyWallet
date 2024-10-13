import 'package:mywallet/DB/DataStrukture/ds_category.dart';

class DsBudget {
  String _id;
  String _name;
  double _amount;
  int _period;
  DsCategory _category;
  String _accountId;

  DsBudget(
    this._id,
    this._name,
    this._amount,
    this._period,
    this._category,
    this._accountId,
  );

  String get getId => _id;
  String get getName => _name;
  double get getAmount => _amount;
  int get getPeriod => _period;
  DsCategory get getCategory => _category;
  String get getAccountId => _accountId;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setAmount(double amount) => _amount = amount;
  set setPeriod(int period) => _period = period;
  set setCategory(DsCategory category) => _category = category;
  set setAccountId(String accountId) => _accountId = accountId;
}
