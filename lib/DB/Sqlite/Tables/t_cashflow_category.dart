class TCashflowCategory {
  static const String tableName = "CashflowCategory";
  static const String id = "Id";
  static const String name = "Name";
  static const String color = "Color";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $color INTEGER NOT NULL
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
