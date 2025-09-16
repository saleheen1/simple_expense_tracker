import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/expense_and_budget_card.dart';
import 'package:simple_expense_tracker/core/widgets/expense_card.dart';
import 'package:simple_expense_tracker/core/widgets/home_appbar.dart';

class HomeTab extends StatelessWidget {
  final String totalExpanse;
  final String budget;
  final VoidCallback onMenuTap;
  const HomeTab({
    super.key,
    required this.onMenuTap,
    required this.budget,
    required this.totalExpanse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppbar(onMenuTap: onMenuTap),

        Expanded(
          child: DefaultMarginWidget(
            child: Column(
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
                    Expanded(child: ExpenseAndBudgetCard(amount: totalExpanse)),
                    gapW(20),

                    //=============================
                    //Budget
                    //=============================
                    Expanded(
                      child: ExpenseAndBudgetCard(
                        isBudgetCard: true,
                        amount: budget,
                      ),
                    ),
                  ],
                ),
                gapH(20),

                //=========================
                //Expanses list
                //=========================
                Text(style: TextUtils.title3(context: context), 'Expanse list'),
                gapH(20),

                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ExpanseCard(
                        index: index,
                        title: 'Fruits and shopping',
                        amount: '689',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
