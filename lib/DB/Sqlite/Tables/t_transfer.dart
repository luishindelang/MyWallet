import 'package:mywallet/DB/Sqlite/Tables/t_account.dart';

class TTransfer {
  static const String tableName = "Transfer";
  static const String id = "Id";
  static const String name = "Name";
  static const String amount = "Amount";
  static const String date = "Date";
  static const String fromAccount = "FromAccount";
  static const String toAccount = "ToAccount";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $amount REAL NOT NULL,
        $date TEXT NOT NULL,
        $fromAccount TEXT NOT NULL
        $toAccount TEXT NOT NULL,
        FOREIGN KEY ($fromAccount) REFERENCES ${TAccount.tableName}(${TAccount.id}),
        FOREIGN KEY ($toAccount) REFERENCES ${TAccount.tableName}(${TAccount.id})
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
