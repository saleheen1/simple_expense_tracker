import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/model/expense_model.dart';

class ExpanseCard extends StatelessWidget {
  final int index;
  final bool isStats;
  final ExpenseModel expense;
  const ExpanseCard({
    super.key,
    required this.index,
    this.isStats = false,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final ec = Get.find<ExpenseController>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: isStats ? 70 : 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          //===============================================
          //Index
          //===============================================
          Container(
            width: 70,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: theme.bgColor, width: 1.5),
              ),
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: TextUtils.title1Bold(
                  context: context,
                  color: theme.grey1,
                ).copyWith(fontSize: 30),
              ),
            ),
          ),

          //===============================================
          //content
          //===============================================
          gapW(15),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //===============================================
                //title and count & limit
                //===============================================
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        expense.description,
                        style: TextUtils.b1SemiBold(context: context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      gapH(7),

                      //===============================================
                      //Count & limit
                      //===============================================
                      Text(
                        '\$${expense.cost}',
                        style: TextUtils.caption1(
                          context: context,
                          color: theme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                //===============================================
                // Popup button
                //===============================================
                if (!isStats)
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, size: 18, color: Colors.white),
                    onSelected: (value) {
                      switch (value) {
                        case 'delete':
                          ec.deleteExpense(expense.id);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                              size: 18,
                            ),
                            gapW(10),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
