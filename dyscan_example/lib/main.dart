import 'package:dyscan_example/constants/app_colors.dart';
import 'package:dyscan_example/views/card_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DyScan Example',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.primaryColor,
        ),
      ),
      home: const CardScanScreen(),
    );
  }
}
