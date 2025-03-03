import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

class DaoBankaccount {
  static Future<void> insert(DsBankaccount bankaccount) async {
    final db = await SqlConnection.instance.database;
    await db.insert(TBankaccount.tableName, _reverseMapper(bankaccount));
  }

  static Future<void> update(DsBankaccount bankaccount) async {
    final db = await SqlConnection.instance.database;
    await db.update(
      TBankaccount.tableName,
      _reverseMapper(bankaccount),
      where: "${TBankaccount.id} = ?",
      whereArgs: [bankaccount.getId],
    );
  }

  static Future<List<DsBankaccount>> getAll() async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(TBankaccount.tableName);
    return _mapperList(rawData);
  }

  static Future<DsBankaccount> get(String id) async {
    final db = await SqlConnection.instance.database;
    List<Map> rawData = await db.query(
      TBankaccount.tableName,
      where: "${TBankaccount.id} = ?",
      whereArgs: [id],
    );
    if (rawData.isEmpty) return DsBankaccount("emtpy", 0);
    return _mapper(rawData[0]);
  }

  static Future<void> delete(DsBankaccount bankaccount) async {
    final db = await SqlConnection.instance.database;
    await db.delete(
      TBankaccount.tableName,
      where: "${TBankaccount.id} = ?",
      whereArgs: [bankaccount.getId],
    );
  }

  // mapper

  static Future<DsBankaccount> _mapper(Map value) async {
    return DsBankaccount(
      value[TBankaccount.name],
      value[TBankaccount.credit],
      value[TBankaccount.id],
      await DaoCategory.getBankaccountCategories(value[TBankaccount.id]),
    );
  }

  static Future<List<DsBankaccount>> _mapperList(List<Map> rawData) async {
    List<DsBankaccount> finalData = [];
    for (var value in rawData) {
      finalData.add(await _mapper(value));
    }
    return finalData;
  }

  static Map<String, Object?> _reverseMapper(DsBankaccount bankaccount) {
    return {
      TBankaccount.id: bankaccount.getId,
      TBankaccount.name: bankaccount.getName,
      TBankaccount.credit: bankaccount.getCredit,
    };
  }
}
