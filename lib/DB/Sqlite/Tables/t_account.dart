class TAccount {
  static const String tableName = "Account";
  static const String id = "Id";
  static const String name = "Name";
  static const String credit = "Credit";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $credit REAL NOT NULL,
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
