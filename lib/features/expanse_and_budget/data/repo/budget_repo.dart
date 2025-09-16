import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/database/database_helper.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/budget_model.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepo extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //===============
  // Create budget
  //===============
  Future<void> createBudget({
    required int year,
    required int month,
    required double budget,
  }) async {
    
    try {
      final db = await _dbHelper.database;
      await db.insert('budgets', {
        'year': year,
        'month': month,
        'budget': budget,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      debugPrint(
        '[budget_repo] Budget: $budget inserted, year: $year, and month: month',
      );
    } catch (e) {
      debugPrint('Error inserting budget: $e');
    }
  }

  //=================
  // Read all budgets
  //=================
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
