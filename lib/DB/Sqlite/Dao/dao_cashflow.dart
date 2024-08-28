import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
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
    return DsCashflow(
      value[TCashflow.id],
      DateTime.parse(value[TCashflow.date]),
      value[TCashflow.note],
      value[TCashflow.amount],
      await DaoCashflowCategory.get(value[TCashflow.categoryId]),
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
      TCashflow.categoryId: cashflow.getCategory.getId,
      TCashflow.accountId: cashflow.getAccountId,
    };
  }
}
