import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/repo/expense_repo.dart';

import '../../../expanse_and_budget/data/model/expense_model.dart';

class GraphController extends GetxController {
  final eRepo = Get.find<ExpenseRepo>();

  List<ExpenseModel> expensesOfFourWeeks = [];

  @override
  void onInit() {
    super.onInit();
    getExpensesOfFourWeeks();
  }

  Future<void> getExpensesOfFourWeeks() async {
    final now = DateTime.now();
    final int year = now.year;
    final int month = now.month;

    final expenses = await eRepo.fetchExpenses(year: year, month: month);

    // Prepare 4 buckets for the month (1-7, 8-14, 15-21, 22-end)
    final List<double> weeklyTotals = [0, 0, 0, 0];

    for (final expense in expenses) {
      // Dates are saved in ISO 'yyyy-MM-dd'
      final DateTime expenseDate = DateFormat('yyyy-MM-dd').parse(expense.date);
      final int day = expenseDate.day;

      int bucketIndex;
      if (day <= 7) {
        bucketIndex = 0;
      } else if (day <= 14) {
        bucketIndex = 1;
      } else if (day <= 21) {
        bucketIndex = 2;
      } else {
        bucketIndex = 3;
      }

      weeklyTotals[bucketIndex] += expense.cost;
    }

    // Build exactly 4 items to plot or consume downstream
    final DateTime week1Start = DateTime(year, month, 1);
    final DateTime week2Start = DateTime(year, month, 8);
    final DateTime week3Start = DateTime(year, month, 15);
    final DateTime week4Start = DateTime(year, month, 22);

    final dateFmt = DateFormat('yyyy-MM-dd');

    expensesOfFourWeeks = [
      ExpenseModel(
        description: 'Week 1',
        date: dateFmt.format(week1Start),
        cost: double.parse(weeklyTotals[0].toStringAsFixed(2)),
      ),
      ExpenseModel(
        description: 'Week 2',
        date: dateFmt.format(week2Start),
        cost: double.parse(weeklyTotals[1].toStringAsFixed(2)),
      ),
      ExpenseModel(
        description: 'Week 3',
        date: dateFmt.format(week3Start),
        cost: double.parse(weeklyTotals[2].toStringAsFixed(2)),
      ),
      ExpenseModel(
        description: 'Week 4',
        date: dateFmt.format(week4Start),
        cost: double.parse(weeklyTotals[3].toStringAsFixed(2)),
      ),
    ];

    update();
  }
}
