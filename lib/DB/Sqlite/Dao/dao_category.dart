import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoCategory {
  static Future<void> insert(DsCategory category) async {
    final db = await SqlConnection.instance.database;
    await db.insert(TCategory.tableName, _reverseMapper(category));
  }

  static Future<void> insertBankaccountCategory(
    DsCategory category,
    String bankaccountId,
  ) async {
    await insert(category);
    final db = await SqlConnection.instance.database;
    await db.insert(TBankaccountCategory.tableName, {
      TBankaccountCategory.bankaccountId: bankaccountId,
      TBankaccountCategory.categoryId: category.getId,
    });
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

  static Future<List<DsCategory>> getBankaccountCategories(
    String bankaccountId,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.rawQuery("""
      SELECT c.*
      FROM ${TCategory.tableName} c
      LEFT JOIN ${TBankaccountCategory.tableName} ac ON 
        c.${TCategory.id} = ac.${TBankaccountCategory.categoryId}
      WHERE ac.${TBankaccountCategory.bankaccountId} = '$bankaccountId' OR 
        ac.${TBankaccountCategory.categoryId} IS NULL;
    """);
    return _mapperList(rawData);
  }

  static Future<List<DsCategory>> getBudgetCategories(String budgetId) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.rawQuery("""
      SELECT c.*
      FROM ${TCategory.tableName} c
      LEFT JOIN ${TBudgetCategory.tableName} bc ON
        c.${TCategory.id} = bc.${TBudgetCategory.categoryId}
      WHERE bc.${TBudgetCategory.budgetId} = '$budgetId';
    """);
    return _mapperList(rawData);
  }

  static Future<DsCategory> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCategory.tableName,
      where: "${TCategory.id} = ?",
      whereArgs: [id],
    );
    if (rawData.isEmpty) return DsCategory("empty", Colors.white);
    return _mapper(rawData[0]);
  }

  static Future<void> delete(DsCategory category) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TCategory.tableName,
      where: "${TCategory.id} = ?",
      whereArgs: [category.getId],
    );
  }

  // mapper

  static Future<DsCategory> _mapper(Map value) async {
    return DsCategory(
      value[TCategory.name],
      Color(value[TCategory.color]),
      value[TCategory.id],
    );
  }

  static Future<List<DsCategory>> _mapperList(List<Map> rawData) async {
    List<DsCategory> finalData = [];
    for (var value in rawData) {
      finalData.add(await _mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsCategory category) {
    return {
      TCategory.id: category.getId,
      TCategory.name: category.getName,
      TCategory.color: category.getColor.toARGB32(),
    };
  }
}
