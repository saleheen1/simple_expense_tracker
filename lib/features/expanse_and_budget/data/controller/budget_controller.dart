import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/utils/snackbars.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/budget_model.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/budget_repo.dart';

class BudgetController extends GetxController {
  final budgetRepo = Get.find<BudgetRepo>();

  bool isLoading = false;
  setLoading(bool value) {
    isLoading = value;
    update();
  }

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<String> getWeekdaysOfSelectedMonth({required int monthIndex}) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final year = DateTime.now().year;
    final daysInMonth = DateTime(year, monthIndex + 2, 0).day;

    final weekdays = List.generate(daysInMonth, (i) {
      final weekday = names[DateTime(year, monthIndex + 1, i + 1).weekday - 1];
      return weekday;
    });

    return weekdays;
  }

  final years = ['2025', '2026'];
  final amountController = TextEditingController();

  String selectedMonth = 'January';
  String selectedYear = '2025';
  int selectedMonthIndex = 0; // Add selected month index for history tab

  void updateMonth(String month) {
    selectedMonth = month;
    update();
  }

  void updateYear(String year) {
    selectedYear = year;
    update();
  }

  // Add method to handle month selection in history tab
  void selectMonthInHistory(int monthIndex) {
    selectedMonthIndex = monthIndex;

    // Get current local year & month
    final now = DateTime.now();
    final currentYear = now.year;

    getBudgetOfGivenMonth(
      year: currentYear,
      month: monthIndex + 1,
      currentMonth: false,
    );
    update();

    // TODO: Fetch data for the selected month
    // Add logic here to fetch budget data for the selected month
    debugPrint(
      '[budget_controller.dart] Selected month: ${months[monthIndex]}',
    );
  }

  // Get currently selected month name for history tab
  String get selectedHistoryMonthName => months[selectedMonthIndex];

  bool filterBasicDetails() {
    if (amountController.text.isEmpty) {
      showErrorSnackbar('Error', 'Please fill all the required fields');
      return false;
    }
    if (double.tryParse(amountController.text) == null) {
      showErrorSnackbar('Error', 'Please enter valid budget amount');
      return false;
    }
    return true;
  }

  //=============
  // Add Budget
  //=============
  Future<bool> addBudget() async {
    if (!filterBasicDetails()) return false;
    setLoading(true);

    // artificial delay for loader widget to show up.(inproved UX)
    await Future.delayed(const Duration(seconds: 1));

    final budget = BudgetModel(
      year: int.parse(selectedYear),
      month: months.indexOf(selectedMonth),
      budget: double.parse(amountController.text),
    );

    final success = await budgetRepo.upsertBudget(budget);

    if (success) {
      // Get current local year & month
      final now = DateTime.now();
      final currentYear = now.year;
      final currentMonth = now.month;
      getBudgetOfGivenMonth(
        year: currentYear,
        month: currentMonth,
        currentMonth: true,
      );
      debugPrint('[budget_controller.dart] Budget added: ${budget.toJson()}');
    }

    setLoading(false);
    Get.back();
    return success;
  }

  //================
  // Get Budget of current month
  //================
  double budgetOfCurrentMonth = 0;
  double budgetOfGivenMonth = 0;

  Future<void> getBudgetOfGivenMonth({
    required int year,
    required int month,
    required bool currentMonth,
  }) async {
    final double fetchedBudget = await budgetRepo.fetchMonthBudget(
      year: year,
      month: month - 1,
    );

    if (currentMonth) budgetOfCurrentMonth = fetchedBudget;
    if (!currentMonth) budgetOfGivenMonth = fetchedBudget;

    debugPrint(
      '[budget_controller.dart] Budget of given date $month/$year: $budgetOfGivenMonth',
    );

    update();
  }
}
