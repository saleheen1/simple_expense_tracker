import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';

class ExpanseAndBudgetCard extends StatelessWidget {
  final String title;
  final String amount;
  const ExpanseAndBudgetCard({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(style: TextUtils.title3(context: context), title),
          gapH(10),
          Text(style: TextUtils.title1Bold(context: context), '\$$amount'),
        ],
      ),
    );
  }
}
