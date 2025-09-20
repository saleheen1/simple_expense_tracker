import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/helper/day_info.dart';
import 'package:simple_expense_tracker/core/utils/snackbars.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/budget_model.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/budget_repo.dart';

class BudgetController extends GetxController {
  final expenseController = Get.find<ExpenseController>();
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

  final years = ['2025', '2026'];
  final amountController = TextEditingController();

  String selectedMonth = 'January';
  String selectedYear = '2025';
  int selectedMonthIndex = 0; // Add selected month index for history tab
  int selectedDayIndex = 0;

  void updateMonth(String month) {
    selectedMonth = month;
    update();
  }

  void updateYear(String year) {
    selectedYear = year;
    update();
  }

  List<DayInfo> getDaysOfSelectedMonth({required int monthIndex}) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final year = DateTime.now().year;
    final daysInMonth = DateTime(year, monthIndex + 2, 0).day;

    return List.generate(daysInMonth, (i) {
      final date = i + 1;
      final weekday = names[DateTime(year, monthIndex + 1, date).weekday - 1];
      return DayInfo(date: date, weekday: weekday);
    });
  }

  // Add method to handle month selection in history tab
  Future<void> selectMonthInHistory(int monthIndex) async {
    selectedMonthIndex = monthIndex;

    final now = DateTime.now();
    final currentYear = now.year;

    getBudgetOfGivenMonth(
      year: currentYear,
      month: monthIndex + 1,
      isCurrentMonth: false,
    );
    expenseController.getExpenses(year: currentYear, month: monthIndex + 1);
    update();

    debugPrint(
      '[budget_controller.dart] Selected month: ${months[monthIndex]}',
    );
  }

  // Get currently selected month name for history tab
  String get selectedHistoryMonthName => months[selectedMonthIndex];

  Future<void> selectDayInHistory(int dayIndex) async {
    selectedDayIndex = dayIndex;

    final now = DateTime.now();
    final currentYear = now.year;

    if (dayIndex == 0) {
      expenseController.getExpenses(
        year: currentYear,
        month: selectedMonthIndex + 1,
      );
      debugPrint('[budget_controller.dart] Selected: All days');
    }

    if (dayIndex != 0) {
      final days = getDaysOfSelectedMonth(monthIndex: selectedMonthIndex);
      if (dayIndex - 1 < days.length) {
        expenseController.getExpenses(
          year: currentYear,
          month: selectedMonthIndex + 1,
          day: selectedDayIndex,
        );
        debugPrint(
          '[budget_controller.dart] Selected day: ${days[dayIndex - 1].date}',
        );
      }
    }
    
    update();
  }

  // Helper method to check if a specific day is selected
  bool isDaySelected(int dayIndex) {
    return selectedDayIndex == dayIndex;
  }

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
        isCurrentMonth: true,
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
    required bool isCurrentMonth,
  }) async {
    final double fetchedBudget = await budgetRepo.fetchMonthBudget(
      year: year,
      month: month - 1,
    );

    if (!isCurrentMonth) budgetOfGivenMonth = fetchedBudget;
    if (isCurrentMonth) budgetOfCurrentMonth = fetchedBudget;

    debugPrint(
      '[budget_controller.dart] Budget of given date $month/$year: $budgetOfGivenMonth',
    );

    update();
  }
}
