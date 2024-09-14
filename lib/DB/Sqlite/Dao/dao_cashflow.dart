import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoCashflow {
  static Future<void> insert(DsCashflow cashflow) async {
    final db = await SqlConnection.instance.database;
    await db.insert(
      TCashflow.tableName,
      _reverseMapper(cashflow),
    );
  }

  static Future<void> update(DsCashflow cashflow) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TCashflow.tableName,
      _reverseMapper(cashflow),
      where: "${TCashflow.id} = ?",
      whereArgs: [cashflow.getId],
    );
  }

  static Future<List<DsCashflow>> getAll(String accountId) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: "${TCashflow.accountId} = ?",
      whereArgs: [accountId],
    );
    return _mapperList(rawData);
  }

  static Future<DsCashflow> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: "${TCashflow.id} = ?",
      whereArgs: [id],
    );
    return _mapper(rawData[0]);
  }

  static Future<List<DsCashflow>> searchByCategory(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: "${TCashflow.categoryId} = ?",
      whereArgs: [id],
    );
    return _mapperList(rawData);
  }

  static Future<List<DsCashflow>> searchByDate(
    DateTime from,
    DateTime until,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: "${TCashflow.date} >= ? AND ${TCashflow.date} <= ?",
      whereArgs: [from, until],
    );
    return _mapperList(rawData);
  }

  static Future<double?> getSumOfPeriodAndCategory(
    DateTime from,
    DateTime until,
    String accountId,
    String categoryId,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.rawQuery(
      """
        SELECT SUM(${TCashflow.amount}) AS Sum
        FROM ${TCashflow.tableName} 
        WHERE ${TCashflow.date} >= ? 
        AND ${TCashflow.date} <= ? 
        AND ${TCashflow.accountId} = ? 
        AND ${TCashflow.categoryId} = ?;
      """,
      [from.toString(), until.toString(), accountId, categoryId],
    );

    if (rawData.isNotEmpty) {
      return rawData.first["Sum"];
    }
    return null;
  }

  static Future<double?> getSumOfPeriod(
    DateTime from,
    DateTime until,
    String accountId,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.rawQuery(
      """
        SELECT SUM(${TCashflow.amount}) AS Sum
        FROM ${TCashflow.tableName} 
        WHERE ${TCashflow.date} >= ? 
        AND ${TCashflow.date} <= ? 
        AND ${TCashflow.accountId} = ?;
      """,
      [from.toString(), until.toString(), accountId],
    );

    if (rawData.isNotEmpty) {
      return rawData.first["Sum"];
    }
    return null;
  }

  static Future<void> delete(String id) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TCashflow.tableName,
      where: "${TCashflow.id} = ?",
      whereArgs: [id],
    );
  }

  //mapper

  static Future<DsCashflow> _mapper(Map value) async {
    DsCashflowCategory? cat;
    if (value[TCashflow.categoryId] != null) {
      cat = await DaoCashflowCategory.get(value[TCashflow.categoryId]);
    }
    return DsCashflow(
      value[TCashflow.id],
      DateTime.parse(value[TCashflow.date]),
      value[TCashflow.note],
      value[TCashflow.amount],
      cat,
      value[TCashflow.accountId],
    );
  }

  static Future<List<DsCashflow>> _mapperList(List<Map> rawData) async {
    List<DsCashflow> finalData = [];
    for (var value in rawData) {
      finalData.add(await _mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsCashflow cashflow) {
    return {
      TCashflow.id: cashflow.getId,
      TCashflow.date: cashflow.getDate.toString(),
      TCashflow.note: cashflow.getNote,
      TCashflow.amount: cashflow.getAmount,
      TCashflow.categoryId: cashflow.getCategory?.getId,
      TCashflow.accountId: cashflow.getAccountId,
    };
  }
}
