import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoBudget {
  static Future<void> insert(DsBudget budget) async {
    final db = await SqlConnection.instance.database;
    await db.insert(
      TBudget.tableName,
      _reverseMapper(budget),
    );
  }

  static Future<void> update(DsBudget budget) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TBudget.tableName,
      _reverseMapper(budget),
      where: "${TBudget.id} = ?",
      whereArgs: [budget.getId],
    );
  }

  static Future<List<DsBudget>> getAll(String accountId) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TBudget.tableName,
      where: "${TBudget.accountId} = ?",
      whereArgs: [accountId],
    );
    return _mapperList(rawData);
  }

  static Future<DsBudget> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TBudget.tableName,
      where: "${TBudget.id} = ?",
      whereArgs: [id],
    );
    return _mapper(rawData[0]);
  }

  static Future<List<DsBudget>> searchByCategory(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TBudget.tableName,
      where: "${TBudget.categoryId} = ?",
      whereArgs: [id],
    );
    return _mapperList(rawData);
  }

  static Future<List<DsBudget>> searchByName(String name) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TBudget.tableName,
      where: "${TBudget.name} LIKE ?",
      whereArgs: [name],
    );
    return _mapperList(rawData);
  }

  static Future<void> delete(String id) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TBudget.tableName,
      where: "${TBudget.id} = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteAllByAccount(String accountId) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TBudget.tableName,
      where: "${TBudget.accountId} = ?",
      whereArgs: [accountId],
    );
  }

  //mapper

  static Future<DsBudget> _mapper(Map value) async {
    return DsBudget(
      value[TBudget.id],
      value[TBudget.name],
      value[TBudget.amount],
      value[TBudget.period],
      await DaoCategory.get(value[TBudget.categoryId]),
      value[TBudget.accountId],
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
      TBudget.amount: budget.getAmount,
      TBudget.period: budget.getPeriod,
      TBudget.categoryId: budget.getCategory.getId,
      TBudget.accountId: budget.getAccountId,
    };
  }
}
