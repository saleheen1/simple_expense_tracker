import 'package:flutter/material.dart';

Future<DateTime?> datePickerPopup(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
    builder: (context, child) {
      return child!;
    },
  );

  return picked;
}