import 'package:mywallet/DB/DataStrukture/ds_transfer.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_transfer.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoTransfer {
  static Future<void> insert(DsTransfer transfer) async {
    final db = await SqlConnection.instance.database;
    await db.insert(
      TTransfer.tableName,
      _reverseMapper(transfer),
    );
  }

  static Future<void> update(DsTransfer transfer) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TTransfer.tableName,
      _reverseMapper(transfer),
      where: "${TTransfer.id} = ?",
      whereArgs: [transfer.getId],
    );
  }

  static Future<List<DsTransfer>> getAll(String accountId) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TTransfer.tableName,
      where: "${TTransfer.fromAccount} = ? OR ${TTransfer.toAccount} = ?",
      whereArgs: [accountId, accountId],
    );
    return _mapperList(rawData);
  }

  static Future<List<DsTransfer>> searchByDate(
    DateTime from,
    DateTime until,
  ) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TTransfer.tableName,
      where: "${TTransfer.date} >= ? AND ${TTransfer.date} <= ?",
      whereArgs: [from, until],
    );
    return _mapperList(rawData);
  }

  static Future<void> delete(String id) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TTransfer.tableName,
      where: "${TTransfer.id} = ?",
      whereArgs: [id],
    );
  }

  //mapper

  static DsTransfer _mapper(Map value) {
    return DsTransfer(
      value[TTransfer.id],
      value[TTransfer.name],
      value[TTransfer.amount],
      DateTime.parse(value[TTransfer.date]),
      value[TTransfer.fromAccount],
      value[TTransfer.toAccount],
    );
  }

  static List<DsTransfer> _mapperList(List<Map> rawData) {
    List<DsTransfer> finalData = [];
    for (var value in rawData) {
      finalData.add(_mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsTransfer transfer) {
    return {
      TTransfer.id: transfer.getId,
      TTransfer.name: transfer.getName,
      TTransfer.amount: transfer.getAmount,
      TTransfer.date: transfer.getDate.toString(),
      TTransfer.fromAccount: transfer.getFromAccountId,
      TTransfer.toAccount: transfer.getToAccountId,
    };
  }
}
