import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_budget.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_transfer.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_account.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_transfer.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoAccount {
  static Future<void> insert(DsAccount account) async {
    final db = await SqlConnection.instance.database;
    await db.insert(TAccount.tableName, _reverseMapper(account));
  }

  static Future<void> update(DsAccount account) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TAccount.tableName,
      _reverseMapper(account),
      where: "${TAccount.id} = ?",
      whereArgs: [account.getId],
    );
  }

  static Future<List<DsAccount>> getAll() async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(TAccount.tableName);
    return _mapperList(rawData);
  }

  static Future<DsAccount> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TAccount.tableName,
      where: "${TAccount.id} = ?",
      whereArgs: [id],
    );
    return _mapper(rawData[0]);
  }

  static Future<void> delete(String id) async {
    final db = await SqlConnection.instance.database;
    var listCashflow = await DaoCashflow.getAll(id);
    var listBudget = await DaoBudget.getAll(id);
    var listTransfer = await DaoTransfer.getAll(id);
    if (listCashflow.isEmpty && listBudget.isEmpty && listTransfer.isEmpty) {
      await db.delete(
        TAccount.tableName,
        where: "${TAccount.id} = ?",
        whereArgs: [id],
      );
    }
  }

  //mapper

  static Future<DsAccount> _mapper(Map value) async {
    return DsAccount(
      value[TAccount.id],
      value[TAccount.name],
      value[TAccount.credit],
      await DaoBudget.getAll(value[TAccount.id]),
      await DaoCashflow.getAll(value[TAccount.id]),
      await DaoTransfer.getAll(value[TTransfer.id]),
    );
  }

  static Future<List<DsAccount>> _mapperList(List<Map> rawData) async {
    List<DsAccount> finalData = [];
    for (var value in rawData) {
      finalData.add(await _mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsAccount account) {
    return {
      TAccount.id: account.getId,
      TAccount.name: account.getName,
      TAccount.credit: account.getCredit,
    };
  }
}
