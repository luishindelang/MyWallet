import 'package:flutter/material.dart';
import 'package:mywallet/Components/Budget/c_category_list.dart';
import 'package:mywallet/Components/Budget/c_drop_down_category_select.dart';
import 'package:mywallet/Components/Budget/c_drop_down_color_select.dart';
import 'package:mywallet/Components/Controls/c_drop_down.dart';
import 'package:mywallet/Components/Controls/c_number_input.dart';
import 'package:mywallet/Components/Controls/c_popup_action_buttons.dart';
import 'package:mywallet/Components/Controls/c_text_button_selected.dart';
import 'package:mywallet/Components/Controls/c_text_input.dart';
import 'package:mywallet/Components/Elements/c_popup.dart';
import 'package:mywallet/DB/DataStrukture/ds_budget.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';

class NewBudgetPopup extends StatefulWidget {
  const NewBudgetPopup({super.key, this.budget});

  final DsBudget? budget;

  @override
  State<NewBudgetPopup> createState() => _NewBudgetPopupState();
}

class _NewBudgetPopupState extends State<NewBudgetPopup> {
  final List<Color> _colors = Colors.primaries;

  final TextEditingController _nameController = TextEditingController();
  int _period = 0;
  final TextEditingController _budgetController = TextEditingController();
  Color? _selectedColor;
  List<DsCategory> _selectedCategories = [];

  List<String> wahrung = ["€", "§", "\$"];

  final List<DsCategory> _categories = [
    DsCategory("Einkäufe", Colors.red),
    DsCategory("Essen gehen", Colors.green),
    DsCategory("Freizeit", Colors.yellow),
  ];

  void selectPeriod(int selectedPeriod) {
    setState(() {
      if (_period == selectedPeriod) {
        _period = 0;
      } else {
        _period = selectedPeriod;
      }
    });
  }

  Widget categoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            _selectedCategories.map((category) {
              return CCategoryList(
                category: category,
                onClose: () {
                  setState(() {
                    _selectedCategories.remove(category);
                  });
                },
              );
            }).toList(),
      ),
    );
  }

  @override
  void initState() {
    if (widget.budget != null) {
      _nameController.text = widget.budget!.getName;
      _period = widget.budget!.getPeriod;
      _budgetController.text = widget.budget!.getBudget.toString();
      _selectedColor = widget.budget!.getColor;
      _selectedCategories = widget.budget!.getCategories;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CPopup(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CTextInput(textEditingController: _nameController),
            SizedBox(height: 10),
            Row(
              children: [
                CTextButtonSelected(
                  onPressed: () => selectPeriod(1),
                  text: "Weekly",
                  isSelected: _period == 1,
                ),
                SizedBox(width: 20),
                CTextButtonSelected(
                  onPressed: () => selectPeriod(2),
                  text: "Monthly",
                  isSelected: _period == 2,
                ),
                SizedBox(width: 20),
                CTextButtonSelected(
                  onPressed: () => selectPeriod(3),
                  text: "Yearly",
                  isSelected: _period == 3,
                ),
              ],
            ),
            SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth * 0.5;
                return Row(
                  children: [
                    SizedBox(
                      width: width,
                      child: CNumberInput(
                        textEditingController: _budgetController,
                      ),
                    ),
                    SizedBox(width: 10),
                    CDropDown(
                      changedItem: (String selectedItem) {
                        return selectedItem;
                      },
                      options: wahrung,
                      selectedItemName: wahrung.first,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            categoryList(),
            SizedBox(height: 10),
            CDropDownCategorySelect(
              changedItem: (item) {
                setState(() {
                  if (!_selectedCategories.contains(item)) {
                    _selectedCategories.add(item);
                  }
                });
              },
              options: _categories,
            ),
            SizedBox(height: 20),
            CDropDownColorSelect(
              changedItem: (color) => _selectedColor = color,
              options: _colors,
              selectedColor: _selectedColor,
            ),
            SizedBox(height: 20),
            CPopupActionButtons(
              onDone: () {
                print(_nameController.text);
                print(_period);
                print(_budgetController.text);
                print(_selectedCategories);
                print(_selectedColor);
              },
            ),
          ],
        ),
      ),
    );
  }
}
