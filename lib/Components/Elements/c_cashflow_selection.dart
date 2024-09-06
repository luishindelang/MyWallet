import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_dropdown_account.dart';
import 'package:mywallet/Components/Controls/c_dropdown_category.dart';
import 'package:mywallet/DB/DataStrukture/ds_account.dart';
import 'package:mywallet/DB/DataStrukture/ds_cashflow_category.dart';
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
  });

  final double width;
  final bool isTransfer;

  final DsAccount? accountValue;
  final List<DsAccount> accountOptions;
  final Function(DsAccount) onAccountChanged;

  final DsCashflowCategory? categoryValue;
  final List<DsCashflowCategory> categoryOptions;
  final Function(DsCashflowCategory) onCategoryChanged;

  final DsAccount? accountToValue;
  final List<DsAccount> accountToOptions;
  final Function(DsAccount) onAccountToChanged;

  @override
  Widget build(BuildContext context) {
    final String account = isTransfer ? "from" : "Account";
    final String category = isTransfer ? "to" : "Category";
    return Container(
      color: boxBackround,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: (width / 2) - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(account, style: textS(text)),
                CDropdownAccount(
                  hint: "choose one",
                  hintColor: text,
                  textColor: textSelected,
                  dropdownColor: boxBackround,
                  value: accountValue,
                  options: accountOptions,
                  onChanged: (value) => onAccountChanged(value),
                ),
              ],
            ),
          ),
          SizedBox(
            width: (width / 2) - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(category, style: textS(text)),
                isTransfer
                    ? CDropdownAccount(
                        hint: "choose one",
                        hintColor: text,
                        textColor: textSelected,
                        dropdownColor: boxBackround,
                        value: accountToValue,
                        options: accountToOptions,
                        onChanged: (value) => onAccountToChanged(value),
                      )
                    : CDropdownCategory(
                        hint: "choose one",
                        hintColor: text,
                        textColor: textSelected,
                        dropdownColor: boxBackround,
                        value: categoryValue,
                        options: categoryOptions,
                        onChanged: (value) => onCategoryChanged(value),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
