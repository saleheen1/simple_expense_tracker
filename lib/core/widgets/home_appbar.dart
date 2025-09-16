import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';

class HomeAppbar extends StatelessWidget {
  final VoidCallback onMenuTap;

  const HomeAppbar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: statusBarHeight,
        bottom: 10,
      ),
      decoration: BoxDecoration(color: theme.bgColor, borderRadius: radius(3)),
      child: Row(
        children: [
          InkWell(
            onTap: onMenuTap,
            child: Icon(Icons.menu, size: 30, color: theme.primary),
          ),

          gapW(20),

          Text(style: TextUtils.title1Bold(context: context), 'This month'),
        ],
      ),
    );
  }
}
