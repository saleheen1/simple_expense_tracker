import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_expense_tracker/core/constants/assets_svg_constants.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Contact', context),
      body: DefaultMarginWidget(
        child: Column(
          children: [
            gapH(10),
            //====================
            //Intro
            //====================
            Text(
              style: TextUtils.title3(context: context),
              textAlign: TextAlign.center,
              'If you have any question or feedback or found any problem in the app, you can contact to my facebook or mail me to the address below.',
            ),
            gapH(35),

            //=====================
            //Mail address
            //=====================
            Text(
              style: TextUtils.title3(context: context),
              'isgacademy1@gmail.com',
            ),
            gapH(25),

            //=====================
            //facebook link
            //====================
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
      ),
    );
  }
}
