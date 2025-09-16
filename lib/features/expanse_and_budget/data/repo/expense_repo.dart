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
        // {
        //   'date': expense.date,
        //   'name': expense.name,
        //   'cost': expense.cost,
        // },
        expense.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return true;
    } catch (error) {
      debugPrint('[expense_repo]: Error inserting expense: $error');
      return false;
    }
  }

  //==================
  // Read all expenses
  //==================
  Future<List<ExpenseModel>> getAllExpenses() async {
    try {
      final db = await _dbHelper.database;
      final result = await db.query('expenses');
      debugPrint('Fetched ${result.length} expenses');
      return result.map((e) => ExpenseModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error fetching expenses: $e');
      return [];
    }
  }
}
