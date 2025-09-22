import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/database/database_helper.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/budget_model.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepo extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //===============
  // Insert budget
  //===============
  Future<bool> upsertBudget(BudgetModel budget) async {
    try {
      final db = await _dbHelper.database;

      await db.insert(
        'budgets',
        budget.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return true;
    } catch (error) {
      debugPrint('[budget_repo]: Error inserting budget: $error');
      return false;
    }
  }

  //=================
  // Read budget of a given month, and year
  //=================
  Future<double> fetchMonthBudget({
    required int year,
    required int month,
  }) async {
    try {
      debugPrint('[budget_repo]: Fetching month budget: $year, $month');
      final db = await _dbHelper.database;

      final result = await db.query(
        'budgets',
        columns: ['budget'],
        where: 'year = ? AND month = ?',
        whereArgs: [year, month],
        limit: 1,
      );

      if (result.isNotEmpty) {
        final budget = (result.first['budget'] as num).toDouble();
        return budget;
      }

      return 0; // No record found for this month/year
    } catch (error) {
      debugPrint('[budget_repo]: Error fetching month budget: $error');
      return 0; // Return 0 on error as a fallback
    }
  }
}
