import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_theme.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';
import 'package:ghanshyam_mahotsav/view/spash_screen.dart';

void main() {
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
      home: SplashScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Locale _locale = const Locale('en'); // Default locale
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLocale(); // Load saved locale preference on app start
//   }
//
//   void _loadLocale() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String languageCode = prefs.getString('language_code') ?? 'en';
//     setState(() {
//       _locale = Locale(languageCode);
//     });
//   }
//
//   void _changeLanguage(String languageCode) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('language_code', languageCode);
//     setState(() {
//       _locale = Locale(languageCode);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: [
//         const Locale('en', ''), // English
//         const Locale('fr', ''), // French
//         // Add more locales as needed
//       ],
//       locale: _locale,
//       // Your app's home page or initial widget
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Language Demo'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () => _changeLanguage('en'),
//                 child: Text('English'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _changeLanguage('fr'),
//                 child: Text('French'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
