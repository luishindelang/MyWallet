import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';

class TBankaccountBudget {
  static const String tableName = "BankaccountBudget";
  static const String budgetId = "BudgetId";
  static const String categoryId = "CategoryId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $budgetId TEXT PRIMARY KEY,
        $categoryId TEXT PRIMARY KEY,
        FOREIGN KEY ($budgetId) REFERENCES ${TBudget.tableName}(${TBudget.id}),
        FOREIGN KEY ($categoryId) REFERENCES ${TCategory.tableName}(${TCategory.id}),
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
