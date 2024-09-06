import 'package:mywallet/DB/Sqlite/Tables/t_account.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow_category.dart';

class TBudget {
  static const String tableName = "Budget";
  static const String id = "Id";
  static const String name = "Name";
  static const String amount = "Amount";
  static const String period = "Period";
  static const String accountId = "AccountId";
  static const String categoryId = "CategoryId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $amount REAL NOT NULL,
        $period INTEGER NOT NULL, 
        $accountId TEXT NOT NULL,
        $categoryId TEXT NOT NULL,
        FOREIGN KEY ($accountId) REFERENCES ${TAccount.tableName}(${TAccount.id}),
        FOREIGN KEY ($categoryId) REFERENCES ${TCashflowCategory.tableName}(${TCashflowCategory.id})
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
