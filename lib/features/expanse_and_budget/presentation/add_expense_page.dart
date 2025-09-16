import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/button_primary.dart';
import 'package:simple_expense_tracker/core/widgets/custom_input.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Add expense', context),
      body: DefaultMarginWidget(
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
                    labelText: 'Month',
                    hintText: 'This month',
                  ),
                ),
                gapW(20),

                Expanded(
                  child: CustomInput(labelText: 'Date', hintText: 'today'),
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
                    labelText: 'Short description',
                    hintText: 'Brought fruits',
                  ),
                ),
                gapW(20),

                Expanded(
                  child: CustomInput(labelText: 'Cost', hintText: 'Enter cost'),
                ),
              ],
            ),

            Spacer(),
            ButtonPrimary(text: 'Save', onPressed: () {}),
            gapH(50),
          ],
        ),
      ),
    );
  }
}
