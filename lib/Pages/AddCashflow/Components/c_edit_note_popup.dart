import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_text_button.dart';
import 'package:mywallet/Components/Controls/c_text_field_box.dart';
import 'package:mywallet/Style/style.dart';

class CEditNotePopup extends StatelessWidget {
  const CEditNotePopup({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      title: Text("Note for cashflow:", style: textL(text)),
      content: CTextFieldBox(
        controller: controller,
        onChanged: (value) {},
        readOnly: false,
        hint: "Notes",
        maxLines: 6,
      ),
      actions: [
        CTextButton(
          onPressed: () => Navigator.pop(context),
          backgroundColor: Colors.transparent,
          child: Text("ok", style: textL(text)),
        ),
      ],
    );
  }
}
