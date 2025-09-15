import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';

class DayCard extends StatelessWidget {
  final bool isSelected;
  final String monthName;
  final String date;
  final String weekdayName;
  const DayCard({
    super.key,
    this.isSelected = false,
    required this.date,
    required this.weekdayName,
    required this.monthName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Container(
      width: 50,
      height: 75,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: isSelected ? theme.cardColor : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            monthName,
            style: TextUtils.b1Small(
              color: isSelected ? theme.primary : Colors.white,
              context: context,
            ),
          ),
          Text(
            date,
            style: TextUtils.title3(
              color: isSelected ? theme.primary : Colors.white,
              context: context,
            ),
          ),
          Text(
            weekdayName,
            style: TextUtils.b1Small(
              color: isSelected ? theme.primary : Colors.white,
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
