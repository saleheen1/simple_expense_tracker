import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/button_primary.dart';
import 'package:simple_expense_tracker/core/widgets/custom_dropdown.dart';
import 'package:simple_expense_tracker/core/widgets/custom_input.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';

class AddBudgetPage extends StatelessWidget {
  const AddBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Add budget', context),
      body: DefaultMarginWidget(
        child: GetBuilder<BudgetController>(
          builder: (bc) {
            return Column(
              children: [
                gapH(15),
                //==================
                //Month and Year
                //==================
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDown(
                        label: 'Month',
                        items: [
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December',
                        ],
                        value: 'January',
                        onChange: (p0) => {},
                      ),
                    ),
                    gapW(20),

                    Expanded(
                      child: CustomDropDown(
                        label: 'Year',
                        items: ['2025', '2026'],
                        value: '2025',
                        onChange: (p0) => {},
                      ),
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
            );
          },
        ),
      ),
    );
  }
}
