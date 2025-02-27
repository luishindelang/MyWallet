import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';

class TBankaccountBudget {
  static const String tableName = "BankaccountBudget";
  static const String bankaccountId = "BankaccountId";
  static const String budgetId = "BudgetId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $bankaccountId TEXT PRIMARY KEY,
        $budgetId TEXT PRIMARY KEY,
        FOREIGN KEY ($bankaccountId) REFERENCES ${TBankaccount.tableName}(${TBankaccount.id}),
        FOREIGN KEY ($budgetId) REFERENCES ${TBudget.tableName}(${TBudget.id}),
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
