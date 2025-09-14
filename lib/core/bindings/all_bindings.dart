import 'package:get/get.dart';
import 'package:simple_expense_tracker/features/home/data/controller/navigation_controller.dart';

Future<void> initBindings() async {
  Get.put(NavigationController());
}
