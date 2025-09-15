import 'package:flutter/foundation.dart';
import 'package:simple_expense_tracker/core/database/database_helper.dart';
import 'package:simple_expense_tracker/core/database/model/budget_model.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepo {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Create budget
  Future<void> createBudget(BudgetModel budget) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        'budgets',
        {
          'year': budget.year,
          'month': budget.month,
          'budget': budget.budget,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Budget inserted: ${budget.year}-${budget.month}');
    } catch (e) {
      debugPrint('Error inserting budget: $e');
    }
  }

  // Read all budgets
  Future<List<BudgetModel>> getAllBudgets() async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query('budgets');
      debugPrint('Fetched ${result.length} budgets');
      return result.map((e) => BudgetModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error fetching budgets: $e');
      return [];
    }
  }
}
