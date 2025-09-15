import 'package:flutter/foundation.dart';
import 'package:simple_expense_tracker/core/database/model/budget_model.dart';
import 'package:simple_expense_tracker/core/database/repo/budget_repo.dart';


class BudgetController {
  final BudgetRepo _repo = BudgetRepo();

  Future<void> addBudget(BudgetModel budget) async {
    await _repo.createBudget(budget);
    debugPrint('Controller: Budget added');
  }

  Future<List<BudgetModel>> fetchBudgets() async {
    final budgets = await _repo.getAllBudgets();
    debugPrint('Controller: ${budgets.length} budgets fetched');
    return budgets;
  }
}
