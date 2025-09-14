import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_expense_tracker/core/constants/assets_img_constants.dart';
import 'package:simple_expense_tracker/core/utils/text_utils.dart';
import 'package:simple_expense_tracker/core/utils/ui_const.dart';
import 'package:simple_expense_tracker/core/widgets/appbar_common.dart';
import 'package:simple_expense_tracker/core/widgets/default_margin_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportMePage extends StatelessWidget {
  const SupportMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Support me', context),
      body: DefaultMarginWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH(10),
              //=====================
              //Intro
              //=====================
              Text(
                style: TextUtils.title3(context: context),
                'It was a hard task to develop this app. Unlike many religious apps out there, this app doesn’t show ads, as sometimes ads may show haram things. So, we decided not to earn by showing ads to you. If you have benefited from this app and want to appreciate our hard work, please consider supporting us. To support, please click the yellow button below.',
              ),
              gapH(40),

              //======================
              //Buy me a coffeee section
              //======================
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse('https://buymeacoffee.com/saleheen');
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
                child: Image.asset(
                  AssetsImgConst.bmcButton,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
              gapH(70),

              //========================
              //Bkash section
              //=======================
              Text(
                style: TextUtils.title3(context: context),
                'If you are from Bangladesh, you can use the method below:',
              ),
              gapH(40),

              _bkashSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bkashSection(BuildContext context) {
    const contactNumber = '01781873788';
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 1),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Row(
                children: [
                  Image.asset(
                    AssetsImgConst.bkash,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                  gapW(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(style: TextUtils.title3(context: context), 'বিকাশ'),
                      Text(
                        style: TextUtils.title3(context: context),
                        '(Send Money)',
                      ),
                    ],
                  ),
                ],
              ),
              gapH(15),

              Text(style: TextUtils.title3(context: context), contactNumber),
              Text(
                style: TextUtils.title3(context: context),
                'Account type: Personal',
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: contactNumber));

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bkash number copied to clipboard'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            icon: Icon(Icons.copy, size: 40),
          ),
        ],
      ),
    );
  }
}
