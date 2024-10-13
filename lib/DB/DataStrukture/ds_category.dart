import 'package:flutter/material.dart';

class DsCategory {
  String _id;
  String _name;
  Color _color;

  DsCategory(
    this._id,
    this._name,
    this._color,
  );

  String get getId => _id;
  String get getName => _name;
  Color get getColor => _color;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setColor(Color color) => _color = color;
}
