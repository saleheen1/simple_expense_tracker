import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/button_primary.dart';
import 'package:simple_expense_tracker/core/widgets/custom_input.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';

class AddBudgetPage extends StatelessWidget {
  const AddBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Add budget', context),
      body: DefaultMarginWidget(
        child: Column(
          children: [
            gapH(15),
            //==================
            //Month and Year
            //==================
            Row(
              children: [
                Expanded(
                  child: CustomInput(
                    labelText: 'Month',
                    hintText: 'This month',
                  ),
                ),
                gapW(20),

                Expanded(
                  child: CustomInput(labelText: 'Year', hintText: 'this year'),
                ),
              ],
            ),
            gapH(40),

            //===================
            //Budget
            //===================
            CustomInput(labelText: 'Budget', hintText: 'Enter budget'),

            Spacer(),
            ButtonPrimary(text: 'Save', onPressed: () {}),
            gapH(50),
          ],
        ),
      ),
    );
  }
}
