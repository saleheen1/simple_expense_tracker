import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/helper/common_helper.dart';
import 'package:simple_expense_tracker/core/helper/pick_date.dart';
import 'package:simple_expense_tracker/core/utils/format_date_time.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/button_primary.dart';
import 'package:simple_expense_tracker/core/widgets/custom_input.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/loader_widget.dart';
import 'package:simple_expense_tracker/features/expanse_and_budget/data/controller/expense_controller.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  @override
  void initState() {
    super.initState();
    fillData();
  }

  //fill data
  fillData() {
    final ec = Get.find<ExpenseController>();
    ec.dateController.text = formatDateByMMMDDYY(DateTime.now()) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        appBar: appbarCommon('Add expense', context),

        body: DefaultMarginWidget(
          child: GetBuilder<ExpenseController>(
            builder: (ec) {
              return LoaderWidget(
                isLoading: ec.isLoading,
                child: Column(
                  children: [
                    gapH(15),
                    //==================
                    //Month and Date
                    //==================
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            controller: ec.dateController,
                            labelText: 'Date',
                            hintText: 'Pick a date',
                            readOnly: true,
                            onTap: () async {
                              final date = await selectDate(context);
                              if (date != null) {
                                ec.dateController.text = date;
                                ec.update();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    gapH(40),

                    //===================
                    //Short description and cost
                    //===================
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            controller: ec.nameController,
                            labelText: 'Short description',
                            hintText: 'Ex. Brought fruits',
                          ),
                        ),
                        gapW(20),

                        Expanded(
                          child: CustomInput(
                            controller: ec.amountController,
                            labelText: 'Cost',
                            hintText: 'Enter cost',
                            isNumberField: true,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),
                    ButtonPrimary(
                      text: 'Save',
                      onPressed: () {
                        ec.addExpense();
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
