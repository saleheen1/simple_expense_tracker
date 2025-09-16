import 'package:get/get.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/budget_repo.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/expense_repo.dart';
import 'package:simple_expense_tracker/features/home/data/controller/navigation_controller.dart';

Future<void> initBindings() async {
  Get.put(NavigationController());

  //Budget
  Get.put(BudgetRepo());
  Get.put(BudgetController());

  //Expense
  Get.put(ExpenseRepo());
  Get.put(ExpenseController());
}
