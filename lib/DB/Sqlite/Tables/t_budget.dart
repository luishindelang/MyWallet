class TBudget {
  static const String tableName = "Budget";
  static const String id = "Id";
  static const String name = "Name";
  static const String budget = "Budget";
  static const String period = "Period";
  static const String color = "Color";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $budget REAL NOT NULL,
        $period INTEGER NOT NULL,
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
