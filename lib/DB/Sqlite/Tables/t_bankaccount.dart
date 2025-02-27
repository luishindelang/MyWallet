class TBankaccount {
  static const String tableName = "BankAccount";
  static const String id = "Id";
  static const String name = "Name";
  static const String credit = "Credit";
  static const String prio = "Prio";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $credit REAL NOT NULL,
        $prio INTEGER NOT NULL
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
