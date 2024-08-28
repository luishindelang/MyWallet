import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_budget.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow_category.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoCashflowCategory {
  static Future<void> insert(DsCashflowCategory category) async {
    final db = await SqlConnection.instance.database;
    await db.insert(
      TCashflowCategory.tableName,
      _reverseMapper(category),
    );
  }

  static Future<void> update(DsCashflowCategory category) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TCashflowCategory.tableName,
      _reverseMapper(category),
      where: "${TCashflowCategory.id} = ?",
      whereArgs: [category.getId],
    );
  }

  static Future<List<DsCashflowCategory>> getAll() async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(TCashflowCategory.tableName);
    return _mapperList(rawData);
  }

  static Future<DsCashflowCategory> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflowCategory.tableName,
      where: "${TCashflowCategory.id} = ?",
      whereArgs: [id],
    );
    return _mapper(rawData[0]);
  }

  static Future<List<DsCashflowCategory>> search(String name) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflowCategory.tableName,
      where: "${TCashflowCategory.name} LIKE ?",
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
        TCashflowCategory.tableName,
        where: "${TCashflowCategory.id} = ?",
        whereArgs: [id],
      );
    }
  }

  //mapper

  static DsCashflowCategory _mapper(Map value) {
    return DsCashflowCategory(
      value[TCashflowCategory.id],
      value[TCashflowCategory.name],
      Color(value[TCashflowCategory.color]),
    );
  }

  static List<DsCashflowCategory> _mapperList(List<Map> rawData) {
    List<DsCashflowCategory> finalData = [];
    for (var value in rawData) {
      finalData.add(_mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsCashflowCategory category) {
    return {
      TCashflowCategory.id: category.getId,
      TCashflowCategory.name: category.getName,
      TCashflowCategory.color: category.getColor.value,
    };
  }
}
