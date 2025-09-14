import 'package:get/get.dart';

class NavigationController extends GetxController {
  List<String> navItems = [
    "Events",
    "Community",
    "Network",
    "Chat",
  ];

  int selectedIndex = 0;

  void changeSeletectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  void setIndexToNothing() {
    Future.delayed(const Duration(milliseconds: 300), () {
      selectedIndex = -1;
      update();
    });
  }
}
