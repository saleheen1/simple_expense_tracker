import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:simple_expense_tracker/core/database/database_helper.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepo extends GetxController{
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //===============
  // Create expense
  //===============
  Future<void> createExpense(ExpenseModel expense) async {
    try {
      final db = await _dbHelper.database;
      await db.insert(
        'expenses',
        {
          'date': expense.date,
          'name': expense.name,
          'cost': expense.cost,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Expense inserted: ${expense.name}');
    } catch (e) {
      debugPrint('Error inserting expense: $e');
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
