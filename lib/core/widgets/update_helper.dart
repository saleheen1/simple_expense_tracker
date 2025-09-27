import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/save_cancel_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

checkUpdate() async {
  try {
    const appleId =
        '1234567890'; // If this value is null, its packagename will be considered
    const playStoreId = 'com.inshirahtech.simple_expense_tracker';
    await AppVersionUpdate.checkForUpdates(
      appleId: appleId,
      playStoreId: playStoreId,
    ).then((data) async {
      if (data.canUpdate!) {
        updateAppPopup();
      }
    });
  } catch (e) {
    debugPrint('Error checking for app updates: $e');
  }
}

updateAppPopup() {
  return Get.defaultDialog(
    title: '',
    backgroundColor: const Color(0xff1F232F),
    content: Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'New version available',
            style: TextStyle(
              color: const Color(0xffF5F9FA),
              fontSize: Get.width * .045,
              height: 1.3,
              fontWeight: FontWeight.w800,
            ),
          ),
          gapH(5),
          Text(
            'Update to get the latest features',
            style: TextStyle(
              color: const Color(0xffF5F9FA),
              fontSize: Get.width * .035,
              height: 1.3,
            ),
          ),
          gapH(30),
          SaveCancelButtons(
            leftButtonText: 'Not now',
            rightButtonText: 'Update',
            onLeftPressed: () {
              Get.back();
            },
            onRightPressed: () {
              launchUrl(
                Uri.parse(
                  "https://play.google.com/store/apps/details?id=com.inshirahtech.simple_expense_tracker",
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
