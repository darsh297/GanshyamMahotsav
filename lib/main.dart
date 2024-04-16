import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_theme.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppTheme appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme.themeData,
      title: 'Ghanshyam Mahotsav',
      home: LoginPage(),
    );
  }
}
