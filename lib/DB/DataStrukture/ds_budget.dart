import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';

class DsBudget {
  String _id;
  String _name;
  double _budget;
  int _period;
  Color _color;
  List<DsCategory> _categories;

  DsBudget(
    this._name,
    this._budget,
    this._period,
    this._color, [
    this._id = "0",
    this._categories = const [],
  ]) {
    if (_id == "0") {
      _id = uuid();
    }
  }

  String get getId => _id;
  String get getName => _name;
  double get getBudget => _budget;
  int get getPeriod => _period;
  Color get getColor => _color;
  List<DsCategory> get getCategories => _categories;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setBudget(double budget) => _budget = budget;
  set setPeriod(int period) => _period = period;
  set setColor(Color color) => _color = color;
  set setCategories(List<DsCategory> categories) => _categories = categories;

  void addCategory(DsCategory category) => _categories.add(category);
  void removeCategory(DsCategory category) => _categories.remove(category);
}
