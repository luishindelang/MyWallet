import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow.dart';
import 'package:mywallet/DB/Sqlite/Tables/t_cashflow.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late DsCashflow cashflow;
  late DsCashflow secondCashflow;
  late DsCashflow thirdCashflow;
  late DsCashflow fourthCashflow;

  late DsCategory category;
  late DsCategory secondCategory;

  late DsBankaccount bankaccount;

  late DsBudget budget;

  DateTime time = DateTime.utc(2024, 3, 4, 20, 10);
  DateTime secondTime = DateTime.utc(2023, 1, 5, 30, 15);
  DateTime thirdTime = DateTime.utc(2022, 2, 6, 12, 40);
  DateTime fourthTime = DateTime.utc(2021, 4, 12, 11, 12);

  setUp(() async {
    await SqlConnection.resetDB();

    cashflow = DsCashflow(1, time, 3456);
    secondCashflow = DsCashflow(2, secondTime, 234);
    thirdCashflow = DsCashflow(3, thirdTime, 2362);
    fourthCashflow = DsCashflow(4, fourthTime, 2652);

    category = DsCategory("name", Colors.black);
    secondCategory = DsCategory("second name", Colors.black);

    bankaccount = DsBankaccount("name", 100);

    budget = DsBudget("name", 10, 1, Colors.black, uuid(), [
      category,
      secondCategory,
    ]);
  });

  group("Testing Dao Cashflow", () {
    test("insert", () async {
      await DaoCashflow.insert(cashflow, category.getId, bankaccount.getId);

      final db = await SqlConnection.instance.database;
      List<Map> rawCashflow = await db.query(TCashflow.tableName);

      expect(rawCashflow[0][TCashflow.id], cashflow.getId);
      expect(
        rawCashflow[0][TCashflow.timeStamp],
        cashflow.getDate.millisecondsSinceEpoch,
      );
      expect(rawCashflow[0][TCashflow.amount], cashflow.getAmount);
    });

    test("update", () async {
      await DaoCashflow.insert(cashflow, category.getId, bankaccount.getId);

      cashflow.setType = 2;
      cashflow.setDate = secondTime;
      cashflow.setAmount = 2000;

      await DaoCashflow.update(cashflow, category.getId, bankaccount.getId);

      final db = await SqlConnection.instance.database;
      List<Map> rawCashflow = await db.query(TCashflow.tableName);

      expect(rawCashflow[0][TCashflow.id], cashflow.getId);
      expect(
        rawCashflow[0][TCashflow.timeStamp],
        cashflow.getDate.millisecondsSinceEpoch,
      );
      expect(rawCashflow[0][TCashflow.amount], cashflow.getAmount);
    });

    test("getAllByDate", () async {
      await DaoCashflow.insert(cashflow, category.getId, bankaccount.getId);
      await DaoCashflow.insert(
        secondCashflow,
        category.getId,
        bankaccount.getId,
      );
      await DaoCashflow.insert(
        thirdCashflow,
        secondCategory.getId,
        bankaccount.getId,
      );
      await DaoCashflow.insert(
        fourthCashflow,
        secondCategory.getId,
        bankaccount.getId,
      );

      List<DsCashflow> list = await DaoCashflow.getAllByDate(
        bankaccount.getId,
        DateTime.utc(2022),
        DateTime.utc(2024),
      );

      expect(list.length, 2);

      expect(list[0].getId, secondCashflow.getId);
      expect(list[0].getDate.toString(), secondCashflow.getDate.toString());
      expect(list[0].getAmount, secondCashflow.getAmount);

      expect(list[1].getId, thirdCashflow.getId);
      expect(list[1].getDate.toString(), thirdCashflow.getDate.toString());
      expect(list[1].getAmount, thirdCashflow.getAmount);
    });

    test("getAllByTypeDate", () async {});

    test("getAllByTypeDateCategory", () async {});

    test("getSumByTypeDate", () async {
      await DaoCashflow.insert(cashflow, category.getId, bankaccount.getId);
      await DaoCashflow.insert(
        secondCashflow,
        category.getId,
        bankaccount.getId,
      );
      await DaoCashflow.insert(
        thirdCashflow,
        category.getId,
        bankaccount.getId,
      );
      await DaoCashflow.insert(
        fourthCashflow,
        category.getId,
        bankaccount.getId,
      );

      double amount = await DaoCashflow.getSumByTypeDate(
        bankaccount.getId,
        2,
        DateTime.utc(2022),
        DateTime.utc(2024),
      );

      expect(amount, 200);
    });

    test("getSumByTypeDateCategory", () async {});

    test("getSumByDateForBudget", () async {
      await DaoCashflow.insert(cashflow, category.getId, bankaccount.getId);
      await DaoCashflow.insert(
        secondCashflow,
        category.getId,
        bankaccount.getId,
      );
      await DaoCashflow.insert(
        thirdCashflow,
        category.getId,
        bankaccount.getId,
      );
      await DaoCashflow.insert(
        fourthCashflow,
        category.getId,
        bankaccount.getId,
      );

      double amount = await DaoCashflow.getSumByDateForBudget(
        bankaccount.getId,
        DateTime.utc(2020),
        DateTime.utc(2026),
        budget,
      );

      expect(amount, 2932);
    });

    test("delete", () async {});
  });
}
