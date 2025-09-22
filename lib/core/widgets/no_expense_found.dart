import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';

class NoExpenseFound extends StatelessWidget {
  const NoExpenseFound({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Container(
      height: height ?? Get.height / 2,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sticky_note_2_outlined, color: theme.grey1, size: 30),
          gapH(10),
          Text('No expenses added'),
        ],
      ),
    );
  }
}
