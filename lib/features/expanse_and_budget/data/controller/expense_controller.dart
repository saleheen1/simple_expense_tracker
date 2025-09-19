import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_expense_tracker/core/utils/snackbars.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/expense_model.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/expense_repo.dart';

class ExpenseController extends GetxController {
  final expenseRepo = Get.find<ExpenseRepo>();

  bool isLoading = false;
  setLoading(bool value) {
    isLoading = value;
    update();
  }

  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  bool filterBasicDetails() {
    if (nameController.text.isEmpty ||
        amountController.text.isEmpty ||
        dateController.text.isEmpty) {
      showErrorSnackbar('Error', 'Please fill all the required fields');
      return false;
    }
    if (double.tryParse(amountController.text) == null) {
      showErrorSnackbar('Error', 'Please enter valid expense amount');
      return false;
    }
    return true;
  }

  //===============
  // Add expense
  //===============
  Future<bool> addExpense() async {
    if (!filterBasicDetails()) return false;
    setLoading(true);

    // artificial delay for loader widget to show up.(inproved UX)
    await Future.delayed(const Duration(seconds: 1));

    // Parse the user-entered date
    final parsedDate = DateFormat('MMM d, yyyy').parse(dateController.text);
    final isoDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    final expense = ExpenseModel(
      name: nameController.text,
      date: isoDate,
      cost: double.parse(amountController.text),
    );

    final success = await expenseRepo.upsertExpense(expense);

    if (success) {
      final now = DateTime.now();
      final currentYear = now.year;
      final currentMonth = now.month;
      getExpensesByGivenMonth(year: currentYear, month: currentMonth, isCurrentMonth: true);
      debugPrint(
        '[expense_controller.dart] Expense added: ${expense.toJson()}',
      );
    }

    setLoading(false);
    Get.back();
    return success;
  }

  //================
  // Fetch expenses
  //================
  List<ExpenseModel> expensesOfGivenMonth = [];
  List<ExpenseModel> expensesOfCurrentMonth = [];
  double totalExpenseOfGivenMonth = 0;
  double totalExpenseOfCurrentMonth = 0;

  Future<void> getExpensesByGivenMonth({
    required int year,
    required int month,
    required bool isCurrentMonth,
  }) async {
    final fetchedExpenses = await expenseRepo.fetchExpensesByMonth(
      year: year,
      month: month,
    );

    if (!isCurrentMonth) expensesOfGivenMonth = fetchedExpenses;
    if (isCurrentMonth) expensesOfCurrentMonth = fetchedExpenses;

    double totalExpenses = 0.0;
    for (var e in fetchedExpenses) {
      totalExpenses += e.cost;
    }

    if (!isCurrentMonth) {
      totalExpenseOfGivenMonth = double.parse(
        totalExpenses.toStringAsFixed(2),
      );
    }
    if (isCurrentMonth) {
      totalExpenseOfCurrentMonth = double.parse(
        totalExpenses.toStringAsFixed(2),
      );
    }


    debugPrint(
      '[expense_controller]: total expense of the month given month: $totalExpenseOfGivenMonth, '
      'and expenses details: ${fetchedExpenses.map((e) => e.toJson()).toList()}',
    );

    update();
  }
}
