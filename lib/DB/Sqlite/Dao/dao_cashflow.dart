import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoCashflow {
  static Future<void> insert(
    DsCashflow cashflow,
    String categoryId,
    String bankaccountId,
  ) async {
    final db = await SqlConnection.instance.database;
    await db.insert(
      TCashflow.tableName,
      _reverseMapper(cashflow, categoryId, bankaccountId),
    );
  }

  static Future<void> update(
    DsCashflow cashflow,
    String categoryId,
    String bankaccountId,
  ) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TCashflow.tableName,
      _reverseMapper(cashflow, categoryId, bankaccountId),
      where: "${TCashflow.id} = ?",
      whereArgs: [cashflow.getId],
    );
  }

  static Future<List<DsCashflow>> getAllByDate(
    String bankaccountId,
    DateTime fromDate,
    DateTime toDate,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: """
        ${TCashflow.bankaccountId} = ? AND
        ${TCashflow.timeStamp} >= ${fromDate.millisecondsSinceEpoch} AND
        ${TCashflow.timeStamp} <= ${toDate.millisecondsSinceEpoch}
      """,
      whereArgs: [bankaccountId],
    );
    return _mapperList(rawData);
  }

  static Future<List<DsCashflow>> getAllByTypeDate(
    String bankaccountId,
    int type,
    DateTime fromDate,
    DateTime toDate,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: """
        ${TCashflow.bankaccountId} = ? AND
        ${TCashflow.type} = ? AND
        ${TCashflow.timeStamp} >= ${fromDate.millisecondsSinceEpoch} AND
        ${TCashflow.timeStamp} <= ${toDate.millisecondsSinceEpoch}
      """,
      whereArgs: [bankaccountId, type],
    );
    return _mapperList(rawData);
  }

  static Future<List<DsCashflow>> getAllByTypeDateCategory(
    String bankaccountId,
    int type,
    DateTime fromDate,
    DateTime toDate,
    String categoriyId,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TCashflow.tableName,
      where: """
        ${TCashflow.bankaccountId} = ? AND
        ${TCashflow.type} = ? AND
        ${TCashflow.categoryId} = ? AND
        ${TCashflow.timeStamp} >= ${fromDate.millisecondsSinceEpoch} AND
        ${TCashflow.timeStamp} <= ${toDate.millisecondsSinceEpoch}
      """,
      whereArgs: [bankaccountId, type, categoriyId],
    );
    return _mapperList(rawData);
  }

  static Future<double> getSumByTypeDate(
    String bankaccountId,
    int type,
    DateTime fromDate,
    DateTime toDate,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.rawQuery("""
      SELECT SUM(${TCashflow.amount}) as SumAmount
      FROM ${TCashflow.tableName}
      WHERE ${TCashflow.bankaccountId} = '$bankaccountId' AND
        ${TCashflow.type} = $type AND
        ${TCashflow.timeStamp} >= ${fromDate.millisecondsSinceEpoch} AND
        ${TCashflow.timeStamp} <= ${toDate.millisecondsSinceEpoch};
    """);
    if (rawData.isEmpty || rawData[0]["SumAmount"] == null) return 0;
    return rawData[0]["SumAmount"];
  }

  static Future<double> getSumByTypeDateCategory(
    String bankaccountId,
    int type,
    DateTime fromDate,
    DateTime toDate,
    String categoriyId,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.rawQuery("""
      SELECT SUM(${TCashflow.amount}) as SumAmount
      FROM ${TCashflow.tableName}
      WHERE ${TCashflow.bankaccountId} = '$bankaccountId' AND
        ${TCashflow.type} = $type AND
        ${TCashflow.categoryId} = '$categoriyId' AND
        ${TCashflow.timeStamp} >= ${fromDate.millisecondsSinceEpoch} AND
        ${TCashflow.timeStamp} <= ${toDate.millisecondsSinceEpoch};
    """);
    if (rawData.isEmpty || rawData[0]["SumAmount"] == null) return 0;
    return rawData[0]["SumAmount"];
  }

  static Future<double> getSumByDateForBudget(
    String bankaccountId,
    DateTime fromDate,
    DateTime toDate,
    DsBudget budget,
  ) async {
    final db = await SqlConnection.instance.database;
    String sqlWhereCategires = "";
    if (budget.getCategories.isNotEmpty) {
      sqlWhereCategires += "(";
      for (var category in budget.getCategories) {
        sqlWhereCategires += "${TCashflow.categoryId} = '${category.getId}'";
        if (category != budget.getCategories.last) {
          sqlWhereCategires += " OR ";
        }
      }
      sqlWhereCategires += ") AND";
    }
    List<Map> rawData = await db.rawQuery("""
      SELECT 
        COALESCE(SUM(
          CASE WHEN ${TCashflow.type} = 1 OR ${TCashflow.type} = 3 
          THEN ${TCashflow.amount} ELSE 0 END
        ), 0) -
        COALESCE(SUM(
          CASE WHEN ${TCashflow.type} = 2 OR ${TCashflow.type} = 4 
          THEN ${TCashflow.amount} ELSE 0 END
        ), 0) AS Saldo
      FROM ${TCashflow.tableName}
      WHERE ${TCashflow.bankaccountId} = '$bankaccountId' AND
        $sqlWhereCategires
        ${TCashflow.timeStamp} >= ${fromDate.millisecondsSinceEpoch} AND
        ${TCashflow.timeStamp} <= ${toDate.millisecondsSinceEpoch};
    """);
    if (rawData.isEmpty || rawData[0]["Saldo"] == null) return 0;
    return rawData[0]["Saldo"];
  }

  // mapper

  static Future<DsCashflow> _mapper(Map value) async {
    DsCategory category = await DaoCategory.get(value[TCashflow.categoryId]);
    return DsCashflow(
      value[TCashflow.type],
      DateTime.fromMillisecondsSinceEpoch(value[TCashflow.timeStamp]).toUtc(),
      value[TCashflow.amount],
      value[TCashflow.id],
      value[TCashflow.note],
      category.getName,
    );
  }

  static Future<List<DsCashflow>> _mapperList(List<Map> rawData) async {
    List<DsCashflow> finalData = [];
    for (var value in rawData) {
      finalData.add(await _mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(
    DsCashflow cashflow,
    String categoryId,
    String bankaccountId,
  ) {
    return {
      TCashflow.id: cashflow.getId,
      TCashflow.type: cashflow.getType,
      TCashflow.timeStamp: cashflow.getDate.millisecondsSinceEpoch,
      TCashflow.amount: cashflow.getAmount,
      TCashflow.note: cashflow.getNote,
      TCashflow.categoryId: categoryId,
      TCashflow.bankaccountId: bankaccountId,
    };
  }
}
