import 'package:flutter/material.dart';

class CustomThemeData {
  final Color primary;
  final Color grey1;
  final Color grey2;
  final Color bgColor;
  final Color cardColor;
  final Color placeholder;
  final Color textColor;
  final Color golden;
  final Color darkLight;

  CustomThemeData({
    required this.primary,
    required this.grey1,
    required this.grey2,
    required this.bgColor,
    required this.cardColor,
    required this.placeholder,
    required this.textColor,
    required this.golden,
    required this.darkLight
  });
}

class CustomTheme extends InheritedWidget {
  final CustomThemeData customThemeData;

  const CustomTheme({
    super.key,
    required this.customThemeData,
    required super.child,
  });

  static CustomThemeData of(BuildContext context) {
    final CustomTheme? customTheme = context
        .dependOnInheritedWidgetOfExactType<CustomTheme>();
    return customTheme!.customThemeData;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

// ::test to make theme accessing shorter and normal way insead of CustomTheme.of()
extension ThemeExtender on ThemeData {
  Color get myColor =>
      brightness == Brightness.dark ? Colors.black : Colors.white;
}
