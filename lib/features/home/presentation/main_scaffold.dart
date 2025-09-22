import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/widgets/home_drawer.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/features/history/history_tab.dart';
import 'package:simple_expense_tracker/core/utils/custom_fab_location.dart';
import 'package:simple_expense_tracker/features/home/presentation/home_tab.dart';
import 'package:simple_expense_tracker/features/home/presentation/widgets/bottom_menu.dart';
import 'package:simple_expense_tracker/features/home/data/controller/navigation_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/presentation/add_expense_page.dart';

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

  loadAtStart() async {
    /// Print the physical location of the database file on device/emulator
    final dbPath = join(await getDatabasesPath(), 'simple_expense_tracker.db');
    debugPrint(
      '[main_scaffold.dart]📍 DB 🗂️ for this project located at(applicable for simulators\' only): $dbPath',
    );

    // Get current local year & month
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    //Fetch budget of the month.
    await Get.find<BudgetController>().getBudgetOfGivenMonth(
      year: currentYear,
      month: currentMonth,
      isCurrentMonth: true,
    );

    await Get.find<BudgetController>().selectMonthInHistory(currentMonth - 1);

    // Fetch current month's expenses
    await Get.find<ExpenseController>().getExpenses(
      year: currentYear,
      month: currentMonth,
      isCurrentMonth: true,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeTab(onMenuTap: _openDrawer),
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
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(() => AddExpensePage());
              },
              child: Icon(Icons.add_rounded, color: theme.bgColor, size: 40),
            ),
          ),
        );
      },
    );
  }
}
