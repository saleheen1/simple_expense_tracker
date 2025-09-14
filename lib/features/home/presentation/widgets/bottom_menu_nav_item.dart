import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';

class BottomMenuNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final int unreadCount;

  const BottomMenuNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
    this.unreadCount = 0, // Default to 0
  });

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final activeColor = theme.primary;
    final inactiveColor = theme.grey1;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: isActive ? activeColor : inactiveColor),
            gapH(6),
            Text(
              label,
              style: TextUtils.captionSemiBold(
                context: context,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
