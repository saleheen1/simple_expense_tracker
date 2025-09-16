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
      debugPrint('[budget_controller.dart] Budget added: ${budget.toJson()}');
    }

    setLoading(false);
    return success;
  }

  //=============
  // Fetch Budgets
  //=============
  Future<List<BudgetModel>> fetchBudgets() async {
    final budgets = await budgetRepo.getAllBudgets();
    debugPrint('Controller: ${budgets.length} budgets fetched');
    return budgets;
  }
}
