import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:simple_expense_tracker/core/widgets/home_appbar.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onMenuTap;
  const HomeTab({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppbar(onMenuTap: onMenuTap),

        Expanded(
          child: SingleChildScrollView(
            child: DefaultMarginWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH(15),
                  Text(
                    style: TextUtils.title1Bold(context: context),
                    'This month',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
