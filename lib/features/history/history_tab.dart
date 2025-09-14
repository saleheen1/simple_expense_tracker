import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('History tab', context),
      body: Placeholder(),
    );
  }
}