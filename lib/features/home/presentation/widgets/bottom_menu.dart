import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/features/home/data/controller/navigation_controller.dart';
import 'package:simple_expense_tracker/features/home/presentation/widgets/bottom_menu_nav_item.dart';

class BottomMenu extends StatelessWidget {
  final GlobalKey historyTabKey;
  const BottomMenu({super.key, required this.historyTabKey});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (nc) {
        return Container(
          height: 85,
          padding: EdgeInsets.only(bottom: 10, top: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: CustomTheme.of(context).cardColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomMenuNavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isActive: nc.selectedIndex == 0,
                    onTap: () {
                      nc.changeSeletectedIndex(0);
                    },
                  ),

                  BottomMenuNavItem(
                    key: historyTabKey,
                    icon: Icons.map_outlined,
                    label: 'History',
                    isActive: nc.selectedIndex == 1,
                    onTap: () {
                      nc.changeSeletectedIndex(1);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
