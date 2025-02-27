import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';

class TBankaccountCategory {
  static const String tableName = "BankaccountCategory";
  static const String bankaccountId = "BankaccountId";
  static const String categoryId = "CategoryId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $bankaccountId TEXT PRIMARY KEY,
        $categoryId TEXT PRIMARY KEY,
        FOREIGN KEY ($bankaccountId) REFERENCES ${TBankaccount.tableName}(${TBankaccount.id}),
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
