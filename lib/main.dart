import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_theme.dart';
import 'package:ghanshyam_mahotsav/utils/loacl_strings.dart';

import 'view/spash_screen.dart';

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
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.scaffoldColor, // status bar color
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppTheme appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme.themeData,
      title: 'Ghanshyam Mahotsav',
      translations: LocalStrings(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      home: const SplashScreen(),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PDF Viewer',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('PDF Viewer'),
//         ),
//         body: Center(
//           child: PDFView(
//             filePath: 'https://gbihr.org/images/docs/test.pdf', // PDF URL
//             onError: (error) {
//               print('Error loading PDF: $error');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
