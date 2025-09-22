import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/presentation/add_budget_page.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/presentation/add_expense_page.dart';

class ExpenseAndBudgetCard extends StatelessWidget {
  final String amount;
  final bool isBudgetCard;
  const ExpenseAndBudgetCard({
    super.key,
    required this.amount,
    this.isBudgetCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return GestureDetector(
      onTap: () {
        if (isBudgetCard) {
          Get.to(() => AddBudgetPage());
        } else {
          Get.to(() => AddExpensePage());
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: TextUtils.b1SemiBold(context: context),
              isBudgetCard ? 'Budget' : 'Total expense',
            ),
            gapH(10),
            Text(
              style: TextUtils.title2(context: context),
              '\$$amount',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
