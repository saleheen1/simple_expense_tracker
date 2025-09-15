import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/budget_model.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/budget_repo.dart';



class BudgetController extends GetxController {
  final BudgetRepo _repo = BudgetRepo();

  //=============
  // Add budget
  //=============
  Future<void> addBudget(BudgetModel budget) async {
    await _repo.createBudget(budget);
    debugPrint('Controller: Budget added');
  }


  //=============
  // Fetch Budgets
  //=============
  Future<List<BudgetModel>> fetchBudgets() async {
    final budgets = await _repo.getAllBudgets();
    debugPrint('Controller: ${budgets.length} budgets fetched');
    return budgets;
  }
}
