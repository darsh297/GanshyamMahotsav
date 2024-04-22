import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_theme.dart';
import 'package:ghanshyam_mahotsav/utils/loacl_strings.dart';
import 'package:ghanshyam_mahotsav/view/home_page.dart';

// Text('First Name'.tr),  Get.updateLocale(Locale('hi', 'IN'));
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1UZwhQmEe0f-POtlAfZNiN9ZO27bwmSY",
      appId: "1:456460570449:android:13251b2dbfaef86dd54d70",
      messagingSenderId: "456460570449",
      projectId: "easstemple-b710e",
    ),
  );
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: AppColors.scaffoldColor, // status bar color
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppTheme appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme.themeData,
      title: 'Ghanshyam Mahotsav',
      translations: LocalStrings(),
      locale: Locale('en', 'US'),
      home: HomePage(),
    );
  }
}
