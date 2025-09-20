import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.onChanged,
    required this.title,
    this.subtitle,
    required this.value,
    this.showCheckAtEnd = true,
    this.showTwoCheckAtEnd = false,
    this.onSecondChanged,
    this.secondValue,
  });

  final Function(bool?)? onChanged;
  final String title;
  final String? subtitle;
  final bool value;
  final bool showCheckAtEnd;
  final bool showTwoCheckAtEnd;
  final Function(bool?)? onSecondChanged;
  final bool? secondValue;

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Row(
      children: [
        if (!showCheckAtEnd && !showTwoCheckAtEnd) ...[
          _buildCheckbox(theme),
          gapW(1),
        ],
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextUtils.b1Regular(context: context),
          ),
        ),
        if (showCheckAtEnd && !showTwoCheckAtEnd) ...[
          gapW(1),
          _buildCheckbox(theme),
        ],
        if (showTwoCheckAtEnd) ...[gapW(1), _buildCheckbox(theme)],
      ],
    );
  }

  Widget _buildCheckbox(CustomThemeData theme) {
    return Checkbox(
      activeColor: theme.primary,
      checkColor: Colors.white,
      side: BorderSide(width: 1, color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(width: 1, color: Colors.black.withValues(alpha: 1.3)),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
