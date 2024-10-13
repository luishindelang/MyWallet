import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_budget.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoCategory {
  static Future<void> insert(DsCategory category) async {
    final db = await SqlConnection.instance.database;
    await db.insert(
      TCategory.tableName,
      _reverseMapper(category),
    );
  }

  static Future<void> update(DsCategory category) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TCategory.tableName,
      _reverseMapper(category),
      where: "${TCategory.id} = ?",
      whereArgs: [category.getId],
    );
  }

  static Future<List<DsCategory>> getAll() async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(TCategory.tableName);
    return _mapperList(rawData);
  }

  static Future<DsCategory> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCategory.tableName,
      where: "${TCategory.id} = ?",
      whereArgs: [id],
    );
    return _mapper(rawData[0]);
  }

  static Future<List<DsCategory>> search(String name) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCategory.tableName,
      where: "${TCategory.name} LIKE ?",
      whereArgs: [name],
    );
    return _mapperList(rawData);
  }

  static Future<void> delete(String id) async {
    final db = await SqlConnection.instance.database;
    var listCashflow = await DaoCashflow.searchByCategory(id);
    var listBuget = await DaoBudget.searchByCategory(id);
    if (listCashflow.isEmpty && listBuget.isEmpty) {
      await db.delete(
        TCategory.tableName,
        where: "${TCategory.id} = ?",
        whereArgs: [id],
      );
    }
  }

  //mapper

  static DsCategory _mapper(Map value) {
    return DsCategory(
      value[TCategory.id],
      value[TCategory.name],
      Color(value[TCategory.color]),
    );
  }

  static List<DsCategory> _mapperList(List<Map> rawData) {
    List<DsCategory> finalData = [];
    for (var value in rawData) {
      finalData.add(_mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsCategory category) {
    return {
      TCategory.id: category.getId,
      TCategory.name: category.getName,
      TCategory.color: category.getColor.value,
    };
  }
}
