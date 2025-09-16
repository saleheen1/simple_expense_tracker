import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/helper/common_helper.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/button_primary.dart';
import 'package:simple_expense_tracker/core/widgets/custom_dropdown.dart';
import 'package:simple_expense_tracker/core/widgets/custom_input.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/loader_widget.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/budget_controller.dart';

class AddBudgetPage extends StatelessWidget {
  const AddBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Add budget', context),
      body: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: DefaultMarginWidget(
          child: GetBuilder<BudgetController>(
            builder: (bc) {
              return LoaderWidget(
                isLoading: bc.isLoading,
                child: Column(
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
                            items: bc.months,
                            value: bc.selectedMonth,
                            onChange: (value) {
                              if (value != null) bc.updateMonth(value);
                            },
                          ),
                        ),
                        gapW(20),

                        Expanded(
                          child: CustomDropDown(
                            label: 'Year',
                            items: bc.years,
                            value: bc.selectedYear,
                            onChange: (value) {
                              if (value != null) bc.updateYear(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    gapH(40),

                    //===================
                    //Budget
                    //===================
                    CustomInput(
                      controller: bc.budgetInputController,
                      labelText: 'Budget',
                      hintText: 'Enter budget',
                    ),

                    Spacer(),
                    ButtonPrimary(
                      text: 'Save',
                      onPressed: () {
                        bc.addBudget();
                      },
                    ),
                    gapH(50),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}