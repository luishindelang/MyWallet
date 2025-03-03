class TSettings {
  static const String tableName = "Settings";
  static const String id = "Id";
  static const String acitveBankaccount = "ActiveBankaccount";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $acitveBankaccount TEXT
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
