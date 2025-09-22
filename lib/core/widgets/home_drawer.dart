import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/features/others/presentation/buy_this_app_page.dart';
import 'package:simple_expense_tracker/features/others/presentation/contact_page.dart';
import 'package:simple_expense_tracker/features/others/presentation/hire_me_page.dart';
import 'package:simple_expense_tracker/features/others/presentation/my_other_apps.dart';
import 'package:simple_expense_tracker/features/others/presentation/support_me_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.zero,
          ),
          child: Column(
            children: [
              gapH(200),
              // Menu items
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(SupportMePage()),
                        child: Row(
                          children: [
                            Icon(Icons.favorite_rounded, color: theme.primary),
                            gapW(15),
                            Text(
                              'Support me',
                              style: TextUtils.title3(context: context),
                            ),
                          ],
                        ),
                      ),
                      // gapH(30),

                      // GestureDetector(
                      //   onTap: () async {
                      //     final url = Uri.parse(
                      //       'https://play.google.com/store/apps/details?id=com.easy.quran.learning.inshirah',
                      //     );
                      //       await launchUrl(
                      //         url,
                      //         mode: LaunchMode.externalApplication,
                      //       );

                      //   },
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.star_rounded, color: theme.primary),
                      //       gapW(15),
                      //       Text(
                      //         'Rate this app',
                      //         style: TextUtils.title3(context: context),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      gapH(30),

                      GestureDetector(
                        onTap: () => Get.to(HireMePage()),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: theme.primary,
                            ),
                            gapW(15),
                            Text(
                              'Hire me',
                              style: TextUtils.title3(context: context),
                            ),
                          ],
                        ),
                      ),
                      gapH(30),

                      GestureDetector(
                        onTap: () => Get.to(MyOtherApps()),
                        child: Row(
                          children: [
                            Icon(Icons.android, color: Colors.white),
                            gapW(15),
                            Text(
                              'My other apps',
                              style: TextUtils.title3(context: context),
                            ),
                          ],
                        ),
                      ),
                      gapH(30),

                      GestureDetector(
                        onTap: () => Get.to(ContactPage()),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail_outline_rounded,
                              color: Colors.white,
                            ),
                            gapW(15),
                            Text(
                              'Contact',
                              style: TextUtils.title3(context: context),
                            ),
                          ],
                        ),
                      ),
                      gapH(30),

                      GestureDetector(
                        onTap: () => Get.to(BuyThisAppPage()),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),
                            gapW(15),
                            Text(
                              'Buy this app',
                              style: TextUtils.title3(context: context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
