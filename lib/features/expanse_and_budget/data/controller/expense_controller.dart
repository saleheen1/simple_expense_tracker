import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/expense_model.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/expense_repo.dart';


class ExpenseController extends GetxController {
  final expenseRepo = Get.find<ExpenseRepo>();

  //===============
  // Add expense
  //===============
  Future<void> addExpense(ExpenseModel expense) async {
    await expenseRepo.createExpense(expense);
    debugPrint('Controller: Expense added');
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
