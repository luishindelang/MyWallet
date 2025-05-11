import 'package:flutter/material.dart';
import 'package:mywallet/Components/Budget/c_progress_bar.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Components/Controls/c_text_button_selected.dart';
import 'package:mywallet/Components/Elements/c_line_title.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/Pages/Budget/Sections/new_budget_popup.dart';
import 'package:mywallet/Style/style.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text("Budgets", style: title),
                ),
                CTextButton(
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (context) => NewBudgetPopup(),
                      ),
                  backgroundColor: unselectedButtonColor,
                  child: Row(
                    children: [
                      Icon(Icons.add_rounded, color: textColor, size: 15),
                      Text("New budget", style: addBudgetButton),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, top: 15, left: 20),
            child: Row(
              children: [
                CTextButtonSelected(
                  onPressed: () {},
                  text: "Weekly",
                  isSelected: false,
                ),
                SizedBox(width: 20),
                CTextButtonSelected(
                  onPressed: () {},
                  text: "Monthly",
                  isSelected: false,
                ),
                SizedBox(width: 20),
                CTextButtonSelected(
                  onPressed: () {},
                  text: "Yearly",
                  isSelected: false,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CLineTitle(
                    title: "Weekly",
                    children: [
                      CProgressBar(
                        budget: DsBudget("Test Name", 300, 1, Colors.orange),
                        expenses: 360,
                      ),
                      CProgressBar(
                        budget: DsBudget("Test Name", 100, 1, Colors.yellow),
                        expenses: 1,
                      ),
                      CProgressBar(
                        budget: DsBudget("Test Name", 100, 1, Colors.green),
                        expenses: 100,
                      ),
                    ],
                  ),
                  CLineTitle(
                    title: "Monthly",
                    children: [
                      CProgressBar(
                        budget: DsBudget("Test Name", 100, 1, Colors.pink),
                        expenses: 20,
                      ),
                      CProgressBar(
                        budget: DsBudget("Test Name", 100, 1, Colors.purple),
                        expenses: 0,
                      ),
                      CProgressBar(
                        budget: DsBudget("Test Name", 1000, 1, Colors.red),
                        expenses: 28,
                      ),
                    ],
                  ),
                  CLineTitle(
                    title: "Yearly",
                    children: [
                      CProgressBar(
                        budget: DsBudget("Test Name", 100, 1, Colors.red),
                        expenses: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
