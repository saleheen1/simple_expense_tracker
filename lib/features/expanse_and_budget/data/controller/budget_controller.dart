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
  final years = ['2025', '2026'];
  final amountController = TextEditingController();

  String selectedMonth = 'January';
  String selectedYear = '2025';

  void updateMonth(String month) {
    selectedMonth = month;
    update();
  }

  void updateYear(String year) {
    selectedYear = year;
    update();
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
      getBudgetByMonth(year: currentYear, month: currentMonth);
      debugPrint('[budget_controller.dart] Budget added: ${budget.toJson()}');
    }

    setLoading(false);
    Get.back();
    return success;
  }

  //================
  // Get Budget of a given month, and year
  //================
  double budgetOfGivenMonth = 0;

  Future<void> getBudgetByMonth({required int year, required int month}) async {
    final double fetchedBudget = await budgetRepo.fetchMonthBudget(
      year: year,
      month: month - 1,
    );

    budgetOfGivenMonth = fetchedBudget;

    debugPrint(
      '[budget_controller.dart] Budget of $month/$year: $budgetOfGivenMonth',
    );

    update();
  }
}
