import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';

class MonthCard extends StatelessWidget {
  final bool isSelected;
  const MonthCard({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Container(
      color: isSelected ? theme.cardColor : Colors.transparent,
      width: 100,
      height: 35,
      child: Center(
        child: Text(
          'February',
          style: TextUtils.title3(
            context: context,
            color: isSelected ? theme.primary : Colors.white,
          ),
        ),
      ),
    );
  }
}
