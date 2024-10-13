import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Pages/AddCashflow/Components/c_dropdown_account.dart';
import 'package:mywallet/Pages/AddCashflow/Components/c_dropdown_category.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/Style/style.dart';

class CCashflowSelection extends StatelessWidget {
  const CCashflowSelection({
    super.key,
    required this.width,
    required this.isTransfer,
    required this.accountValue,
    required this.accountOptions,
    required this.onAccountChanged,
    required this.categoryValue,
    required this.categoryOptions,
    required this.onCategoryChanged,
    required this.accountToValue,
    required this.accountToOptions,
    required this.onAccountToChanged,
    required this.onEditText,
  });

  final double width;
  final bool isTransfer;

  final DsAccount? accountValue;
  final List<DsAccount> accountOptions;
  final Function(DsAccount) onAccountChanged;

  final DsCategory? categoryValue;
  final List<DsCategory> categoryOptions;
  final Function(DsCategory) onCategoryChanged;

  final DsAccount? accountToValue;
  final List<DsAccount> accountToOptions;
  final Function(DsAccount) onAccountToChanged;

  final Function onEditText;

  @override
  Widget build(BuildContext context) {
    final String account = isTransfer ? "from" : "Account";
    return Container(
      color: boxBackround,
      height: 60,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: (width / 2) - (isTransfer ? 40 : 60),
                    child: CDropdownAccount(
                      hint: account,
                      hintColor: text,
                      textColor: textSelected,
                      dropdownColor: boxBackround,
                      value: accountValue,
                      options: accountOptions,
                      onChanged: (value) => onAccountChanged(value),
                    ),
                  ),
                  isTransfer
                      ? const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: icon,
                          ),
                        )
                      : const SizedBox(width: 20),
                  SizedBox(
                    width: (width / 2) - (isTransfer ? 40 : 60),
                    child: isTransfer
                        ? CDropdownAccount(
                            hint: "to",
                            hintColor: text,
                            textColor: textSelected,
                            dropdownColor: boxBackround,
                            value: accountToValue,
                            options: accountToOptions,
                            onChanged: (value) => onAccountToChanged(value),
                          )
                        : CDropdownCategory(
                            hint: "Category",
                            hintColor: text,
                            textColor: textSelected,
                            dropdownColor: boxBackround,
                            value: categoryValue,
                            options: categoryOptions,
                            onChanged: (value) => onCategoryChanged(value),
                          ),
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: !isTransfer,
            child: CIconButton(
              onPressed: () => onEditText(),
              icons: Icons.text_fields_outlined,
              color: textSelected,
              padding: 10,
            ),
          ),
        ],
      ),
    );
  }
}
