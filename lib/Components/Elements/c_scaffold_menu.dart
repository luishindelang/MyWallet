import 'package:flutter/material.dart';
import 'package:mywallet/Components/Controls/c_icon_button.dart';
import 'package:mywallet/Components/Controls/c_list_tile.dart';
import 'package:mywallet/Pages/Home/home.dart';
import 'package:mywallet/Style/style.dart';

class CScaffoldMenu extends StatelessWidget {
  const CScaffoldMenu({
    super.key,
    required this.title,
    required this.tabController,
    required this.tabList,
    required this.pageList,
    required this.onActionPressed,
  });

  final String title;
  final TabController tabController;
  final List<Tab> tabList;
  final List<Widget> pageList;
  final Function onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: forground,
        title: Text(title, style: textLB(textSelected)),
        leading: Builder(
          builder: (context) => CIconButton(
            icons: Icons.menu,
            size: 35,
            color: textSelected,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: TabBar(
          dividerColor: forground,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: textSelected,
          labelStyle: textL(textSelected),
          unselectedLabelStyle: textL(textSelected),
          overlayColor: WidgetStateProperty.all(buttonSplash),
          controller: tabController,
          tabs: tabList,
        ),
      ),
      drawer: Drawer(
        backgroundColor: background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: forground,
              ),
              child: Text('Menu', style: textL(textSelected)),
            ),
            const CListTile(
              icon: Icons.home_rounded,
              title: 'Home',
              widget: Home(),
            ),
          ],
        ),
      ),
      floatingActionButton: CIconButton(
        size: 50,
        color: textSelected,
        backgroundColor: forground,
        onPressed: () => onActionPressed(),
        icons: Icons.add_rounded,
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: pageList,
      ),
    );
  }
}
