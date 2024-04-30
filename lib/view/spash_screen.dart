import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/shared_preference.dart';
import 'package:ghanshyam_mahotsav/utils/string_utils.dart';
import 'package:ghanshyam_mahotsav/view/home_page.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLogin(context) async {
    String? token = await SharedPreferenceClass().retrieveData(StringUtils.prefUserTokenKey);
    print('Token Splesh screen $token');
    Future.delayed(
      Duration(seconds: 1),
      () {
        token == null ? Get.offAll(() => LoginPage()) : Get.offAll(() => const HomePage());
      },
    );
  }

  @override
  void initState() {
    checkLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Hero(
            tag: 'logo',
            child: Material(
              type: MaterialType.transparency,
              child: Image.asset(StringUtils.logo),
            ),
          ),
        ),
      ),
    );
  }
}
