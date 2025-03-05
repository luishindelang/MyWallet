import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_settings.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group("Testing SqlConnection", () {
    test("initializing DB", () async {
      final db = await SqlConnection.instance.database;

      try {
        expect(db.isOpen, true);
      } catch (e) {
        expect(e, "");
      }
    });

    test("initializing Tables", () async {
      final db = await SqlConnection.instance.database;

      List tableList = [
        TBankaccount.tableName,
        TBankaccountCategory.tableName,
        TBudgetCategory.tableName,
        TBudget.tableName,
        TCashflow.tableName,
        TCategory.tableName,
        TSettings.tableName,
      ];

      await SqlConnection.resetDB();

      List<Map> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table';",
      );

      for (var value in tables) {
        expect(tableList.contains(value["name"]), true);
      }
    });
  });
}
