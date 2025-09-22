import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_expense_tracker/core/constants/assets_svg_constants.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyThisAppPage extends StatelessWidget {
  const BuyThisAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Buy this app', context),
      body: DefaultMarginWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH(10),
            //====================
            //Intro
            //====================
            Text(
              style: TextUtils.title3(context: context),
              'This app is developed in Flutter which can be used to build both Android, iOS and web app in a single codebase. If you are interested, please contact me.',
            ),
            gapH(35),

            //======================
            //Contact infos
            //======================
            Text(
              style: TextUtils.title3(context: context),
              'Email:  isgacademy1@gmail.com',
            ),
            gapH(5),
            Text(
              style: TextUtils.title3(context: context),
              'Whatsapp:  +8801781873788',
            ),
            gapH(25),

            //======================
            //Facebook link
            //======================
            Row(
              children: [
                Text(style: TextUtils.title3(context: context), 'Facebook:'),
                gapW(20),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                      'https://www.facebook.com/share/1RAoeNX5SZ/',
                    );
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: SvgPicture.asset(
                    AssetsSVGConst.facebook,
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
