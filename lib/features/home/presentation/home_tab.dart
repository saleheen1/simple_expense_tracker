import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/expense_and_budget_card.dart';
import 'package:simple_expense_tracker/core/widgets/expense_card.dart';
import 'package:simple_expense_tracker/core/widgets/home_appbar.dart';
import 'package:simple_expense_tracker/core/widgets/no_expense_found.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';
import 'package:simple_expense_tracker/features/home/presentation/widgets/home_graph.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onMenuTap;
  const HomeTab({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return SafeArea(
      child: Column(
        children: [
          HomeAppbar(onMenuTap: onMenuTap),

          Expanded(
            child: SingleChildScrollView(
              child: DefaultMarginWidget(
                child: GetBuilder<BudgetController>(
                  builder: (bc) {
                    return GetBuilder<ExpenseController>(
                      builder: (ec) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gapH(15),
                            //=============================
                            //Total expanse and budget
                            //=============================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //=============================
                                //Total expanse
                                //=============================
                                Expanded(
                                  child: ExpenseAndBudgetCard(
                                    amount: '${ec.totalExpenseOfCurrentMonth}',
                                  ),
                                ),
                                gapW(20),

                                //=============================
                                //Budget
                                //=============================
                                Expanded(
                                  child: ExpenseAndBudgetCard(
                                    isBudgetCard: true,
                                    amount: '${bc.budgetOfCurrentMonth}',
                                  ),
                                ),
                              ],
                            ),

                            //================================
                            //Graph
                            //================================
                            gapH(25),
                            HomeGraph(),

                            gapH(25),

                            //=========================
                            //Expanses list
                            //=========================
                            if (ec.expensesOfCurrentMonth.isNotEmpty)
                              Text(
                                style: TextUtils.title3(context: context),
                                'Expense list',
                              ),
                            gapH(20),

                            if (ec.expensesOfCurrentMonth.isNotEmpty)
                              ListView.builder(
                                itemCount: ec.expensesOfCurrentMonth.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ExpanseCard(
                                    index: index,
                                    expense: ec.expensesOfCurrentMonth[index],
                                  );
                                },
                              ),

                            //=========================
                            // No expenses added
                            //=========================
                            if (ec.expensesOfCurrentMonth.isEmpty &&
                                !ec.isLoading)
                              NoExpenseFound(),

                            gapH(30),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
