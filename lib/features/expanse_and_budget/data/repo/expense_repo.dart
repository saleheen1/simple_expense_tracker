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
  // Read expenses of a given year, month (and optionally day)
  // ==================
  Future<List<ExpenseModel>> fetchExpenses({
    required int year,
    required int month,
    int? day, // if provided, fetch by day too
  }) async {
    try {
      final db = await _dbHelper.database;

      final yearStr = year.toString();
      final monthStr = month.toString().padLeft(2, '0');
      final whereArgs = [yearStr, monthStr];

      String where = "strftime('%Y', date) = ? AND strftime('%m', date) = ?";

      if (day != null) {
        final dayStr = day.toString().padLeft(2, '0');
        where += " AND strftime('%d', date) = ?";
        whereArgs.add(dayStr);
      }

      final result = await db.query(
        'expenses',
        where: where,
        whereArgs: whereArgs,
      );

      return result.map((row) => ExpenseModel.fromJson(row)).toList();
    } catch (error) {
      debugPrint('[expense_repo]: Error fetching expenses: $error');
      return [];
    }
  }

  //==========================================
  // Delete expense
  //==========================================
  Future<void> deleteExpense(int id) async {
    final db = await _dbHelper.database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
