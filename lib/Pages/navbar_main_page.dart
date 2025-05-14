import 'package:flutter/material.dart';
import 'package:mywallet/Pages/Budget/budget.dart';
import 'package:mywallet/Pages/Calculator/calculator.dart';
import 'package:mywallet/Pages/Overview/overview.dart';
import 'package:mywallet/Pages/Search/search.dart';
import 'package:mywallet/Pages/Statistics/statistics.dart';
import 'package:mywallet/Style/style.dart';

class NavbarMainPage extends StatefulWidget {
  const NavbarMainPage({super.key});

  @override
  State<NavbarMainPage> createState() => _NavbarMainPageState();
}

class _NavbarMainPageState extends State<NavbarMainPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [Overview(), Budget(), Calculator(), Statistics(), Search()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: background,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Overview",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: "Budgets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: "Calculator",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedIconColor,
        unselectedItemColor: unselectedIconColor,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 34,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
