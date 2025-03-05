import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_budget.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget_category.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late DsBudget budget;
  late DsBudget secondBudget;

  late DsCategory category;
  late DsCategory secondCategory;

  setUp(() async {
    await SqlConnection.resetDB();

    category = DsCategory("name", Colors.black);
    secondCategory = DsCategory("second name", Colors.black);

    budget = DsBudget("name", 10, 1, Colors.black, uuid(), [
      category,
      secondCategory,
    ]);
    secondBudget = DsBudget("second name", 20, 2, Colors.white);
  });

  group("Testing Dao Budget", () {
    test("insert", () async {
      await DaoCategory.insert(category);
      await DaoCategory.insert(secondCategory);
      await DaoBudget.insert(budget);

      final db = await SqlConnection.instance.database;
      List<Map> rawData = await db.query(TBudget.tableName);

      expect(rawData[0][TBudget.id], budget.getId);
      expect(rawData[0][TBudget.name], budget.getName);
      expect(rawData[0][TBudget.budget], budget.getBudget);
      expect(rawData[0][TBudget.period], budget.getPeriod);
      expect(rawData[0][TBudget.color], budget.getColor.toARGB32());

      List<Map> rawDataJoin = await db.query(TBudgetCategory.tableName);

      expect(rawDataJoin.length, 2);
      expect(rawDataJoin[0][TBudgetCategory.categoryId], category.getId);
      expect(rawDataJoin[1][TBudgetCategory.categoryId], secondCategory.getId);
    });

    test("update", () async {
      await DaoBudget.insert(budget);

      budget.setName = "new Name";
      budget.setBudget = 400;
      budget.setPeriod = 2;
      budget.setColor = Colors.red;
      budget.removeCategory(secondCategory);

      await DaoBudget.update(budget);

      final db = await SqlConnection.instance.database;
      List<Map> rawData = await db.query(TBudget.tableName);

      expect(rawData[0][TBudget.id], budget.getId);
      expect(rawData[0][TBudget.name], budget.getName);
      expect(rawData[0][TBudget.budget], budget.getBudget);
      expect(rawData[0][TBudget.period], budget.getPeriod);
      expect(rawData[0][TBudget.color], budget.getColor.toARGB32());

      List<Map> rawDataJoin = await db.query(TBudgetCategory.tableName);

      expect(rawDataJoin.length, 1);
      expect(rawDataJoin[0][TBudgetCategory.categoryId], category.getId);
    });

    test("getAll", () async {
      await DaoBudget.insert(budget);
      await DaoBudget.insert(secondBudget);

      List<DsBudget> list = await DaoBudget.getAll();

      expect(list.length, 2);

      expect(list.first.getId, budget.getId);
      expect(list.first.getName, budget.getName);
      expect(list.first.getBudget, budget.getBudget);
      expect(list.first.getPeriod, budget.getPeriod);
      expect(list.first.getColor, budget.getColor);

      expect(list.last.getId, secondBudget.getId);
      expect(list.last.getName, secondBudget.getName);
      expect(list.last.getBudget, secondBudget.getBudget);
      expect(list.last.getPeriod, secondBudget.getPeriod);
      expect(list.last.getColor, secondBudget.getColor);
    });

    test("get", () async {
      await DaoBudget.insert(budget);

      DsBudget list = await DaoBudget.get(budget.getId);

      expect(list.getId, budget.getId);
      expect(list.getName, budget.getName);
      expect(list.getBudget, budget.getBudget);
      expect(list.getPeriod, budget.getPeriod);
      expect(list.getColor, budget.getColor);
    });

    test("delete", () async {});
  });
}
