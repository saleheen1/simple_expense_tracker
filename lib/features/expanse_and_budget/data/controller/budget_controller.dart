import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/budget_model.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/budget_repo.dart';



class BudgetController extends GetxController {
  final budgetRepo = Get.find<BudgetRepo>();

  //=============
  // Add budget
  //=============
  Future<void> addBudget(BudgetModel budget) async {
    await budgetRepo.createBudget(budget);
    debugPrint('Controller: Budget added');
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
