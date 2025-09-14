import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/constants/assets_img_constants.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/button_primary.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MyOtherApps extends StatelessWidget {
  const MyOtherApps({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Scaffold(
      appBar: appbarCommon('My other apps', context),
      body: DefaultMarginWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH(10),
              Text(
                style: TextUtils.title3(context: context),
                '(Click on the icon to download)',
              ),
              gapH(50),

              //======================
              //Al Quran app link
              //======================
              Text(style: TextUtils.title2(context: context), 'Al Quran'),
              gapH(10),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.quran.inshirah',
                  );
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: Image.asset(
                  AssetsImgConst.alQuran,
                  width: 75,
                  fit: BoxFit.contain,
                ),
              ),
              gapH(30),

              //======================
              //Quran teacher: English
              //======================
              Text(
                style: TextUtils.title2(context: context),
                'Quran teacher: Easy learning',
              ),
              gapH(10),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.easy.quran.learning.inshirah',
                  );
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    AssetsImgConst.qtEnglish,
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              gapH(30),

              //======================
              //Quran teacher: bangla
              //======================
              Text(
                style: TextUtils.title2(context: context),
                'সহজ কোরআন শিক্ষা',
              ),
              gapH(10),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.bangla.quran.teacher',
                  );
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    AssetsImgConst.qtBangla,
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              gapH(70),

              ButtonPrimary(
                text: 'See my all apps',
                bgColor: theme.darkLight,
                textColor: theme.golden,
                boxshadow: false,
                borderRadius: 5,
                onPressed: () async {
                  final url = Uri.parse(
                    'https://play.google.com/store/apps/dev?id=6484057817938966744',
                  );
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
