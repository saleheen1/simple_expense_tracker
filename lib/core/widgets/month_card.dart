import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';

class MonthCard extends StatelessWidget {
  final bool isSelected;
  final String monthName;
  final VoidCallback? onTap;

  const MonthCard({
    super.key,
    this.isSelected = false,
    required this.monthName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? theme.cardColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        width: 100,
        height: 35,
        child: Center(
          child: Text(
            monthName,
            style: TextUtils.title3(
              context: context,
              color: isSelected ? theme.primary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
