import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
    if (nameController.text.isEmpty || amountController.text.isEmpty || dateController.text.isEmpty) {
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

    final expense = ExpenseModel(
      name: nameController.text,
      date: dateController.text,
      cost: double.parse(amountController.text),
    );

    final success = await expenseRepo.upsertExpense(expense);

    if (success) {
      debugPrint('[expense_controller.dart] Expense added: ${expense.toJson()}');
    }

    setLoading(false);
    return success;
  }

  //==============
  // Fetch expenses
  //==============
  Future<List<ExpenseModel>> fetchExpenses() async {
    final expenses = await expenseRepo.getAllExpenses();
    debugPrint('Controller: ${expenses.length} expenses fetched');
    return expenses;
  }
}
