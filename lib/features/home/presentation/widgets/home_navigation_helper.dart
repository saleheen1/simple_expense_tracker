import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeNavigationHelper {
  List<TargetFocus> createTargets({required List<GlobalKey> keys}) {
    List<TargetFocus> targets = [];
    //===============================================
    //Click here to go the add expense page
    //===============================================
    targets.add(
      TargetFocus(
        identify: "${keys[0]}identify",
        keyTarget: keys[0],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapH(55),
                  Text(
                    'Click here to add expense',
                    style: TextUtils.title3(context: context),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    //===============================================
    //Click here to go the add budget page
    //===============================================
    targets.add(
      TargetFocus(
        identify: "${keys[1]}identify",
        keyTarget: keys[1],
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapH(55),
                  Text(
                    'Click here to add budget',
                    style: TextUtils.title3(context: context),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    //===============================================
    //Click here to go the history tab
    //===============================================
    targets.add(
      TargetFocus(
        identify: "${keys[2]}identify",
        keyTarget: keys[2],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapH(55),
                  Text(
                    'Click here to see history',
                    style: TextUtils.title3(context: context),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}
