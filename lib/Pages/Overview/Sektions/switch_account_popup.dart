import 'package:flutter/material.dart';
import 'package:mywallet/Components/Elements/c_popup.dart';

class SwitchAccountPopup extends StatelessWidget {
  const SwitchAccountPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return CPopup(
      child: Column(
        children: [
          Text("Select Account"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("data"),
                  SizedBox(height: 100),
                  Text("data"),
                  SizedBox(height: 100),
                  Text("data"),
                  SizedBox(height: 100),
                  Text("data"),
                  SizedBox(height: 100),
                  Text("data"),
                  SizedBox(height: 100),
                  Text("data"),
                  SizedBox(height: 100),
                  Text("data"),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
