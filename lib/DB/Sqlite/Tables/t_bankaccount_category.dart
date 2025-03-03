import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';

class TBankaccountCategory {
  static const String tableName = "BankaccountCategory";
  static const String bankaccountId = "BankaccountId";
  static const String categoryId = "CategoryId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $bankaccountId TEXT NOT NULL,
        $categoryId TEXT NOT NULL,
        FOREIGN KEY ($bankaccountId) REFERENCES ${TBankaccount.tableName}(${TBankaccount.id}),
        FOREIGN KEY ($categoryId) REFERENCES ${TCategory.tableName}(${TCategory.id}),
        PRIMARY KEY ($bankaccountId, $categoryId)
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
