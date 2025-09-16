import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final budgetInputController = TextEditingController();

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
    if (budgetInputController.text.isEmpty) {
      showErrorSnackbar('Error', 'Please fill all the required fields');
      return false;
    }
    if (int.tryParse(budgetInputController.text) == null) {
      showErrorSnackbar('Error', 'Please enter valid budget amount');
      return false;
    }
    return true;
  }

  //=============
  // Add budget
  //=============
  Future<bool> addBudget() async {
    if (!filterBasicDetails()) return false;
    setLoading(true);

    // artificial delay for loader widget to show up.(inproved UX)
    await Future.delayed(const Duration(seconds: 1));

    await budgetRepo.createBudget(
      month: months.indexOf(selectedMonth),
      year: int.parse(selectedYear),
      budget: double.parse(budgetInputController.text),
    );

    debugPrint('[Budget Controller] Budget added');

    setLoading(false);
    return true;
  }

  //=============
  // Fetch Budgets
  //=============
  Future<List<BudgetModel>> fetchBudgets() async {
    final budgets = await budgetRepo.getAllBudgets();
    debugPrint('Controller: ${budgets.length} budgets fetched');
    return budgets;
  }

  void showErrorSnackbar(String s, String t) {}
}
