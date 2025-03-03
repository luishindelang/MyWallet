import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';

class TBudgetCategory {
  static const String tableName = "BankaccountBudget";
  static const String budgetId = "BudgetId";
  static const String categoryId = "CategoryId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $budgetId TEXT NOT NULL,
        $categoryId TEXT NOT NULL,
        FOREIGN KEY ($budgetId) REFERENCES ${TBudget.tableName}(${TBudget.id}),
        FOREIGN KEY ($categoryId) REFERENCES ${TCategory.tableName}(${TCategory.id}),
        PRIMARY KEY ($budgetId, $categoryId)
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
