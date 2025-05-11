import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_drop_down.dart';
import 'package:mywallet/Components/Overview/c_switch_text_button_selected.dart';
import 'package:mywallet/Components/Elements/c_box_border.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/Style/style.dart';
import 'package:fl_chart/fl_chart.dart';

class MonthlyOverview extends StatefulWidget {
  const MonthlyOverview({super.key, required this.bankaccount});

  final DsBankaccount? bankaccount;

  @override
  State<MonthlyOverview> createState() => _MonthlyOverviewState();
}

class _MonthlyOverviewState extends State<MonthlyOverview> {
  double totalExpenses = 483;
  double totalIncomes = 500;
  final Map<DsCategory, double> _data = {
    DsCategory("Einkäufe", Colors.yellow): 34,
    DsCategory("Haushalt", Colors.pink): 47,
    DsCategory("Nebenkosten", Colors.green): 52,
    DsCategory("Essen gehen", Colors.orange): 201,
    DsCategory("Essen gehen", Colors.orange): 20,
    DsCategory("Essen gehen", Colors.orange): 50,
    DsCategory("Essen gehen", Colors.orange): 60,
    DsCategory("Essen gehen", Colors.orange): 30,
    DsCategory("Essen gehen", Colors.orange): 40,
    DsCategory("Essen gehen", Colors.orange): 70,
    DsCategory("Essen gehen", Colors.orange): 80,
  };

  @override
  Widget build(BuildContext context) {
    return CBoxBorder(
      child: Column(
        children: [
          Row(
            children: [
              CDropDown(
                options: [
                  "March",
                  "April",
                  "May",
                  "June",
                  "Juli",
                  "August",
                  "September",
                ],
                changedItem: (item) => item,
                selectedItemName: "March",
              ),
              SizedBox(width: 20),
              Text("+ 17 €", style: positiveMonthlySaldoText),
            ],
          ),
          SizedBox(height: 8),
          CSwitchTextButtonSelected(
            expenseText: "483€",
            incomeText: "500€",
            onChange: (isSelected) {
              print(isSelected);
            },
          ),
          SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final chartWidth = constraints.maxWidth * 2 / 3 - 60;
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final radius = constraints.maxWidth / 2 - 10;
                          return PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 0,
                              sections:
                                  _data.entries.map((e) {
                                    final percentage = e.value / totalExpenses;
                                    return PieChartSectionData(
                                      value: e.value,
                                      color: e.key.getColor,
                                      title:
                                          percentage > 0.08
                                              ? '${e.value.round()}€'
                                              : "",
                                      titleStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      radius: radius,
                                      titlePositionPercentageOffset: 0.75,
                                    );
                                  }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: chartWidth,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              _data.entries.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: e.key.getColor,
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(child: Text(e.key.getName)),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
