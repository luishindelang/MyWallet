import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow.dart';
import 'package:mywallet/DB/DataStrukture/ds_transfer.dart';

class DsAccount {
  String _id;
  String _name;
  double _credit;
  List<DsBudget> _budgets;
  List<DsCashflow> _cashflows;
  List<DsTransfer> _transfers;

  DsAccount(
    this._id,
    this._name,
    this._credit, [
    this._budgets = const [],
    this._cashflows = const [],
    this._transfers = const [],
  ]);

  String get getId => _id;
  String get getName => _name;
  double get getCredit => _credit;
  List<DsBudget> get getBudgets => _budgets;
  List<DsCashflow> get getCashflows => _cashflows;
  List<DsTransfer> get getTransfers => _transfers;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setCredit(double credit) => _credit = credit;
  set setBudgets(List<DsBudget> budgets) => _budgets = budgets;
  set setCashflows(List<DsCashflow> cashflows) => _cashflows = cashflows;
  set setTransfers(List<DsTransfer> transfers) => _transfers = transfers;

  void addBudget(DsBudget budget) => _budgets.add(budget);
  void removeBudget(DsBudget budget) => _budgets.remove(budget);

  void addCashflow(DsCashflow cashflow) => _cashflows.add(cashflow);
  void removeCashflow(DsCashflow cashflow) => _cashflows.remove(cashflow);

  void addTransfer(DsTransfer transfer) => _transfers.add(transfer);
  void removeTransfer(DsTransfer transfer) => _transfers.remove(transfer);
}
