import 'package:flutter/material.dart';
import 'package:ghanshyam_mahotsav/utils/string_utils.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
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
