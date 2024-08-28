import 'package:mywallet/DB/Sqlite/Tables/t_account.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow_category.dart';

class TCashflow {
  static const String tableName = "Cashflow";
  static const String id = "Id";
  static const String date = "Date";
  static const String note = "Name";
  static const String amount = "Amount";
  static const String categoryId = "CategoryId";
  static const String accountId = "AccountId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $date TEXT NOT NULL,
        $note TEXT NOT NULL,
        $amount REAL NOT NULL,
        $categoryId TEXT NOT NULL
        $accountId TEXT NOT NULL,
        FOREIGN KEY ($categoryId) REFERENCES ${TCashflowCategory.tableName}(${TCashflowCategory.id}),
        FOREIGN KEY ($accountId) REFERENCES ${TAccount.tableName}(${TAccount.id})
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
