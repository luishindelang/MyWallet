import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';

class TCashflow {
  static const String tableName = "Cashflow";
  static const String id = "Id";
  static const String type = "Type";
  static const String timeStamp = "TimeStamp";
  static const String amount = "Amount";
  static const String note = "Note";
  static const String categoryId = "CategoryId";
  static const String bankaccountId = "BankaccountId";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $type INTEGER NOT NULL,
        $timeStamp INTEGER NOT NULL,
        $amount REAL NOT NULL,
        $note TEXT NOT NULL,
        $categoryId TEXT NOT NULL,
        $bankaccountId TEXT NOT NULL,
        FOREIGN KEY ($categoryId) REFERENCES ${TCategory.tableName}(${TCategory.id}),
        FOREIGN KEY ($bankaccountId) REFERENCES ${TBankaccount.tableName}(${TBankaccount.id})
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
