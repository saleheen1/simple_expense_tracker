import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/helper/date_picker_popup.dart';
import 'package:simple_expense_tracker/core/utils/format_date_time.dart';


Future<String?> selectDate(BuildContext context) async {
  final DateTime? picked = await datePickerPopup(context);
  if (picked != null) {
    return formatDateByMMMDDYY(picked);
  }
  return null;
}