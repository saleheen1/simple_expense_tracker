import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/core/bindings/all_bindings.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';
import 'package:simple_expense_tracker/core/themes/dark_theme.dart';
import 'package:simple_expense_tracker/features/home/presentation/main_scaffold.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initBindings();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      customThemeData: darkTheme,
      child: GetMaterialApp(
        title: 'Simple Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: darkTheme.primary,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          brightness: Brightness.dark,
        ),
        home: const MainScaffold(),
      ),
    );
  }
}
