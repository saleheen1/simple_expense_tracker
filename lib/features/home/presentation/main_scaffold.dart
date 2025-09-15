import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/custom_fab_location.dart';
import 'package:simple_expense_tracker/core/widgets/home_drawer.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/presentation/add_expanse_page.dart';
import 'package:simple_expense_tracker/features/history/history_tab.dart';
import 'package:simple_expense_tracker/features/home/data/controller/navigation_controller.dart';
import 'package:simple_expense_tracker/features/home/presentation/home_tab.dart';
import 'package:simple_expense_tracker/features/home/presentation/widgets/bottom_menu.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  void initState() {
    super.initState();
    loadAtStart();
  }

  loadAtStart() async {}

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeTab(onMenuTap: _openDrawer, totalExpanse: '731', budget: '1000'),
      HistoryTab(totalExpanse: '731', budget: '1000'),
    ];
    final theme = CustomTheme.of(context);

    return GetBuilder<NavigationController>(
      builder: (nc) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: CustomTheme.of(context).bgColor,
          body: pages[nc.selectedIndex],
          drawer: HomeDrawer(),
          bottomNavigationBar: BottomMenu(),
          floatingActionButtonLocation: CustomFABLocation(offsetY: 10),
          floatingActionButton: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: theme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.primary.withValues(alpha: 0.4),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(AddExpansePage());
              },
              child: Icon(Icons.add_rounded, color: theme.bgColor, size: 40),
            ),
          ),
        );
      },
    );
  }
}
