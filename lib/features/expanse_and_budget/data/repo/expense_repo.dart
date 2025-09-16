import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:simple_expense_tracker/core/database/database_helper.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepo extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //===============
  // Insert expense
  //===============
  Future<bool> upsertExpense(ExpenseModel expense) async {
    try {
      final db = await _dbHelper.database;

      await db.insert(
        'expenses',
        expense.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return true;
    } catch (error) {
      debugPrint('[expense_repo]: Error inserting expense: $error');
      return false;
    }
  }

  // ==================
  // Read expenses of a given month and year
  // ==================
  Future<List<ExpenseModel>> fetchExpensesByMonth({
    required int year,
    required int month,
  }) async {
    try {
      final db = await _dbHelper.database;

      final yearStr = year.toString();
      final monthStr = month.toString().padLeft(2, '0'); // e.g. "09"

      final result = await db.query(
        'expenses',
        where: "strftime('%Y', date) = ? AND strftime('%m', date) = ?",
        whereArgs: [yearStr, monthStr],
      );

      return result.map((row) => ExpenseModel.fromJson(row)).toList();
    } catch (error) {
      debugPrint('[expense_repo]: Error fetching expenses: $error');
      return [];
    }
  }
}
