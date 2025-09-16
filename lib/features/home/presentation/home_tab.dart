import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/expense_and_budget_card.dart';
import 'package:simple_expense_tracker/core/widgets/expense_card.dart';
import 'package:simple_expense_tracker/core/widgets/home_appbar.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onMenuTap;
  const HomeTab({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppbar(onMenuTap: onMenuTap),

        Expanded(
          child: DefaultMarginWidget(
            child: GetBuilder<BudgetController>(
              builder: (bc) {
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
                        Expanded(child: ExpenseAndBudgetCard(amount: '731')),
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
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}
