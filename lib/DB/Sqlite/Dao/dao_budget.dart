import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget_category.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoBudget {
  static Future<void> insert(DsBudget budget) async {
    final db = await SqlConnection.instance.database;
    await db.insert(TBudget.tableName, _reverseMapper(budget));
    for (var category in budget.getCategories) {
      await db.insert(TBudgetCategory.tableName, {
        TBudgetCategory.budgetId: budget.getId,
        TBudgetCategory.categoryId: category.getId,
      });
    }
  }

  static Future<void> update(DsBudget budget) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TBudget.tableName,
      _reverseMapper(budget),
      where: "${TBudget.id} = ?",
      whereArgs: [budget.getId],
    );
    await db.delete(
      TBudgetCategory.tableName,
      where: "${TBudgetCategory.budgetId} = ?",
      whereArgs: [budget.getId],
    );
    for (var category in budget.getCategories) {
      await db.insert(TBudgetCategory.tableName, {
        TBudgetCategory.budgetId: budget.getId,
        TBudgetCategory.categoryId: category.getId,
      });
    }
  }

  static Future<List<DsBudget>> getAll() async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(TBudget.tableName);
    return _mapperList(rawData);
  }

  static Future<DsBudget> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TBudget.tableName,
      where: "${TBudget.id} = ?",
      whereArgs: [id],
    );
    if (rawData.isEmpty) return DsBudget("empty", 0, 0, Colors.white);
    return _mapper(rawData[0]);
  }

  static Future<void> delete(DsBudget budget) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TBudget.tableName,
      where: "${TBudget.id} = ?",
      whereArgs: [budget.getId],
    );
  }

  // mapper

  static Future<DsBudget> _mapper(Map value) async {
    return DsBudget(
      value[TBudget.name],
      value[TBudget.budget],
      value[TBudget.period],
      Color(value[TBudget.color]),
      value[TBudget.id],
      await DaoCategory.getBudgetCategories(value[TBudget.id]),
    );
  }

  static Future<List<DsBudget>> _mapperList(List<Map> rawData) async {
    List<DsBudget> finalData = [];
    for (var value in rawData) {
      finalData.add(await _mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsBudget budget) {
    return {
      TBudget.id: budget.getId,
      TBudget.name: budget.getName,
      TBudget.budget: budget.getBudget,
      TBudget.period: budget.getPeriod,
      TBudget.color: budget.getColor.toARGB32(),
    };
  }
}
