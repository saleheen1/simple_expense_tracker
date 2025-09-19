import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/day_card.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/expense_and_budget_card.dart';
import 'package:simple_expense_tracker/core/widgets/expense_card.dart';
import 'package:simple_expense_tracker/core/widgets/month_card.dart';
import 'package:simple_expense_tracker/core/widgets/notification_bar.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';

class HistoryTab extends StatelessWidget {
  final String totalExpanse;
  final String budget;
  const HistoryTab({
    super.key,
    required this.budget,
    required this.totalExpanse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultMarginWidget(
        child: GetBuilder<BudgetController>(
          builder: (bc) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationBar(),

                //=====================
                //Months
                //=====================
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 35,
                        child: ListView.builder(
                          itemCount: bc.months.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return MonthCard(
                              monthName: bc.months[index],
                              isSelected: bc.selectedMonthIndex == index,
                              onTap: () => bc.selectMonthInHistory(index),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                gapH(20),

                //=====================
                //Days
                //=====================
                Row(
                  children: [
                    _allButton(context, true),
                    Expanded(
                      child: SizedBox(
                        height: 75,
                        child: ListView.builder(
                          itemCount: bc.getWeekdaysOfSelectedMonth(monthIndex: bc.selectedMonthIndex).length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return DayCard(
                              isSelected: false,
                              date: (index + 1).toString(),
                              monthName: bc.months[bc.selectedMonthIndex],
                              weekdayName: bc.getWeekdaysOfSelectedMonth(monthIndex: bc.selectedMonthIndex)[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                gapH(30),

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
                        amount: '${bc.budgetOfGivenMonth}'
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
                        isStats: true,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _allButton(BuildContext context, bool isSelected) {
    final theme = CustomTheme.of(context);

    return Container(
      width: 50,
      height: 75,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: isSelected ? theme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          'All',
          style: TextUtils.title3(
            color: isSelected ? theme.bgColor : Colors.white,
            context: context,
          ),
        ),
      ),
    );
  }
}
