import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  final double offsetY;

  CustomFABLocation({this.offsetY = 20});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;
    final double contentBottom = scaffoldGeometry.contentBottom;

    return Offset(
      fabX,
      contentBottom -
          (scaffoldGeometry.floatingActionButtonSize.height / 2) +
          offsetY,
    );
  }
}