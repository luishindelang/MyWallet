import 'package:flutter/material.dart';
import 'package:mywallet/Pages/navbar_main_page.dart';
import 'package:mywallet/Style/style.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: textColor,
          selectionHandleColor: textColor,
        ),
      ),
      title: "MyWallet",
      home: const NavbarMainPage(),
    ),
  );
}
