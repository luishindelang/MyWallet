import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late DsBankaccount bankaccount;
  late DsBankaccount secondBankaccount;

  setUp(() async {
    await SqlConnection.resetDB();

    bankaccount = DsBankaccount("name", 100);
    secondBankaccount = DsBankaccount("second name", 4000);
  });

  group("Testing Dao Dankaccount", () {
    test("insert", () async {
      await DaoBankaccount.insert(bankaccount);

      final db = await SqlConnection.instance.database;
      List<Map> rawData = await db.query(TBankaccount.tableName);

      expect(rawData[0][TBankaccount.id], bankaccount.getId);
      expect(rawData[0][TBankaccount.name], bankaccount.getName);
      expect(rawData[0][TBankaccount.credit], bankaccount.getCredit);
    });

    test("update", () async {
      await DaoBankaccount.insert(bankaccount);

      bankaccount.setName = "new Name";
      bankaccount.setCredit = 400;

      await DaoBankaccount.update(bankaccount);

      final db = await SqlConnection.instance.database;
      List<Map> rawData = await db.query(TBankaccount.tableName);

      expect(rawData[0][TBankaccount.id], bankaccount.getId);
      expect(rawData[0][TBankaccount.name], bankaccount.getName);
      expect(rawData[0][TBankaccount.credit], bankaccount.getCredit);
    });

    test("getAll", () async {
      await DaoBankaccount.insert(bankaccount);
      await DaoBankaccount.insert(secondBankaccount);

      List<DsBankaccount> list = await DaoBankaccount.getAll();

      expect(list.first.getId, bankaccount.getId);
      expect(list.last.getId, secondBankaccount.getId);
    });

    test("get", () async {
      await DaoBankaccount.insert(bankaccount);

      DsBankaccount list = await DaoBankaccount.get(bankaccount.getId);

      expect(list.getId, bankaccount.getId);
    });

    test("delete", () async {});
  });
}
