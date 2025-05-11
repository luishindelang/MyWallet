import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/Service/s_cash_formatter.dart';
import 'package:mywallet/Pages/Budget/Sections/new_budget_popup.dart';
import 'package:mywallet/Style/style.dart';

class CProgressBar extends StatelessWidget {
  const CProgressBar({super.key, required this.budget, required this.expenses});

  final DsBudget budget;
  final double expenses;

  @override
  Widget build(BuildContext context) {
    final double remainBudget = budget.getBudget - expenses;
    final double percentage = expenses / budget.getBudget;
    bool overOne = percentage > 1;
    double notOverOneP = overOne ? 1 : percentage;
    TextStyle expeseStyle =
        overOne || percentage > 0.17 ? budgetExpenses : budgetExpensesNegative;
    TextStyle availableStyle =
        overOne || percentage > 0.83
            ? budgetAvailable
            : budgetAvailableNegative;
    Color budgetBackground = overOne ? buttonColor : budget.getColor;
    bool showProgressBar = true;

    return InkWell(
      borderRadius: BorderRadius.circular(boxBorderRadius),
      onLongPress:
          () => showDialog(
            context: context,
            builder: (context) => NewBudgetPopup(budget: budget),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(budget.getName, style: budgetName),
                  Text(
                    cashFormatter(budget.getBudget, "€"),
                    style: budgetAmount,
                  ),
                ],
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = (constraints.maxWidth) * notOverOneP;
                if (containerWidth <= 0) {
                  showProgressBar = false;
                } else if (containerWidth <= 20) {
                  containerWidth = 20;
                }
                return Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: progressBarBorderColor,
                          width: boxBorderWith,
                        ),
                        borderRadius: BorderRadius.circular(
                          progressBarBorderRadius,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showProgressBar,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 17,
                        ),
                        width: containerWidth,
                        decoration: BoxDecoration(
                          color: budgetBackground,
                          border: Border.all(
                            color: budgetBackground,
                            width: boxBorderWith,
                          ),
                          borderRadius: BorderRadius.circular(
                            progressBarBorderRadius,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cashFormatter(expenses, "€"),
                            style: expeseStyle,
                          ),
                          Text(
                            cashFormatter(remainBudget, "€"),
                            style: availableStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
