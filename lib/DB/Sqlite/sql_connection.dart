import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlConnection {
  static Database? _db;
  static final SqlConnection instance = SqlConnection._constructor();

  final String dbName = "mywallet.db";

  SqlConnection._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _getDatabase();
    return _db!;
  }

  Future<Database> _getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, dbName);
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        createTables(db);
      },
    );
    return database;
  }

  static Future<void> createTables(Database db) async {
    await db.execute(TBankaccount.createTable());
    await db.execute(TBankaccountBudget.createTable());
    await db.execute(TBankaccountCategory.createTable());
    await db.execute(TBudget.createTable());
    await db.execute(TCashflow.createTable());
    await db.execute(TCategory.createTable());
  }

  static Future<void> deleteTables(Database db) async {
    await db.execute(TBankaccount.deleteTable());
    await db.execute(TBankaccountBudget.deleteTable());
    await db.execute(TBankaccountCategory.deleteTable());
    await db.execute(TBudget.deleteTable());
    await db.execute(TCashflow.deleteTable());
    await db.execute(TCategory.deleteTable());
  }
}
