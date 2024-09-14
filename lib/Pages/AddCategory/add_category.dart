import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Components/Controls/c_text_field.dart';
import 'package:mywallet/Components/Elements/c_scaffold.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
import 'package:mywallet/DB/Service/s_rout.dart';
import 'package:mywallet/DB/Service/s_uuid.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_cashflow_category.dart';
import 'package:mywallet/Pages/Home/home.dart';
import 'package:mywallet/Style/style.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _nameController = TextEditingController();
  late Color _selectedColor;

  List<Color> _colors() {
    List<Color> allColors = [...Colors.accents, ...Colors.primaries];
    allColors.sort((a, b) {
      HSLColor hslA = HSLColor.fromColor(a);
      HSLColor hslB = HSLColor.fromColor(b);

      int hueComparison = hslA.hue.compareTo(hslB.hue);
      if (hueComparison != 0) {
        return hueComparison;
      } else {
        int saturationComparison = hslA.saturation.compareTo(hslB.saturation);
        if (saturationComparison != 0) {
          return saturationComparison;
        } else {
          return hslA.lightness.compareTo(hslB.lightness);
        }
      }
    });
    return allColors;
  }

  void route() {
    routePushAndRemove(context, const Home());
  }

  @override
  void initState() {
    super.initState();
    _selectedColor = _colors().first;
  }

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      title: "Add new category",
      actions: [
        CIconButton(
          icons: Icons.check_rounded,
          size: 35,
          color: textSelected,
          onPressed: () async {
            if (_nameController.text.isNotEmpty) {
              final category = DsCashflowCategory(
                uuid(),
                _nameController.text,
                _selectedColor,
              );
              await DaoCashflowCategory.insert(category);
              route();
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: addAccountBodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name", style: textL(text)),
              CTextField(
                controller: _nameController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              Text("Farbe", style: textL(text)),
              SizedBox(
                width: 140,
                child: DropdownButton(
                    value: _selectedColor,
                    isExpanded: true,
                    underline: Container(color: Colors.transparent),
                    iconEnabledColor: _selectedColor,
                    items: _colors().map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Container(
                          height: 30,
                          width: 100,
                          color: color,
                          margin: selectColorMaring,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedColor = value!;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
