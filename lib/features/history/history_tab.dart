import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/day_card.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/expense_and_budget_card.dart';
import 'package:simple_expense_tracker/core/widgets/expense_card.dart';
import 'package:simple_expense_tracker/core/widgets/month_card.dart';
import 'package:simple_expense_tracker/core/widgets/notification_bar.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';

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
            final days = bc.getDaysOfSelectedMonth(
              monthIndex: bc.selectedMonthIndex,
            );
            final scrollController = ScrollController();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                const double monthCardWidth = 100.0;
                final double targetOffset =
                    bc.selectedMonthIndex * monthCardWidth;
                scrollController.jumpTo(
                  targetOffset.clamp(
                    0.0,
                    scrollController.position.maxScrollExtent,
                  ),
                );
              }
            });
            return GetBuilder<ExpenseController>(
              builder: (ec) {
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
                              controller: scrollController,
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
                        Expanded(
                          child: SizedBox(
                            height: 75,
                            child: ListView.builder(
                              itemCount: days.length + 1,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return DayCard(
                                    isSelected: bc.isDaySelected(0),
                                    date: 0,
                                    monthName: bc.months[bc.selectedMonthIndex],
                                    weekdayName: "",
                                    onTap: () => bc.selectDayInHistory(0),
                                  );
                                }
                                final day = days[index - 1];
                                return DayCard(
                                  isSelected: bc.isDaySelected(
                                    index,
                                  ), // Use the helper method
                                  date: day.date,
                                  monthName: bc.months[bc.selectedMonthIndex],
                                  weekdayName: day.weekday,
                                  onTap: () => bc.selectDayInHistory(index),
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
                        Expanded(
                          child: ExpenseAndBudgetCard(
                            amount: '${ec.totalExpenseOfGivenDate}',
                          ),
                        ),
                        gapW(20),

                        //=============================
                        //Budget
                        //=============================
                        Expanded(
                          child: ExpenseAndBudgetCard(
                            isBudgetCard: true,
                            amount: '${bc.budgetOfGivenMonth}',
                          ),
                        ),
                      ],
                    ),
                    gapH(20),

                    //=========================
                    //Expanses list
                    //=========================
                    Text(
                      style: TextUtils.title3(context: context),
                      'Expanse list',
                    ),
                    gapH(20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: ec.expensesOfGivenDate.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ExpanseCard(
                            index: index,
                            title: ec.expensesOfGivenDate[index].name,
                            amount: ec.expensesOfGivenDate[index].cost
                                .toString(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
