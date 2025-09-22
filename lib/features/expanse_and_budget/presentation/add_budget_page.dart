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

class AddBudgetPage extends StatefulWidget {
  const AddBudgetPage({super.key});

  @override
  State<AddBudgetPage> createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setCurrentMonthAndYear();
      loadCurrentMonthBudget();
    });
  }

  setCurrentMonthAndYear() {
    final bc = Get.find<BudgetController>();
    final date = DateTime.now();
    final monthName = date.month;
    bc.updateMonth(bc.months[monthName - 1]);
    bc.updateYear(date.year.toString());
  }

  loadCurrentMonthBudget() {
    final bc = Get.find<BudgetController>();
    bc.amountController.text = bc.budgetOfCurrentMonth.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        appBar: appbarCommon('Add budget', context),

        body: DefaultMarginWidget(
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
                      controller: bc.amountController,
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
