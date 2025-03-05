import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_bankaccount_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_budget_category.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_category.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late DsCategory category;
  late DsCategory secondCategory;
  late DsCategory thirdCategory;

  late DsBankaccount bankaccount;
  late DsBankaccount secondBankaccount;

  setUp(() async {
    await SqlConnection.resetDB();

    category = DsCategory("name", Colors.white);
    secondCategory = DsCategory("second name", Colors.black);
    thirdCategory = DsCategory("third name", Colors.black);

    bankaccount = DsBankaccount("name", 100);
    secondBankaccount = DsBankaccount("second name", 4000);
  });

  group("Testing Dao Category", () {
    test("insert", () async {
      await DaoCategory.insert(category);

      final db = await SqlConnection.instance.database;
      List<Map> rawCategory = await db.query(TCategory.tableName);

      expect(rawCategory[0][TCategory.id], category.getId);
      expect(rawCategory[0][TCategory.name], category.getName);
      expect(rawCategory[0][TCategory.color], category.getColor.toARGB32());
    });

    test("insertBankaccountCategory", () async {
      await DaoBankaccount.insert(bankaccount);
      await DaoCategory.insertBankaccountCategory(category, bankaccount.getId);

      final db = await SqlConnection.instance.database;
      List<Map> rawCategory = await db.query(TCategory.tableName);

      expect(rawCategory[0][TCategory.id], category.getId);
      expect(rawCategory[0][TCategory.name], category.getName);
      expect(rawCategory[0][TCategory.color], category.getColor.toARGB32());

      List<Map> rawBankaccountCategory = await db.query(
        TBankaccountCategory.tableName,
      );

      expect(
        rawBankaccountCategory[0][TBankaccountCategory.bankaccountId],
        bankaccount.getId,
      );
      expect(
        rawBankaccountCategory[0][TBankaccountCategory.categoryId],
        category.getId,
      );
    });

    test("update", () async {
      await DaoCategory.insert(category);

      category.setName = "New Name";
      category.setColor = Colors.yellow;

      await DaoCategory.update(category);

      final db = await SqlConnection.instance.database;
      List<Map> rawCategory = await db.query(TCategory.tableName);

      expect(rawCategory[0][TCategory.id], category.getId);
      expect(rawCategory[0][TCategory.name], category.getName);
      expect(rawCategory[0][TCategory.color], category.getColor.toARGB32());
    });

    test("getBankaccountCategories", () async {
      await DaoBankaccount.insert(bankaccount);
      await DaoCategory.insertBankaccountCategory(category, bankaccount.getId);
      await DaoCategory.insert(secondCategory);

      await DaoBankaccount.insert(secondBankaccount);
      await DaoCategory.insertBankaccountCategory(
        thirdCategory,
        secondBankaccount.getId,
      );

      List<DsCategory> bankCat = await DaoCategory.getBankaccountCategories(
        bankaccount.getId,
      );

      expect(bankCat.length, 2);

      expect(bankCat.first.getId, category.getId);
      expect(bankCat.first.getName, category.getName);
      expect(bankCat.first.getColor, category.getColor);

      expect(bankCat.last.getId, secondCategory.getId);
      expect(bankCat.last.getName, secondCategory.getName);
      expect(bankCat.last.getColor, secondCategory.getColor);
    });
  });

  test("getBudgetCategories", () async {
    const String budgetId = "12o3p45h";
    const String secondBudgetid = "rkhgqierh";

    DaoCategory.insert(category);
    DaoCategory.insert(secondCategory);
    DaoCategory.insert(thirdCategory);

    final db = await SqlConnection.instance.database;
    await db.insert(TBudgetCategory.tableName, {
      TBudgetCategory.budgetId: budgetId,
      TBudgetCategory.categoryId: category.getId,
    });
    await db.insert(TBudgetCategory.tableName, {
      TBudgetCategory.budgetId: budgetId,
      TBudgetCategory.categoryId: secondCategory.getId,
    });
    await db.insert(TBudgetCategory.tableName, {
      TBudgetCategory.budgetId: secondBudgetid,
      TBudgetCategory.categoryId: thirdCategory.getId,
    });

    List<DsCategory> list = await DaoCategory.getBudgetCategories(budgetId);

    expect(list.length, 2);

    expect(list.first.getId, secondCategory.getId);
    expect(list.first.getName, secondCategory.getName);
    expect(list.first.getColor, secondCategory.getColor);

    expect(list.last.getId, category.getId);
    expect(list.last.getName, category.getName);
    expect(list.last.getColor, category.getColor);
  });

  test("get", () async {});

  test("delete", () async {});
}
