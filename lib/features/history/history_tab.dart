import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/expanse_and_budget_card.dart';
import 'package:simple_expense_tracker/core/widgets/expanse_card.dart';
import 'package:simple_expense_tracker/core/widgets/notification_bar.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationBar(),

            //=====================
            //Months
            //=====================
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blueAccent,
                    height: 30,
                    child: ListView.builder(
                      itemCount: 300,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Text('Month');
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
                  child: Container(
                    color: Colors.green,
                    height: 50,
                    child: ListView.builder(
                      itemCount: 300,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Text('Month');
                      },
                    ),
                  ),
                ),
              ],
            ),
            gapH(50),

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
                  child: ExpanseAndBudgetCard(
                    title: 'Total expanse',
                    amount: totalExpanse,
                  ),
                ),
                gapW(20),

                //=============================
                //Budget
                //=============================
                Expanded(
                  child: ExpanseAndBudgetCard(title: 'Budget', amount: budget),
                ),
              ],
            ),
            gapH(40),

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
        ),
      ),
    );
  }
}
