import 'package:flutter/foundation.dart';
import 'package:simple_expense_tracker/core/database/model/expanse_model.dart';
import 'package:simple_expense_tracker/core/database/repo/expanse_repo.dart';

class ExpenseController {
  final ExpenseRepo _repo = ExpenseRepo();

  Future<void> addExpense(ExpenseModel expense) async {
    await _repo.createExpense(expense);
    debugPrint('Controller: Expense added');
  }

  Future<List<ExpenseModel>> fetchExpenses() async {
    final expenses = await _repo.getAllExpenses();
    debugPrint('Controller: ${expenses.length} expenses fetched');
    return expenses;
  }
}
