import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';

class HireMePage extends StatelessWidget {
  const HireMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Hire me', context),
      body: DefaultMarginWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH(10),
              //========================
              //Intro text
              //=======================
              Text(
                style: TextUtils.title3(context: context),
                'Hey there, my name is saleheen. A passionate mobile app developer and UI/UX designer. Achieved top rated in Upwork and level 2 in Fiverr. Worked with hundreads of clients worldwide. I work in flutter which is used for cross platform development (Android, iOS, Web). If you have any app idea that you want to develop or need any app interface designed, feel free to contact me.',
              ),
              gapH(50),

              //========================
              //Upwork and fiverr links
              //========================
              // _workplaceLinks(context),
              // gapH(70),

              //=====================
              //Contact infos
              //=====================
              _contactInfos(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _workplaceLinks(BuildContext context) {
  //   final theme = CustomTheme.of(context);
  //   return Column(
  //     children: [
  //       //==========================
  //       //Upwork
  //       //==========================
  //       Row(
  //         children: [
  //           SvgPicture.asset(
  //             AssetsSVGConst.upwork,
  //             width: 35,
  //             height: 35,
  //             colorFilter: ColorFilter.mode(theme.primary, BlendMode.srcIn),
  //           ),
  //           gapW(15),

  //           ButtonPrimary(
  //             text: 'Visit my upwork profile',
  //             bgColor: theme.darkLight,
  //             textColor: theme.golden,
  //             width: 200,
  //             boxshadow: false,
  //             borderRadius: 5,
  //             onPressed: () async {
  //               final url = Uri.parse(
  //                 'https://www.upwork.com/freelancers/~014b24220afe0f5459?mp_source=share',
  //               );
  //               await launchUrl(url, mode: LaunchMode.externalApplication);
  //             },
  //           ),
  //         ],
  //       ),
  //       gapH(20),

  //       //===========================
  //       //Fiverr
  //       //============================
  //       Row(
  //         children: [
  //           SvgPicture.asset(
  //             AssetsSVGConst.fiverr,
  //             width: 35,
  //             height: 35,
  //             colorFilter: ColorFilter.mode(Color(0xFF8DF573), BlendMode.srcIn),
  //           ),
  //           gapW(15),

  //           ButtonPrimary(
  //             text: 'Visit my fiverr profile',
  //             bgColor: theme.darkLight,
  //             textColor: theme.golden,
  //             boxshadow: false,
  //             width: 200,
  //             borderRadius: 5,
  //             onPressed: () async {
  //               final url = Uri.parse('https://www.fiverr.com/saleheen1');
  //               await launchUrl(url, mode: LaunchMode.externalApplication);
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _contactInfos(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          style: TextUtils.title3(context: context, color: theme.golden),
          'Contact me:',
        ),
        gapH(15),

        Text(
          style: TextUtils.title3(context: context),
          'Whatsapp: +8801781873788',
        ),
        gapH(15),

        Text(
          style: TextUtils.title3(context: context),
          'Telegram: +8801781873788',
        ),
        gapH(15),

        Text(
          style: TextUtils.title3(context: context),
          'Email: smsaleheen3@gmail.com',
        ),
      ],
    );
  }
}
