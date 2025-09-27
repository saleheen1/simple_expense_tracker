import 'dart:ui';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_expense_tracker/core/widgets/update_helper.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';
import 'package:simple_expense_tracker/features/home/presentation/widgets/home_navigation_helper.dart';
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
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey addExpenseKey = GlobalKey();
  GlobalKey addBudgetKey = GlobalKey();
  GlobalKey historyTabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadAtStart();
  }

  loadAtStart() async {
    // Get current local year & month
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    //Fetch budget of the month.
    final budgetController = Get.find<BudgetController>();
    final expenseController = Get.find<ExpenseController>();

    await budgetController.getBudgetOfGivenMonth(
      year: currentYear,
      month: currentMonth,
      isCurrentMonth: true,
    );

    // Fetch current month's expenses
    await expenseController.getExpenses(
      year: currentYear,
      month: currentMonth,
      isCurrentMonth: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUpdate();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

      if (isFirstLaunch) {
        await prefs.setBool('isFirstLaunch', false);

        createTutorial();
        Future.delayed(const Duration(milliseconds: 500), () {
          showTutorial(context: context);
        });
      }
    });
    List<Widget> pages = [
      HomeTab(
        onMenuTap: _openDrawer,
        addBudgetKey: addBudgetKey,
        scaffoldKey: scaffoldKey,
      ),
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
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: BottomMenu(historyTabKey: historyTabKey),
          ),
          floatingActionButtonLocation: CustomFABLocation(offsetY: 10),
          floatingActionButton: InkWell(
            key: addExpenseKey,
            onTap: () {
              Get.to(() => AddExpensePage());
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: theme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add_rounded, color: theme.bgColor, size: 30),
            ),
          ),
        );
      },
    );
  }

  void showTutorial({required BuildContext context}) {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    List<GlobalKey> keys = [addExpenseKey, addBudgetKey, historyTabKey];

    tutorialCoachMark = TutorialCoachMark(
      targets: HomeNavigationHelper().createTargets(keys: keys),
      colorShadow: Colors.grey,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.2,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onSkip: () {
        return true;
      },
    );
  }
}
